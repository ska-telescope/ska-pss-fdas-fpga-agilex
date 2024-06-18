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


//////////////////////////////////////////////////////////////////////////////////
// This module implements a simple Avalon-MM traffic generator to exercise
// the simulation memory preload feature. It generates a preload-data file
// containing pseudo-random data, and then reads out the memory data and
// compares against the preloaded data.
//
//////////////////////////////////////////////////////////////////////////////
module altera_emif_avl_tg_driver_sim_mem_validate # (

   parameter DEVICE_FAMILY                          = "",
   parameter PROTOCOL_ENUM                          = "",

   ////////////////////////////////////////////////////////////
   // AVALON SIGNAL WIDTHS
   ////////////////////////////////////////////////////////////
   parameter TG_AVL_ADDR_WIDTH                      = 33,
   parameter TG_AVL_WORD_ADDR_WIDTH                 = 27,
   parameter TG_AVL_SIZE_WIDTH                      = 7,
   parameter TG_AVL_DATA_WIDTH                      = 288,
   parameter TG_AVL_BE_WIDTH                        = 36,

   ////////////////////////////////////////////////////////////
   // DRIVER CONFIGURATION
   ////////////////////////////////////////////////////////////

   // Specifies how many pseudo-random address/data patterns to generate.
   // The driver supports the following pre-defined modes:
   // SHORT
   // MEDIUM
   parameter TG_TEST_DURATION                       = "SHORT",

   // Specifies alignment criteria for Avalon-MM word addresses and burst count
   parameter AMM_WORD_ADDRESS_DIVISIBLE_BY          = 1,
   parameter AMM_BURST_COUNT_DIVISIBLE_BY           = 1,

   // Indicates whether a separate interface exists for reads and writes.
   // Typically set to 1 for QDR-style interfaces where concurrent reads and
   // writes are possible
   parameter TG_SEPARATE_READ_WRITE_IFS             = 0,

   // Simulation memory model preload filename
   parameter SIM_MEMORY_PRELOAD_EMIF_FILE           = "",

   // Seed for pseudo-random number generator
   parameter TG_LFSR_SEED                           = 36'b000000111110000011110000111000110010,

   // If set to "1", the driver generates pseudo-random byte enables
   parameter TG_RANDOM_BYTE_ENABLE                  = 0

) (
   // Clock and reset
   input  logic                                     clk,
   input  logic                                     reset_n,

   // Avalon master signals
   input  logic                                     avl_ready,
   output logic                                     avl_write_req,
   output logic                                     avl_read_req,
   output logic [TG_AVL_ADDR_WIDTH-1:0]             avl_addr,
   output logic [TG_AVL_SIZE_WIDTH-1:0]             avl_size,
   output logic [TG_AVL_BE_WIDTH-1:0]               avl_be,
   output logic [TG_AVL_DATA_WIDTH-1:0]             avl_wdata,
   input  logic                                     avl_rdata_valid,
   input  logic [TG_AVL_DATA_WIDTH-1:0]             avl_rdata,

   // Avalon master signals (Dedicated write interface for QDR-style where concurrent reads and writes are possible)
   input  logic                                     avl_ready_w,
   output logic [TG_AVL_ADDR_WIDTH-1:0]             avl_addr_w,
   output logic [TG_AVL_SIZE_WIDTH-1:0]             avl_size_w,

   // Driver status signals
   output logic                                     pass,
   output logic                                     fail,
   output logic                                     timeout,
   output logic [TG_AVL_DATA_WIDTH-1:0]             pnf_per_bit,
   output logic [TG_AVL_DATA_WIDTH-1:0]             pnf_per_bit_persist
) /* synthesis dont_merge syn_preserve = 1 */;
   timeunit 1ns;
   timeprecision 1ps;

   typedef enum int unsigned {
      RESET,
      INIT,
      ISSUE_READ,
      WAIT_READ_ACCEPTED,
      WAIT_READ_DONE,
      NEXT_LOOP,
      DONE_PASS,
      DONE_FAIL
   } state_t;

   // Determines how many loops to perform. Number of loops = 2^LOOP_COUNTER_WIDTH - 1.
   localparam LOOP_COUNT_WIDTH = 1;

   // Number of pseudo-random address patterns to generate.
   localparam TG_NUM_RANDOM_ADDRESS_PATTERNS = (TG_TEST_DURATION == "SHORT") ? 500 : (
                                                                               5000 );

   // Total number of address patterns to test.
   localparam TG_NUM_ADDRESS_PATTERNS = TG_AVL_WORD_ADDR_WIDTH + TG_NUM_RANDOM_ADDRESS_PATTERNS;

   // Number of data bits that each byte-enable bit corresponds to.
   localparam BE_GROUP_SIZE = TG_AVL_DATA_WIDTH / TG_AVL_BE_WIDTH;

   // synthesis translate_off

   // Register read data signals to ease timing closure
   logic                                avl_rdata_valid_r;
   logic [TG_AVL_DATA_WIDTH-1:0]        avl_rdata_r;

   logic                                avl_ready_for_write;

   logic [TG_AVL_WORD_ADDR_WIDTH-1:0]   addr_queue [$];
   logic [TG_AVL_DATA_WIDTH-1:0]        golden_data_table [*];
   logic [TG_AVL_BE_WIDTH-1:0]          golden_be_table [*];

   logic [TG_AVL_DATA_WIDTH-1:0]        nxt_golden_data;
   logic [TG_AVL_BE_WIDTH-1:0]          nxt_golden_be;
   logic [TG_AVL_DATA_WIDTH-1:0]        nxt_pnf_per_bit;
   logic                                nxt_avl_write_req;
   logic                                nxt_avl_read_req;
   logic [TG_AVL_SIZE_WIDTH-1:0]        nxt_burst_count;
   logic [TG_AVL_WORD_ADDR_WIDTH-1:0]   nxt_word_addr;
   logic [TG_AVL_WORD_ADDR_WIDTH-1:0]   nxt_word_addr_int;
   logic [LOOP_COUNT_WIDTH-1:0]         nxt_loop_count;
   logic [TG_AVL_WORD_ADDR_WIDTH-1:0]   nxt_ttl_words_read;

   logic [TG_AVL_DATA_WIDTH-1:0]        golden_data;
   logic [TG_AVL_BE_WIDTH-1:0]          golden_be;
   logic [TG_AVL_DATA_WIDTH-1:0]        golden_bit_enable;
   logic [TG_AVL_WORD_ADDR_WIDTH-1:0]   word_addr;
   logic [TG_AVL_SIZE_WIDTH-1:0]        burst_count;
   logic [LOOP_COUNT_WIDTH-1:0]         loop_count;

   logic [TG_AVL_WORD_ADDR_WIDTH-1:0]   ttl_words_read;

   state_t                              state;
   state_t                              nxt_state;

   function automatic [ TG_AVL_WORD_ADDR_WIDTH + TG_AVL_DATA_WIDTH + TG_AVL_BE_WIDTH -1:0] generate_random_number ();
      parameter WIDTH = TG_AVL_WORD_ADDR_WIDTH + TG_AVL_DATA_WIDTH + TG_AVL_BE_WIDTH;
      integer   i;
      for (i = 0; i < WIDTH; i = i + 32) begin
         generate_random_number[i +: 32]    = $urandom_range({32{1'b1}}, 0);
      end
   endfunction

   // Generate pseudo-random address/data patterns and save to preload-data file
   task automatic generate_mem_preload_data ();
      logic   [TG_AVL_WORD_ADDR_WIDTH-1:0]   word_addr_local;
      logic   [TG_AVL_DATA_WIDTH-1:0]        data_local;
      logic   [TG_AVL_BE_WIDTH-1:0]          be_local;
      logic   [TG_AVL_WORD_ADDR_WIDTH-1:0]   word_addr_num;

      integer                                fd;
      integer                                addr_bit_num;
      integer                                addr_pattern_num;

      addr_queue.delete();
      golden_data_table.delete();
      golden_be_table.delete();

      // Simple address patterns
      // The goal is to exercise all address bits
      for (addr_bit_num = 0; addr_bit_num < TG_AVL_WORD_ADDR_WIDTH; addr_bit_num = addr_bit_num + 1) begin
         word_addr_local                     = 1 << addr_bit_num;
         data_local                          = '1;
         be_local                            = TG_RANDOM_BYTE_ENABLE ? '1 : '1;

         addr_queue.push_back(word_addr_local);
         golden_data_table[word_addr_local]  = data_local;
         golden_be_table[word_addr_local]    = be_local;
      end

      // Complex address patterns
      for (addr_pattern_num = 0; addr_pattern_num < TG_NUM_RANDOM_ADDRESS_PATTERNS; addr_pattern_num = addr_pattern_num + 1) begin
         word_addr_local                     = generate_random_number();
         data_local                          = generate_random_number();
         be_local                            = TG_RANDOM_BYTE_ENABLE ? generate_random_number() : '1;

         addr_queue.push_back(word_addr_local);
         golden_data_table[word_addr_local]  = data_local;
         golden_be_table[word_addr_local]    = be_local;
      end

      // Create preload-data file
      fd = $fopen(SIM_MEMORY_PRELOAD_EMIF_FILE, "w");
      if (fd != 0) begin
         for (word_addr_num = 0; word_addr_num < addr_queue.size(); word_addr_num = word_addr_num + 1) begin
            word_addr_local                     = addr_queue[word_addr_num];
            data_local                          = golden_data_table[word_addr_local];
            be_local                            = golden_be_table[word_addr_local];
            $fwrite(fd, "EMIF: ADDRESS=%h DATA=%h BYTEENABLE=%h\n", word_addr_local, data_local, be_local);
         end
      end else begin
         $fatal(1, "Error: Unable to create file %s!", SIM_MEMORY_PRELOAD_EMIF_FILE);
      end
      $fflush(fd);
      $fclose(fd);
   endtask

   initial begin
      // Generate simulation memory preload-data file
      generate_mem_preload_data();
   end

   ////////////////////////////////////////////////////////////////////////////
   // The following control or externally visible signals must be reset
   ////////////////////////////////////////////////////////////////////////////
   always_ff @(posedge clk)
   begin
      if (!reset_n) begin
         state             <= RESET;
         avl_write_req     <= 1'b0;
         avl_read_req      <= 1'b0;
         avl_rdata_valid_r <= 1'b0;
         loop_count        <= {'0, 1'b1};
         pnf_per_bit       <= '1;
         ttl_words_read    <= '0;
      end else begin
         state             <= nxt_state;
         avl_write_req     <= 1'b0;
         avl_read_req      <= nxt_avl_read_req;
         avl_rdata_valid_r <= avl_rdata_valid;
         loop_count        <= nxt_loop_count;
         pnf_per_bit       <= nxt_pnf_per_bit;
         ttl_words_read    <= nxt_ttl_words_read;
      end
   end

   ////////////////////////////////////////////////////////////////////////////
   // The following data signals don't need to be reset
   ////////////////////////////////////////////////////////////////////////////
   always_ff @(posedge clk)
   begin
      avl_rdata_r <= avl_rdata;
      burst_count <= nxt_burst_count;
      word_addr   <= nxt_word_addr;
      golden_data <= nxt_golden_data;
      golden_be   <= nxt_golden_be;
   end

   ////////////////////////////////////////////////////////////////////////////
   // The following are constant, to reduce the number of unnecessary C2P/P2C
   // connections.
   ////////////////////////////////////////////////////////////////////////////
   assign avl_wdata      = '0;
   assign avl_be         = '0;
   assign avl_size       = 1;
   assign avl_addr       = {word_addr, {(TG_AVL_ADDR_WIDTH-TG_AVL_WORD_ADDR_WIDTH){1'b0}}};
   assign avl_addr_w     = avl_addr;
   assign avl_size_w     = avl_size;

   assign avl_ready_for_write = (TG_SEPARATE_READ_WRITE_IFS ? avl_ready_w : avl_ready);

   // Expand byte-enable to bit-enable
   generate
     genvar be_count;
     for (be_count = 0; be_count < TG_AVL_BE_WIDTH; be_count = be_count + 1) begin: bit_enable_mapping
         assign golden_bit_enable [(be_count + 1) * BE_GROUP_SIZE - 1 : be_count * BE_GROUP_SIZE] = {BE_GROUP_SIZE{golden_be[be_count]}};
     end
   endgenerate

   ////////////////////////////////////////////////////////////////////////////
   // Status signal logic
   ////////////////////////////////////////////////////////////////////////////
   assign pass                = (state == DONE_PASS);
   assign fail                = (state == DONE_FAIL);
   assign timeout             = '0;
   assign pnf_per_bit_persist = pnf_per_bit;

   ////////////////////////////////////////////////////////////////////////////
   // Next-state logic
   ////////////////////////////////////////////////////////////////////////////
   always_comb
   begin
      // Default values

      nxt_state          <= RESET;
      nxt_avl_write_req  <= 1'b0;
      nxt_avl_read_req   <= 1'b0;
      nxt_golden_data    <= golden_data;
      nxt_golden_be      <= golden_be;
      nxt_burst_count    <= burst_count;
      nxt_word_addr      <= word_addr;
      nxt_loop_count     <= loop_count;
      nxt_pnf_per_bit    <= pnf_per_bit;
      nxt_ttl_words_read <= ttl_words_read;

      case (state)
         RESET:
            begin
               // reset state
               nxt_state         <= INIT;
            end

         INIT:
            begin
               if (addr_queue.size()) begin
                  // proceed to read
                  nxt_word_addr_int =  addr_queue.pop_front();

                  nxt_state         <= ISSUE_READ;
                  nxt_word_addr     <= nxt_word_addr_int;
                  nxt_golden_data   <= golden_data_table[nxt_word_addr_int];
                  nxt_golden_be     <= golden_be_table[nxt_word_addr_int];
               end else begin
                  nxt_state         <= NEXT_LOOP;
               end
            end

         ISSUE_READ:
            begin
               // issue read command and proceed to wait for command acceptance
               nxt_state          <= WAIT_READ_ACCEPTED;
               nxt_avl_read_req   <= 1'b1;
               nxt_burst_count    <= avl_size - 1'b1;
            end

         WAIT_READ_ACCEPTED:
            begin
               if (!avl_ready) begin
                  // command not yet accepted, wait while holding Avalon signals constants
                  nxt_state          <= WAIT_READ_ACCEPTED;
                  nxt_avl_read_req   <= 1'b1;
               end else begin
                  // command accepted, wait for read data return
                  nxt_state          <= WAIT_READ_DONE;
               end
            end

         WAIT_READ_DONE:
            begin
               if (avl_rdata_valid_r) begin
                  nxt_ttl_words_read <= ttl_words_read + 1'b1;

                  // data is available, compare against golden
                  if ((avl_rdata_r & golden_bit_enable) == (golden_data & golden_bit_enable)) begin
                     // correct data
                     if (burst_count != '0) begin
                        // not all beats has come back, keep waiting
                        nxt_state <= WAIT_READ_DONE;
                        nxt_burst_count   <= burst_count - 1'b1;

                     end else if (addr_queue.size()) begin
                        // read burst done, but more reads to do
                        nxt_word_addr_int =  addr_queue.pop_front();

                        nxt_state         <= ISSUE_READ;
                        nxt_word_addr     <= nxt_word_addr_int;
                        nxt_golden_data   <= golden_data_table[nxt_word_addr_int];
                        nxt_golden_be     <= golden_be_table[nxt_word_addr_int];

                     end else begin
                        // proceed to next loop
                        nxt_state         <= NEXT_LOOP;
                     end
                  end else begin
                     // incorrect data, update pnf, and fail test
                     nxt_state <= DONE_FAIL;
                     nxt_pnf_per_bit <= ~((avl_rdata_r & golden_bit_enable) ^ (golden_data & golden_bit_enable));
                  end
               end else begin
                  // no valid data, keep waiting
                  nxt_state <= WAIT_READ_DONE;
               end
            end

         NEXT_LOOP:
            begin
               if (loop_count == '1) begin
                  // all iterations completed, pass test
                  nxt_state <= DONE_PASS;
               end else begin
                  // proceed to next iteration
                  nxt_state <= RESET;
                  nxt_loop_count <= loop_count + 1'b1;
               end
            end

         DONE_PASS:
            begin
               nxt_state <= DONE_PASS;
            end

         DONE_FAIL:
            begin
               nxt_state <= DONE_FAIL;
            end
      endcase
   end

`ifdef ALTERA_EMIF_ENABLE_ISSP
   altsource_probe #(
      .sld_auto_instance_index ("YES"),
      .sld_instance_index      (0),
      .instance_id             ("RCNT"),
      .probe_width             (TG_AVL_WORD_ADDR_WIDTH),
      .source_width            (0),
      .source_initial_value    ("0"),
      .enable_metastability    ("NO")
   ) issp_ttl_words_read (
      .probe  (ttl_words_read)
   );
`endif

   // synthesis translate_on
endmodule
