// (C) 2001-2022 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



///////////////////////////////////////////////////////////////////////////////
// EMIF example design component: local_reset_req combiner.
//
// The component shows how to combine the local_reset_req and the local_reset_done
// signal from multiple interfaces into a single set. The example works even if
// the interfaces are asynchronous to each other.
//
// The combined local_reset_req and local_reset_done signal provides a simpler
// interface to reset multiple EMIF instantiations. Specifically:
//
//    * When the user sends a reset request through the combined local_reset_req
//      signal, the request is forwarded to all interfaces.
//    * The components asserts the combined local_reset_done if an only if
//      all interfaces are ready for a reset request.
//
// The component does not guarantee that all interfaces enter reset at the same
// time, nor does it guarantee that all interfaces exit reset at the same time.
//
// The local_reset_req and local_reset_done signal exposed by this component
// follow the same protocol as the respective signals exposed directly by the
// EMIF IP, with additional requirements:
//
//    * local_reset_req must have minimum pulse width of 2 input clk cycles
//      (instead of 2 EMIF core clock cycles as defined by the EMIF IP, since
//       that requirement does not make sense in this context)
//
//    * The input clk clock cannot be faster than 32 times of the slowest
//      EMIF core clock amongst all EMIF IPs. (e.g. if the slowest EMIF IP
//      connected to this module runs at 10MHz inside the FPGA core fabric,
//      input clk needs to slower than 320MHz). If this condition fails,
//      the local_reset_req signals outbound to EMIF IPs will fail to meet
//      the minimum pulse width requirement.
//
//    * The local_reset_done input signals coming from the EMIF IPs can be
//      asynchronous to the local clock domain, but they must have a minimum
//      pulse width of 2 local clock cycles. Practically this should never cause
//      a problem because the local_reset_done is asserted by the EMIF IPs for
//      a very long time.
//
//    * The component exposes a reset_n signal that resets its internal
//      state machine. You must not use the emif_usr_reset_n or the afi_reset_n
//      signal coming from an EMIF IP as reset signal, to avoid a catch-22
//      situation.
//
// The component also implements ISSP for the local_reset_req and
// local_reset_done signal for control and observation via quartus_stp Tcl script.
//
///////////////////////////////////////////////////////////////////////////////

module altera_emif_local_reset_combiner # (
   parameter NUM_OF_RESET_REQ_IFS = 1,
   parameter NUM_OF_RESET_STATUS_IFS = 1
) (
   input  logic clk,
   input  logic reset_n,

   input  logic local_reset_req,
   output logic local_reset_done,

   output logic local_reset_req_out_0,
   output logic local_reset_req_out_1,
   output logic local_reset_req_out_2,
   output logic local_reset_req_out_3,
   output logic local_reset_req_out_4,
   output logic local_reset_req_out_5,
   output logic local_reset_req_out_6,
   output logic local_reset_req_out_7,
   output logic local_reset_req_out_8,
   output logic local_reset_req_out_9,
   output logic local_reset_req_out_10,
   output logic local_reset_req_out_11,
   output logic local_reset_req_out_12,
   output logic local_reset_req_out_13,
   output logic local_reset_req_out_14,
   output logic local_reset_req_out_15,

   input  logic local_reset_done_in_0,
   input  logic local_reset_done_in_1,
   input  logic local_reset_done_in_2,
   input  logic local_reset_done_in_3,
   input  logic local_reset_done_in_4,
   input  logic local_reset_done_in_5,
   input  logic local_reset_done_in_6,
   input  logic local_reset_done_in_7,
   input  logic local_reset_done_in_8,
   input  logic local_reset_done_in_9,
   input  logic local_reset_done_in_10,
   input  logic local_reset_done_in_11,
   input  logic local_reset_done_in_12,
   input  logic local_reset_done_in_13,
   input  logic local_reset_done_in_14,
   input  logic local_reset_done_in_15
);
   timeunit 1ns;
   timeprecision 1ps;

   typedef enum {
      WAIT_ALL_RESET_DONE,
      WAIT_USER_RESET_REQ_1ST_DEASSERT,
      WAIT_USER_RESET_REQ_ASSERT,
      WAIT_USER_RESET_REQ_2ND_DEASSERT,
      ASSERT_EMIF_RESET_REQ,
      DEASSERT_EMIF_RESET_REQ
   } state_t;

   // Data synchronizer length
   localparam DATA_SYNC_LENGTH = 3;

   // Reset synchronizer length
   // The async reset to the reset synchronizer has MCP setup=4, hold=3 to
   // relax timing. This means the async reset arrival time has a max variance
   // of 4 cycles, which means the output of synchronizer FF 0..3 can all be
   // metastable. For safety set sychronzier length to be 4+3=7.
   localparam RESET_SYNC_LENGTH = 7;

   ////////////////////////////////////////////////////////////////////
   // Synchronize reset_n to local domain
   ////////////////////////////////////////////////////////////////////
   logic sync_reset_n;
   altera_std_synchronizer_nocut # (
      .depth     (RESET_SYNC_LENGTH),
      .rst_value (0)
   ) reset_n_sync_inst (
      .clk     (clk),
      .reset_n (reset_n),
      .din     (1'b1),
      .dout    (sync_reset_n)
   );

   ////////////////////////////////////////////////////////////////////
   // Synchronize local_reset_req data sources to local domain
   ////////////////////////////////////////////////////////////////////
   logic local_reset_req_issp_n;
   logic local_reset_req_issp_n_sync;
   logic local_reset_req_issp_sync;

`ifdef ALTERA_EMIF_ENABLE_ISSP
   ////////////////////////////////////////////////////////////////////
   // For compatiblity with previous ISSP that drives global_reset_n, we keep
   // the signal as active-low.
   ////////////////////////////////////////////////////////////////////
   altsource_probe #(
      .sld_auto_instance_index ("YES"),
      .sld_instance_index      (0),
      .instance_id             ("RSTN"),
      .probe_width             (0),
      .source_width            (1),
      .source_initial_value    ("1"),
      .enable_metastability    ("NO")
   ) local_reset_req_issp_n_inst (
      .source  (local_reset_req_issp_n)
   );

   altsource_probe #(
      .sld_auto_instance_index ("YES"),
      .sld_instance_index      (0),
      .instance_id             ("RSTD"),
      .probe_width             (1),
      .source_width            (0),
      .source_initial_value    ("0"),
      .enable_metastability    ("NO")
   ) local_reset_done_issp_inst (
      .probe  (local_reset_done)
   );
`else
   assign local_reset_req_issp_n = 1'b1;
`endif

   altera_std_synchronizer_nocut # (
      .depth     (DATA_SYNC_LENGTH),
      .rst_value (1)
   ) local_reset_req_issp_n_sync_inst (
      .clk     (clk),
      .reset_n (sync_reset_n),
      .din     (local_reset_req_issp_n),
      .dout    (local_reset_req_issp_n_sync)
   );
   assign local_reset_req_issp_sync = ~local_reset_req_issp_n_sync;

   ////////////////////////////////////////////////////////////////////
   // Synchronize local_reset_req sources to local domain
   ////////////////////////////////////////////////////////////////////
   logic local_reset_req_sync;
   altera_std_synchronizer_nocut # (
      .depth     (DATA_SYNC_LENGTH),
      .rst_value (0)
   ) local_reset_req_sync_inst (
      .clk     (clk),
      .reset_n (sync_reset_n),
      .din     (local_reset_req),
      .dout    (local_reset_req_sync)
   );

   // Actual request signal can come from either ISSP or module port
   logic local_reset_req_real;
   assign local_reset_req_real = local_reset_req_sync || local_reset_req_issp_sync;

   // local_reset_req_out is the actual local_reset_req going out to EMIF IPs.
   // It is an output of the state machine below.
   logic local_reset_req_out;

   ////////////////////////////////////////////////////////////////////
   // Bus <=> Signals
   ////////////////////////////////////////////////////////////////////
   assign local_reset_req_out_0  = (NUM_OF_RESET_REQ_IFS > 0 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_1  = (NUM_OF_RESET_REQ_IFS > 1 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_2  = (NUM_OF_RESET_REQ_IFS > 2 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_3  = (NUM_OF_RESET_REQ_IFS > 3 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_4  = (NUM_OF_RESET_REQ_IFS > 4 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_5  = (NUM_OF_RESET_REQ_IFS > 5 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_6  = (NUM_OF_RESET_REQ_IFS > 6 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_7  = (NUM_OF_RESET_REQ_IFS > 7 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_8  = (NUM_OF_RESET_REQ_IFS > 8 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_9  = (NUM_OF_RESET_REQ_IFS > 9 ) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_10 = (NUM_OF_RESET_REQ_IFS > 10) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_11 = (NUM_OF_RESET_REQ_IFS > 11) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_12 = (NUM_OF_RESET_REQ_IFS > 12) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_13 = (NUM_OF_RESET_REQ_IFS > 13) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_14 = (NUM_OF_RESET_REQ_IFS > 14) ? local_reset_req_out : 1'b0;
   assign local_reset_req_out_15 = (NUM_OF_RESET_REQ_IFS > 15) ? local_reset_req_out : 1'b0;

   logic [15:0] local_reset_done_in_async;
   assign local_reset_done_in_async = { (NUM_OF_RESET_STATUS_IFS > 15) ? local_reset_done_in_15 : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 14) ? local_reset_done_in_14 : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 13) ? local_reset_done_in_13 : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 12) ? local_reset_done_in_12 : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 11) ? local_reset_done_in_11 : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 10) ? local_reset_done_in_10 : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 9 ) ? local_reset_done_in_9  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 8 ) ? local_reset_done_in_8  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 7 ) ? local_reset_done_in_7  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 6 ) ? local_reset_done_in_6  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 5 ) ? local_reset_done_in_5  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 4 ) ? local_reset_done_in_4  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 3 ) ? local_reset_done_in_3  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 2 ) ? local_reset_done_in_2  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 1 ) ? local_reset_done_in_1  : 1'b1,
                                        (NUM_OF_RESET_STATUS_IFS > 0 ) ? local_reset_done_in_0  : 1'b1};

   ////////////////////////////////////////////////////////////////////
   // Instantiate logic to:
   //
   // 1) Synchronize the local_reset_done input signals from EMIFs to
   //    the local clock domain, since the various interfaces may
   //    be asynchronous to each other.
   //
   // 2) Detect a 0 from the synchronized local_reset_done signal when
   //    the detection mode is enabled.
   //
   ////////////////////////////////////////////////////////////////////
   logic [NUM_OF_RESET_STATUS_IFS-1:0] local_reset_done_in_sync;
   logic [NUM_OF_RESET_STATUS_IFS-1:0] reset_done_zero_detected;
   logic reset_done_zero_detect_en;

   generate
      genvar i;
      for (i = 0; i < NUM_OF_RESET_STATUS_IFS; ++i) begin: status
         // Synchronize the local_reset_done signal to the local clock domain.
         // This imposes a requirement that the local_reset_done must have a minimum
         // pulse width of 2 local clock cycles. Since local_reset_done is
         // deasserted for as long as it takes to reset and calibrate an
         // interface this is pratically never a problem if any EMIF clock or
         // EMIF PLL refclk is clocking the synchronizer.
         altera_std_synchronizer_nocut # (
            .depth     (DATA_SYNC_LENGTH),
            .rst_value (0)
         ) local_reset_done_in_sync_inst (
            .clk     (clk),
            .reset_n (sync_reset_n),
            .din     (local_reset_done_in_async[i]),
            .dout    (local_reset_done_in_sync[i])
         );

         // Detect a 0 from local_reset_done_in_sync when detection mode is enabled.
         always_ff @(posedge clk or negedge sync_reset_n) begin
            if (~sync_reset_n) begin
               reset_done_zero_detected[i] <= 1'b0;
            end else begin
               if (reset_done_zero_detect_en && !local_reset_done_in_sync[i])
                  reset_done_zero_detected[i] <= 1'b1;
               else
                  reset_done_zero_detected[i] <= 1'b0;
            end
         end
      end
   endgenerate

   ////////////////////////////////////////////////////////////////////
   // Counter to extend output local_reset_req to guarantee we
   // satisfy minimum pulse width of all EMIF IPs.
   // RESET_REQ_ASSERT_CNT_WIDTH being set to 7 means we will assert
   // local_reset_req for 64 local clock cycles. Since the minimum
   // pulse width of EMIF IP is 2 core clock cycles, this allows the
   // local clock be at most 32 times faster than the slowest EMIF
   // core clock.
   ////////////////////////////////////////////////////////////////////
   localparam RESET_REQ_ASSERT_CNT_WIDTH = 7;
   logic [RESET_REQ_ASSERT_CNT_WIDTH-1:0] reset_req_assert_cnt;
   logic clear_reset_req_assert_cnt;
   always_ff @(posedge clk or negedge sync_reset_n) begin
      if (~sync_reset_n) begin
         reset_req_assert_cnt <= '0;
      end else begin
         if (clear_reset_req_assert_cnt)
            reset_req_assert_cnt <= reset_req_assert_cnt + 1'b1;
         else
            reset_req_assert_cnt <= '0;
      end
   end

   ////////////////////////////////////////////////////////////////////
   // State machine
   ////////////////////////////////////////////////////////////////////
   state_t state /* synthesis ignore_power_up */;

   always_ff @(posedge clk or negedge sync_reset_n)
   begin
      if (~sync_reset_n) begin
         state <= WAIT_ALL_RESET_DONE;
      end else begin
         case (state)
            WAIT_ALL_RESET_DONE:
               // Wait until all interfaces are ready before accepting reset request from user
               if (&local_reset_done_in_sync)
                  state <= (local_reset_req_real ? WAIT_USER_RESET_REQ_1ST_DEASSERT : WAIT_USER_RESET_REQ_ASSERT);
            WAIT_USER_RESET_REQ_1ST_DEASSERT:
               // Wait for reset request deassertion from user (i.e. low part of a pulse)
               if (~local_reset_req_real)
                  state <= WAIT_USER_RESET_REQ_ASSERT;
            WAIT_USER_RESET_REQ_ASSERT:
               // Wait for reset request assertion from user (i.e. high part of a pulse)
               if (local_reset_req_real)
                  state <= WAIT_USER_RESET_REQ_2ND_DEASSERT;
            WAIT_USER_RESET_REQ_2ND_DEASSERT:
               // Wait for reset request deassertion from user (i.e. completion of pulse)
               if (~local_reset_req_real)
                  state <= ASSERT_EMIF_RESET_REQ;
            ASSERT_EMIF_RESET_REQ:
               // Assert reset request to EMIF(s) for multiple cycles to satisfy min pulse requirements
               if (reset_req_assert_cnt[RESET_REQ_ASSERT_CNT_WIDTH-1] == 1'b1)
                  state <= DEASSERT_EMIF_RESET_REQ;
            DEASSERT_EMIF_RESET_REQ:
               // Deassert reset request to EMIF(s) to complete the request (i.e. completion of pulse).
               // Wait until we've seen local_reset_done deasserted for all interfaces, before
               // transitioning back to WAIT_ALL_RESET_DONE to wait for all local_reset_done being
               // re-asserted again. Note that interfaces may deassert/assert local_reset_done
               // completely asynchronously to each other (e.g. an interface may deassert local_reset_done
               // and assert local_reset_done before another interface deassets local_reset_done)
               if (&reset_done_zero_detected)
                  state <= WAIT_ALL_RESET_DONE;
            default:
               state <= WAIT_ALL_RESET_DONE;
         endcase
      end
   end

   ////////////////////////////////////////////////////////////////////
   // State machine output signals
   ////////////////////////////////////////////////////////////////////
   assign reset_done_zero_detect_en = (state == DEASSERT_EMIF_RESET_REQ) ? 1'b1 : 1'b0;
   assign clear_reset_req_assert_cnt = (state == ASSERT_EMIF_RESET_REQ) ? 1'b1 : 1'b0;

   assign local_reset_done = (state == WAIT_USER_RESET_REQ_1ST_DEASSERT ||
                              state == WAIT_USER_RESET_REQ_ASSERT ||
                              state == WAIT_USER_RESET_REQ_2ND_DEASSERT) ? 1'b1 : 1'b0;

   always_ff @(posedge clk or negedge sync_reset_n)
   begin
      if (~sync_reset_n) begin
         local_reset_req_out <= 1'b0;
      end else begin
         local_reset_req_out <= (state == ASSERT_EMIF_RESET_REQ) ? 1'b1 : 1'b0;
      end
   end
endmodule
