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


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

//`default_nettype none

module intel_pcie_mcdma_ptile_wrapper
#(

  parameter payload_width_integer_hwtcl            = 256,
  parameter hdr_width_integer_hwtcl                = 256,
  parameter pfx_width_integer_hwtcl                = 64,
  parameter double_width_integer_hwtcl             = 1,
  parameter total_pf_count_hwtcl                   = 4,
  parameter total_pf_count_width_hwtcl             = 2,
  parameter total_vf_count_hwtcl                   = 0,
  parameter total_vf_count_width_hwtcl             = 1,

  // Internal parameters, not user visible
  parameter device_family                          = "Stratix 10",
  parameter PFNUM                                  = total_pf_count_hwtcl,
  parameter PFNUM_WIDTH                            = total_pf_count_width_hwtcl,
  parameter VFNUM_WIDTH                            = total_vf_count_width_hwtcl,
  parameter SIMULATION_SPEEDUP                     = 0,
  parameter MPS_SUPPORTED                          = 512,
  parameter ST_CHANNEL_WIDTH                       = 11,

  parameter device_family_hwtcl                    = device_family,
  parameter tile_hwtcl                             = "P",
  parameter sim_speedup                            = 0,
  parameter lite_scheduler                         = 0,
  parameter avst_endianness_big                    = 1,
  parameter enable_user_flr_hwtcl                  = 1,
  parameter enable_user_msix_hwtcl                 = 1,
  parameter en_metadata_8_hwtcl                    = 0,
  parameter en_10bit_tag_hwtcl                     = 0,
  parameter enable_mcdma_hwtcl                     = 1,
  parameter enable_data_mover_hwtcl                = 0,
  parameter enable_bursting_master_hwtcl           = 0,
  parameter enable_bursting_slave_hwtcl            = 0,
  parameter enable_cs_hwtcl                        = 0,

  parameter data_width_hwtcl                       = double_width_integer_hwtcl ? 512 : 256,
  parameter seg_width                              = 256,
  parameter seg_num                                = (data_width_hwtcl/seg_width),
  parameter burst_width_hwtcl                      = (data_width_hwtcl == 512) ? 4 : 5,
  parameter empty_width_hwtcl                      = $clog2(data_width_hwtcl/8),
  parameter einfo_width_hwtcl                      = 13,
  parameter pfnum_hwtcl                            = 1,
  parameter pfcnt_w_hwtcl                          = 1,
  parameter vfcnt_w_hwtcl                          = 1,
  parameter max_bar_address_width_hwtcl            = 32,
  parameter pfnum_width_hwtcl                      = 3,
  parameter vfnum_width_hwtcl                      = 11,
  parameter pio_address_width_hwtcl                = 64,
  parameter pio_data_width_hwtcl                   = 64,
  parameter pio_bar2_size_per_f_hwtcl              = 64,//map to actual BAR2 allocation later
  parameter cr_en_hwtcl                            = 1,
  parameter num_h2d_uport_hwtcl                    = 4,
  parameter num_d2h_uport_hwtcl                    = 4,
  parameter uport_type_h2d_hwtcl                   = 4'hF,
  parameter uport_type_d2h_hwtcl                   = 4'hF,
  parameter d2h_num_active_channel_hwtcl           = 1,
  parameter d2h_max_num_desc_fetch_hwtcl           = 16,
  
  parameter pf0_enable_sriov_hwtcl                 = 0,
  parameter pf0_num_vf_per_pf_hwtcl                = 0,
  parameter pf0_num_dma_chan_pf_hwtcl              = 0,
  parameter pf0_num_dma_chan_per_vf_hwtcl          = 0,
  parameter pf1_enable_sriov_hwtcl                 = 0,
  parameter pf1_num_vf_per_pf_hwtcl                = 0,
  parameter pf1_num_dma_chan_pf_hwtcl              = 0,
  parameter pf1_num_dma_chan_per_vf_hwtcl          = 0,
  parameter pf2_enable_sriov_hwtcl                 = 0,
  parameter pf2_num_vf_per_pf_hwtcl                = 0,
  parameter pf2_num_dma_chan_pf_hwtcl              = 0,
  parameter pf2_num_dma_chan_per_vf_hwtcl          = 0,
  parameter pf3_enable_sriov_hwtcl                 = 0,
  parameter pf3_num_vf_per_pf_hwtcl                = 0,
  parameter pf3_num_dma_chan_pf_hwtcl              = 0,
  parameter pf3_num_dma_chan_per_vf_hwtcl          = 0,
  parameter pf4_enable_sriov_hwtcl                 = 0,
  parameter pf4_num_vf_per_pf_hwtcl                = 0,
  parameter pf4_num_dma_chan_pf_hwtcl              = 0,
  parameter pf4_num_dma_chan_per_vf_hwtcl          = 0,
  parameter pf5_enable_sriov_hwtcl                 = 0,
  parameter pf5_num_vf_per_pf_hwtcl                = 0,
  parameter pf5_num_dma_chan_pf_hwtcl              = 0,
  parameter pf5_num_dma_chan_per_vf_hwtcl          = 0,
  parameter pf6_enable_sriov_hwtcl                 = 0,
  parameter pf6_num_vf_per_pf_hwtcl                = 0,
  parameter pf6_num_dma_chan_pf_hwtcl              = 0,
  parameter pf6_num_dma_chan_per_vf_hwtcl          = 0,
  parameter pf7_enable_sriov_hwtcl                 = 0,
  parameter pf7_num_vf_per_pf_hwtcl                = 0,
  parameter pf7_num_dma_chan_pf_hwtcl              = 0,
  parameter pf7_num_dma_chan_per_vf_hwtcl          = 0,
  parameter cs_address_width_hwtcl                 =29,

  parameter core16_pf0_bar0_address_width_hwtcl           = 20,
  parameter core16_pf0_bar1_address_width_hwtcl           = 20,
  parameter core16_pf0_bar2_address_width_hwtcl           = 20,
  parameter core16_pf0_bar3_address_width_hwtcl           = 20,
  parameter core16_pf0_bar4_address_width_hwtcl           = 20,
  parameter core16_pf0_bar5_address_width_hwtcl           = 20,
  parameter core16_pf1_bar0_address_width_hwtcl           = 20,
  parameter core16_pf1_bar1_address_width_hwtcl           = 20,
  parameter core16_pf1_bar2_address_width_hwtcl           = 20,
  parameter core16_pf1_bar3_address_width_hwtcl           = 20,
  parameter core16_pf1_bar4_address_width_hwtcl           = 20,
  parameter core16_pf1_bar5_address_width_hwtcl           = 20,
  parameter core16_pf2_bar0_address_width_hwtcl           = 20,
  parameter core16_pf2_bar1_address_width_hwtcl           = 20,
  parameter core16_pf2_bar2_address_width_hwtcl           = 20,
  parameter core16_pf2_bar3_address_width_hwtcl           = 20,
  parameter core16_pf2_bar4_address_width_hwtcl           = 20,
  parameter core16_pf2_bar5_address_width_hwtcl           = 20,
  parameter core16_pf3_bar0_address_width_hwtcl           = 20,
  parameter core16_pf3_bar1_address_width_hwtcl           = 20,
  parameter core16_pf3_bar2_address_width_hwtcl           = 20,
  parameter core16_pf3_bar3_address_width_hwtcl           = 20,
  parameter core16_pf3_bar4_address_width_hwtcl           = 20,
  parameter core16_pf3_bar5_address_width_hwtcl           = 20,
  parameter core16_pf4_bar0_address_width_hwtcl           = 20,
  parameter core16_pf4_bar1_address_width_hwtcl           = 20,
  parameter core16_pf4_bar2_address_width_hwtcl           = 20,
  parameter core16_pf4_bar3_address_width_hwtcl           = 20,
  parameter core16_pf4_bar4_address_width_hwtcl           = 20,
  parameter core16_pf4_bar5_address_width_hwtcl           = 20,
  parameter core16_pf5_bar0_address_width_hwtcl           = 20,
  parameter core16_pf5_bar1_address_width_hwtcl           = 20,
  parameter core16_pf5_bar2_address_width_hwtcl           = 20,
  parameter core16_pf5_bar3_address_width_hwtcl           = 20,
  parameter core16_pf5_bar4_address_width_hwtcl           = 20,
  parameter core16_pf5_bar5_address_width_hwtcl           = 20,
  parameter core16_pf6_bar0_address_width_hwtcl           = 20,
  parameter core16_pf6_bar1_address_width_hwtcl           = 20,
  parameter core16_pf6_bar2_address_width_hwtcl           = 20,
  parameter core16_pf6_bar3_address_width_hwtcl           = 20,
  parameter core16_pf6_bar4_address_width_hwtcl           = 20,
  parameter core16_pf6_bar5_address_width_hwtcl           = 20,
  parameter core16_pf7_bar0_address_width_hwtcl           = 20,
  parameter core16_pf7_bar1_address_width_hwtcl           = 20,
  parameter core16_pf7_bar2_address_width_hwtcl           = 20,
  parameter core16_pf7_bar3_address_width_hwtcl           = 20,
  parameter core16_pf7_bar4_address_width_hwtcl           = 20,
  parameter core16_pf7_bar5_address_width_hwtcl           = 20,

  parameter core16_pf0_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf0_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf0_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf0_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf0_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf0_sriov_vf_bar5_address_width_hwtcl        = 20,
  parameter core16_pf1_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf1_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf1_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf1_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf1_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf1_sriov_vf_bar5_address_width_hwtcl        = 20,
  parameter core16_pf2_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf2_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf2_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf2_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf2_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf2_sriov_vf_bar5_address_width_hwtcl        = 20,
  parameter core16_pf3_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf3_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf3_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf3_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf3_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf3_sriov_vf_bar5_address_width_hwtcl        = 20,
  parameter core16_pf4_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf4_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf4_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf4_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf4_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf4_sriov_vf_bar5_address_width_hwtcl        = 20,
  parameter core16_pf5_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf5_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf5_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf5_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf5_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf5_sriov_vf_bar5_address_width_hwtcl        = 20,
  parameter core16_pf6_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf6_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf6_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf6_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf6_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf6_sriov_vf_bar5_address_width_hwtcl        = 20,
  parameter core16_pf7_sriov_vf_bar0_address_width_hwtcl        = 20,
  parameter core16_pf7_sriov_vf_bar1_address_width_hwtcl        = 20,
  parameter core16_pf7_sriov_vf_bar2_address_width_hwtcl        = 20,
  parameter core16_pf7_sriov_vf_bar3_address_width_hwtcl        = 20,
  parameter core16_pf7_sriov_vf_bar4_address_width_hwtcl        = 20,
  parameter core16_pf7_sriov_vf_bar5_address_width_hwtcl        = 20

)
(
  // clock and reset
  input                                           clk,
  input                                           rst_n, // might make a multi-bit signal to generate a reset tree
  input                                           pin_perst_n,
  
  output logic                                    reset_status_n,
  output logic                                    app_clk,
  output logic                                    app_rst_n,
  output logic                                    dummy_user_avmm_rst_o,

  // Interface to the Streaming ports of HIP.
  //RX Ports
  output logic                                      rx_st_ready_o,
  input logic [double_width_integer_hwtcl-1:0]      rx_st_valid_i,
  input logic [double_width_integer_hwtcl-1:0]      rx_st_sop_i,
  input logic [double_width_integer_hwtcl-1:0]      rx_st_eop_i,
  input logic [hdr_width_integer_hwtcl-1:0]         rx_st_hdr_i,
  input logic [payload_width_integer_hwtcl-1:0]     rx_st_data_i,
  input logic [double_width_integer_hwtcl-1:0]      rx_st_vf_active_i,
  input logic [double_width_integer_hwtcl*3-1:0]    rx_st_func_num_i,
  input logic [double_width_integer_hwtcl*11-1:0]   rx_st_vf_num_i,
  input logic [double_width_integer_hwtcl*3-1:0]    rx_st_bar_range_i,
  input logic                                       rx_par_err_i,

  //TX Ports
  input logic                                       tx_st_ready_i,
  input logic                                       tx_par_err_i,
  output logic [double_width_integer_hwtcl-1:0]     tx_st_valid_o,
  output logic [double_width_integer_hwtcl-1:0]     tx_st_sop_o,
  output logic [double_width_integer_hwtcl-1:0]     tx_st_eop_o,
  output logic [double_width_integer_hwtcl-1:0]     tx_st_err_o,
  output logic [hdr_width_integer_hwtcl-1:0]        tx_st_hdr_o,
  output logic [payload_width_integer_hwtcl-1:0]    tx_st_data_o,
  output logic [double_width_integer_hwtcl-1:0]     tx_st_vf_active_o,

  //missing in 512_dcore:
  input  logic [double_width_integer_hwtcl*3 -1 :0] rx_st_empty_i,
  input  logic [pfx_width_integer_hwtcl-1:0]        rx_st_tlp_prfx_i,
  input  logic [double_width_integer_hwtcl -1:0]    rx_st_tlp_abort_i,
  input  logic [payload_width_integer_hwtcl/8-1:0]  rx_st_data_par_i,
  input  logic [hdr_width_integer_hwtcl/8-1:0]      rx_st_hdr_par_i,
  input  logic [pfx_width_integer_hwtcl/8-1:0]      rx_st_tlp_prfx_par_i,

  output  logic [pfx_width_integer_hwtcl-1:0]       tx_st_tlp_prfx_o,
  output  logic [payload_width_integer_hwtcl/8-1:0] tx_st_data_par_o,
  output  logic [hdr_width_integer_hwtcl/8-1:0]     tx_st_hdr_par_o,
  output  logic [pfx_width_integer_hwtcl/8-1:0]     tx_st_tlp_prfx_par_o,

  input                                             dl_timer_update_o,
  // Streaming Packets HIP Credit Interface.
  // TX Ports
  input logic [15:0]                              tx_cdts_limit_i,           //C2p NA      C2e  NA             WHR [15:0]
  input logic [2:0]                               tx_cdts_limit_tdm_idx_i,   //C2p NA      C2e  NA             WHR [2:0]

  // RX Ports
  output logic [11:0]                             rx_buffer_limit_o,         //C2p NA      C2e  NA             WHR [11:0]
  output logic [1:0]                              rx_buffer_limit_tdm_idx_o, //C2p NA      C2e  NA             WHR [1:0]


  // HIP Misc interface
  // Config Interface
  // Lukas to update the interface name
  input logic [2:0]                               tl_cfg_func_i,               //C2p[1:0]    C2e  [1:0]          WHR [2:0]
  input logic [4:0]                               tl_cfg_add_i,                //C2p[4:0]    C2e  [3:0]          WHR [4:0]
  input logic [15:0]                              tl_cfg_ctl_i,                //C2p[31:0]   C2e  [31:0]         WHR [15:0]

   // HIP REconfig interface
  output logic                                    hip_reconfig_read_o,
  output logic [20:0]                             hip_reconfig_address_o,
  output logic                                    hip_reconfig_write_o,
  output logic [7:0]                              hip_reconfig_writedata_o,
  output logic                                    hip_reconfig_clk_o,
  input  logic                                    hip_reconfig_readdatavalid_i,
  input  logic [7:0]                              hip_reconfig_readdata_i,
  input  logic                                    hip_reconfig_waitrequest_i,

  output logic [15:0]                         usr_hip_tl_cfg_ctl_o, 
  output logic [4:0]                          usr_hip_tl_cfg_add_o, 
  output logic [2:0]                          usr_hip_tl_cfg_func_o,
    
    // Usr Reconfig interface
  input logic                                 usr_hip_reconfig_rst_n_i,
  input logic                                 usr_hip_reconfig_clk_i,
  input logic [20:0]                          usr_hip_reconfig_address_i,
  input logic                                 usr_hip_reconfig_read_i,
  input logic                                 usr_hip_reconfig_write_i,
  input logic [7:0]                           usr_hip_reconfig_writedata_i,
  output logic [7:0]                          usr_hip_reconfig_readdata_o,
  output logic                                usr_hip_reconfig_readdatavalid_o,
  output logic                                usr_hip_reconfig_waitrequest_o,


  // H2D AVST Master Interface
  output logic                                    h2d_st_sof_0_o,
  output logic                                    h2d_st_eof_0_o,
  output logic [empty_width_hwtcl-1:0]            h2d_st_empty_0_o,
  input logic                                     h2d_st_ready_0_i,
  output logic                                    h2d_st_valid_0_o,
  output logic [data_width_hwtcl-1:0]             h2d_st_data_0_o,
  output logic [ST_CHANNEL_WIDTH-1:0]             h2d_st_channel_0_o,
  // H2D AVST Master Interface
  output logic                                    h2d_st_sof_1_o,
  output logic                                    h2d_st_eof_1_o,
  output logic [empty_width_hwtcl-1:0]            h2d_st_empty_1_o,
  input logic                                     h2d_st_ready_1_i,
  output logic                                    h2d_st_valid_1_o,
  output logic [data_width_hwtcl-1:0]             h2d_st_data_1_o,
  output logic [ST_CHANNEL_WIDTH-1:0]             h2d_st_channel_1_o,
  // H2D AVST Master Interface
  output logic                                    h2d_st_sof_2_o,
  output logic                                    h2d_st_eof_2_o,
  output logic [empty_width_hwtcl-1:0]            h2d_st_empty_2_o,
  input logic                                     h2d_st_ready_2_i,
  output logic                                    h2d_st_valid_2_o,
  output logic [data_width_hwtcl-1:0]             h2d_st_data_2_o,
  output logic [ST_CHANNEL_WIDTH-1:0]             h2d_st_channel_2_o,
  // H2D AVST Master Interface
  output logic                                    h2d_st_sof_3_o,
  output logic                                    h2d_st_eof_3_o,
  output logic [empty_width_hwtcl-1:0]            h2d_st_empty_3_o,
  input logic                                     h2d_st_ready_3_i,
  output logic                                    h2d_st_valid_3_o,
  output logic [data_width_hwtcl-1:0]             h2d_st_data_3_o,
  output logic [ST_CHANNEL_WIDTH-1:0]             h2d_st_channel_3_o,
  // H2D AVMM Master Interface
  input logic                                     h2ddm_waitrequest_i,
  input logic                                     h2ddm_writeresponsevalid_i,
  output logic                                    h2ddm_write_o,
  output logic [63:0]                             h2ddm_address_o,
  output logic [burst_width_hwtcl-1:0]            h2ddm_burstcount_o,
  output logic [data_width_hwtcl/8-1:0]           h2ddm_byteenable_o,
  output logic [data_width_hwtcl-1:0]             h2ddm_writedata_o,
  // D2H AVST interface
  input logic                                     d2h_st_sof_0_i,
  input logic                                     d2h_st_eof_0_i,
  input logic [empty_width_hwtcl-1:0]             d2h_st_empty_0_i,
  input logic [ST_CHANNEL_WIDTH-1:0]              d2h_st_channel_0_i,
  input logic                                     d2h_st_valid_0_i,
  input logic [data_width_hwtcl-1:0]              d2h_st_data_0_i,
  output logic                                    d2h_st_ready_0_o,
  // D2H AVST interface
  input logic                                     d2h_st_sof_1_i,
  input logic                                     d2h_st_eof_1_i,
  input logic [empty_width_hwtcl-1:0]             d2h_st_empty_1_i,
  input logic [ST_CHANNEL_WIDTH-1:0]              d2h_st_channel_1_i,
  input logic                                     d2h_st_valid_1_i,
  input logic [data_width_hwtcl-1:0]              d2h_st_data_1_i,
  output logic                                    d2h_st_ready_1_o,
  // D2H AVST interface
  input logic                                     d2h_st_sof_2_i,
  input logic                                     d2h_st_eof_2_i,
  input logic [empty_width_hwtcl-1:0]             d2h_st_empty_2_i,
  input logic [ST_CHANNEL_WIDTH-1:0]              d2h_st_channel_2_i,
  input logic                                     d2h_st_valid_2_i,
  input logic [data_width_hwtcl-1:0]              d2h_st_data_2_i,
  output logic                                    d2h_st_ready_2_o,
  // D2H AVST interface
  input logic                                     d2h_st_sof_3_i,
  input logic                                     d2h_st_eof_3_i,
  input logic [empty_width_hwtcl-1:0]             d2h_st_empty_3_i,
  input logic [ST_CHANNEL_WIDTH-1:0]              d2h_st_channel_3_i,
  input logic                                     d2h_st_valid_3_i,
  input logic [data_width_hwtcl-1:0]              d2h_st_data_3_i,
  output logic                                    d2h_st_ready_3_o,
  //D2H AVMM Read Master Interface
  output logic [63:0]                             d2hdm_address_o,
  output logic [data_width_hwtcl/8-1:0]           d2hdm_byteenable_o,
  output logic                                    d2hdm_read_o,
  output logic [burst_width_hwtcl-1:0]            d2hdm_burstcount_o,
  input logic                                     d2hdm_waitrequest_i,
  input logic [data_width_hwtcl-1:0]              d2hdm_readdata_i,
  input logic                                     d2hdm_readdatavalid_i,
  input logic [1:0]                               d2hdm_response_i,
  //AVST interface
  //H2D descriptor input on AVST sink interface
  output logic                                    h2ddm_desc_ready_o,
  input logic                                     h2ddm_desc_valid_i, 
  input logic [255:0]                             h2ddm_desc_data_i, // h2d_desc_bypass_t
  //H2D AVST Status source interface              
  output logic [31:0]                             h2ddm_desc_status_data_o, // h2d_desc_status_t
  output logic                                    h2ddm_desc_status_valid_o,
  //H2D AVST Source completion interface          
  output logic [data_width_hwtcl-1:0]             h2ddm_desc_cmpl_data_o, // h2d_desc_cmpl_t
  output logic [empty_width_hwtcl-1:0]            h2ddm_desc_cmpl_empty_o,
  output logic                                    h2ddm_desc_cmpl_sop_o, 
  output logic                                    h2ddm_desc_cmpl_eop_o, 
  output logic                                    h2ddm_desc_cmpl_valid_o, 
  input logic                                     h2ddm_desc_cmpl_ready_i,
  //D2H descriptor input on AVST sink interface   
  output logic                                    d2hdm_desc_ready_o, 
  input logic                                     d2hdm_desc_valid_i, 
  input logic [255:0]                             d2hdm_desc_data_i, // d2h_desc_bypass_t
  //D2H AVST Status source interface              
  output logic [31:0]                             d2hdm_desc_status_data_o, // d2h_desc_status_t
  output logic                                    d2hdm_desc_status_valid_o,
  // AVMM Master PIO interface
  output logic [pio_address_width_hwtcl-1:0]      rx_pio_address_o,
  output logic [pio_data_width_hwtcl/8-1:0]       rx_pio_byteenable_o,
  output logic                                    rx_pio_read_o,
  output logic                                    rx_pio_write_o,
  output logic [pio_data_width_hwtcl-1:0]         rx_pio_writedata_o,
  output logic [3:0]                              rx_pio_burstcount_o,
  input logic                                     rx_pio_waitrequest_i,
  input logic [pio_data_width_hwtcl-1:0]          rx_pio_readdata_i,
  input logic                                     rx_pio_readdatavalid_i,
  input logic [1:0]                               rx_pio_response_i,
  input logic                                     rx_pio_writeresponsevalid_i,

  // FLR interface from HIP
  input logic [7:0]                               flr_rcvd_pf_i,
  input logic                                     flr_rcvd_vf_i,
  input logic [2:0]                               flr_rcvd_pf_num_i,
  input logic [10:0]                              flr_rcvd_vf_num_i,
  output logic [7:0]                              flr_completed_pf_o,
  output logic                                    flr_completed_vf_o,
  output logic [2:0]                              flr_completed_pf_num_o,
  output logic [10:0]                             flr_completed_vf_num_o,
  //FLR interface to application/user side
  output logic                                    usr_flr_rcvd_val_o,
  output logic [10:0]                             usr_flr_rcvd_chan_num_o,
  input  logic                                    usr_flr_completed_i,
  //  Completion Timeout Interface (only in P-tile)
  input  logic                                    cpl_timeout_i,
  output logic                                    cpl_timeout_avmm_clk_o,
  input  logic                                    cpl_timeout_avmm_waitrequest_i,
  output logic                                    cpl_timeout_avmm_read_o,
  output logic [20:0]                             cpl_timeout_avmm_address_o, // [20:3] : Reserved. Tie them to 0. 
  output logic                                    cpl_timeout_avmm_write_o,
  output logic [7:0]                              cpl_timeout_avmm_writedata_o,
  input  logic [7:0]                              cpl_timeout_avmm_readdata_i,
  input  logic                                    cpl_timeout_avmm_readdatavalid_i,
  // Error interface to HIP
  output logic                                    app_err_valid_o,
  output logic [31:0]                             app_err_hdr_o,
  output logic [einfo_width_hwtcl-1:0]            app_err_info_o, //S10:app_err_info[10:0]
  output logic [pfnum_width_hwtcl-1:0]            app_err_func_num_o, //S10: app_err_func_num[1:0]
  input  logic                                    serr_i,
  input  logic                                    hip_enter_err_mode_i,
  // MSI-X Request interface from application/user side
  input  logic                                    usr_event_msix_valid_i,
  output logic                                    usr_event_msix_ready_o,
  input  logic [15:0]                             usr_event_msix_data_i,

  // BAS interface
  input logic                                     bas_vfactive_i,
  input logic [pfnum_width_hwtcl-1:0]             bas_pfnum_i,
  input logic [vfnum_width_hwtcl-1:0]             bas_vfnum_i,
  input logic [63:0]                              bas_address_i,
  input logic [data_width_hwtcl/8-1:0]            bas_byteenable_i,
  input logic                                     bas_read_i,
  input logic                                     bas_write_i,
  input logic [data_width_hwtcl-1:0]              bas_writedata_i,
  input logic [burst_width_hwtcl-1:0]             bas_burstcount_i,
  output logic                                    bas_waitrequest_o,
  output logic [data_width_hwtcl-1:0]             bas_readdata_o,
  output logic                                    bas_readdatavalid_o,
  output logic [1:0]                              bas_response_o,

  // BAM interface
  input logic                                     bam_readdatavalid_i,
  input logic [data_width_hwtcl-1:0]              bam_readdata_i,
  input logic                                     bam_waitrequest_i,
//output logic                                    bam_vfactive_o,
//output logic [pfcnt_w_hwtcl-1:0]                bam_pfnum_o,
//output logic [pfcnt_w_hwtcl-1:0]                bam_vfnum_o,
//output logic [2:0]                              bam_bar_o,
  output logic [enable_cs_hwtcl ==1 ? 63 : 1+pfcnt_w_hwtcl+vfcnt_w_hwtcl+3+max_bar_address_width_hwtcl-1:0] bam_address_o,
  output logic [burst_width_hwtcl-1:0]            bam_burstcount_o,
  output logic [data_width_hwtcl/8-1:0]           bam_byteenable_o,
  output logic                                    bam_read_o,
  output logic                                    bam_write_o,
  output logic [data_width_hwtcl-1:0]             bam_writedata_o, 

//CS AVMM slave interface   
  output logic                                    cs_waitrequest_o,
  input  logic [cs_address_width_hwtcl-1 :0]      cs_address_i,
  input  logic [3:0]                              cs_byteenable_i,
  input  logic                                    cs_read_i,
  output logic [31:0]                             cs_readdata_o,
  output logic                                    cs_readdatavalid_o,
  input  logic                                    cs_write_i,
  input  logic [31:0]                             cs_writedata_i,
  output logic [1:0]                              cs_response_o, 
  output logic                                    cs_writeresponsevalid_o   
       
);
  //localparam adap_en = (payload_width_integer_hwtcl < 512) ? 1:0;

  logic                                       rx_st_ready_wire;
  logic [double_width_integer_hwtcl-1:0]      rx_st_valid_wire;
  logic [double_width_integer_hwtcl-1:0]      rx_st_eop_wire;
  logic [double_width_integer_hwtcl-1:0]      rx_st_sop_wire;
  logic [hdr_width_integer_hwtcl-1:0]         rx_st_hdr_wire;
  logic [payload_width_integer_hwtcl-1:0]     rx_st_data_wire;
  logic [double_width_integer_hwtcl-1:0]      rx_st_vf_active_wire;
//logic [PFNUM_WIDTH*2-1:0]                   rx_st_func_num_wire;
//logic [VFNUM_WIDTH*2-1:0]                   rx_st_vf_num_wire;
  logic [double_width_integer_hwtcl*3-1:0]             rx_st_func_num_wire;
  logic [double_width_integer_hwtcl*11-1:0]             rx_st_vf_num_wire;
  logic [double_width_integer_hwtcl*3-1:0]    rx_st_bar_range_wire;
  logic                                       rx_par_err_wire;

  logic                                       tx_st_ready_wire;
  logic                                       tx_par_err_wire;
  logic [double_width_integer_hwtcl-1:0]      tx_st_valid_wire;
  logic [double_width_integer_hwtcl-1:0]      tx_st_sop_wire;
  logic [double_width_integer_hwtcl-1:0]      tx_st_eop_wire;
  logic [double_width_integer_hwtcl-1:0]      tx_st_err_wire;
  logic [hdr_width_integer_hwtcl-1:0]         tx_st_hdr_wire;
  logic [payload_width_integer_hwtcl-1:0]     tx_st_data_wire;
  logic [double_width_integer_hwtcl-1:0]      tx_st_vf_active_wire;
  
  logic [hdr_width_integer_hwtcl-1:0]         rx_st_hdr_switch_wire,tx_st_hdr_switch_wire;

//logic [15:0]              tx_cdts_limit_wire;
//logic [2:0]               tx_cdts_limit_tdm_idx_wire;
//logic [11:0]              rx_buffer_limit_wire;
//logic [1:0]               rx_buffer_limit_tdm_idx_wire;
  logic [2:0]               tl_cfg_func_wire;
  logic [4:0]               tl_cfg_add_wire;
  logic [15:0]              tl_cfg_ctl_wire;
  logic [2:0]               mps_logic;
  logic [2:0]               mrrs_logic;
  logic [4:0]               device_number;
  
  // H2D AVST Master Interface
  logic                                      h2d_st_sof_o      [4];
  logic                                      h2d_st_eof_o      [4];
  logic [empty_width_hwtcl-1:0]              h2d_st_empty_o    [4];
  logic                                      h2d_st_ready_i    [4];
  logic                                      h2d_st_valid_o    [4];
  logic [data_width_hwtcl-1:0]               h2d_st_data_o     [4];
  logic [ST_CHANNEL_WIDTH-1:0]               h2d_st_channel_o  [4];

  // D2H AVST interface
  logic                                      d2h_st_sof_i      [4];
  logic                                      d2h_st_eof_i      [4];
  logic [empty_width_hwtcl-1:0]              d2h_st_empty_i    [4];
  logic [ST_CHANNEL_WIDTH-1:0]               d2h_st_channel_i  [4];
  logic                                      d2h_st_valid_i    [4];
  logic [data_width_hwtcl-1:0]               d2h_st_data_i     [4];
  logic                                      d2h_st_ready_o    [4];

  //From H2D_Port
  assign h2d_st_ready_i[0] = h2d_st_ready_0_i;
  assign h2d_st_sof_0_o     = h2d_st_sof_o[0];
  assign h2d_st_eof_0_o     = h2d_st_eof_o[0];
  assign h2d_st_empty_0_o   = h2d_st_empty_o[0];
  assign h2d_st_valid_0_o   = h2d_st_valid_o[0];
  assign h2d_st_data_0_o    = h2d_st_data_o[0];
  assign h2d_st_channel_0_o = h2d_st_channel_o[0];

  assign h2d_st_ready_i[1] = h2d_st_ready_1_i;
  assign h2d_st_sof_1_o     = h2d_st_sof_o[1];
  assign h2d_st_eof_1_o     = h2d_st_eof_o[1];
  assign h2d_st_empty_1_o   = h2d_st_empty_o[1];
  assign h2d_st_valid_1_o   = h2d_st_valid_o[1];
  assign h2d_st_data_1_o    = h2d_st_data_o[1];
  assign h2d_st_channel_1_o = h2d_st_channel_o[1];

  assign h2d_st_ready_i[2] = h2d_st_ready_2_i;
  assign h2d_st_sof_2_o     = h2d_st_sof_o[2];
  assign h2d_st_eof_2_o     = h2d_st_eof_o[2];
  assign h2d_st_empty_2_o   = h2d_st_empty_o[2];
  assign h2d_st_valid_2_o   = h2d_st_valid_o[2];
  assign h2d_st_data_2_o    = h2d_st_data_o[2];
  assign h2d_st_channel_2_o = h2d_st_channel_o[2];

  assign h2d_st_ready_i[3] = h2d_st_ready_3_i;
  assign h2d_st_sof_3_o     = h2d_st_sof_o[3];
  assign h2d_st_eof_3_o     = h2d_st_eof_o[3];
  assign h2d_st_empty_3_o   = h2d_st_empty_o[3];
  assign h2d_st_valid_3_o   = h2d_st_valid_o[3];
  assign h2d_st_data_3_o    = h2d_st_data_o[3];
  assign h2d_st_channel_3_o = h2d_st_channel_o[3];

  // To D2H_port
  assign d2h_st_ready_0_o     = d2h_st_ready_o[0];
  assign d2h_st_sof_i[0]     = d2h_st_sof_0_i;
  assign d2h_st_eof_i[0]     = d2h_st_eof_0_i;
  assign d2h_st_empty_i[0]   = d2h_st_empty_0_i;
  assign d2h_st_valid_i[0]   = d2h_st_valid_0_i;
  assign d2h_st_data_i[0]    = d2h_st_data_0_i;
  assign d2h_st_channel_i[0] = d2h_st_channel_0_i;

  assign d2h_st_ready_1_o     = d2h_st_ready_o[1];
  assign d2h_st_sof_i[1]     = d2h_st_sof_1_i;
  assign d2h_st_eof_i[1]     = d2h_st_eof_1_i;
  assign d2h_st_empty_i[1]   = d2h_st_empty_1_i;
  assign d2h_st_valid_i[1]   = d2h_st_valid_1_i;
  assign d2h_st_data_i[1]    = d2h_st_data_1_i;
  assign d2h_st_channel_i[1] = d2h_st_channel_1_i;

  assign d2h_st_ready_2_o     = d2h_st_ready_o[2];
  assign d2h_st_sof_i[2]     = d2h_st_sof_2_i;
  assign d2h_st_eof_i[2]     = d2h_st_eof_2_i;
  assign d2h_st_empty_i[2]   = d2h_st_empty_2_i;
  assign d2h_st_valid_i[2]   = d2h_st_valid_2_i;
  assign d2h_st_data_i[2]    = d2h_st_data_2_i;
  assign d2h_st_channel_i[2] = d2h_st_channel_2_i;

  assign d2h_st_ready_3_o     = d2h_st_ready_o[3];
  assign d2h_st_sof_i[3]     = d2h_st_sof_3_i;
  assign d2h_st_eof_i[3]     = d2h_st_eof_3_i;
  assign d2h_st_empty_i[3]   = d2h_st_empty_3_i;
  assign d2h_st_valid_i[3]   = d2h_st_valid_3_i;
  assign d2h_st_data_i[3]    = d2h_st_data_3_i;
  assign d2h_st_channel_i[3] = d2h_st_channel_3_i;
  
  assign dummy_user_avmm_rst_o        = 1'b0;

  assign clk_wire                     = clk;
  assign app_clk                      = clk;
  assign rst_n_wire                   = rst_n;
  
  assign reset_status_n               = rst_n_wire;

  generate if (hdr_width_integer_hwtcl == 256) begin : hdr_x16
     assign rx_st_hdr_switch_wire        = {rx_st_hdr_wire[159:128],rx_st_hdr_wire[191:160],rx_st_hdr_wire[223:192],rx_st_hdr_wire[255:224],
        rx_st_hdr_wire[31:0],rx_st_hdr_wire[63:32],rx_st_hdr_wire[95:64],rx_st_hdr_wire[127:96]};
     assign {tx_st_hdr_wire[159:128],tx_st_hdr_wire[191:160],tx_st_hdr_wire[223:192],tx_st_hdr_wire[255:224],
        tx_st_hdr_wire[31:0],tx_st_hdr_wire[63:32],tx_st_hdr_wire[95:64],tx_st_hdr_wire[127:96]} = tx_st_hdr_switch_wire;
  end else begin : hdr_x8
     assign rx_st_hdr_switch_wire        = {rx_st_hdr_wire[31:0],rx_st_hdr_wire[63:32],rx_st_hdr_wire[95:64],rx_st_hdr_wire[127:96]};
     assign {tx_st_hdr_wire[31:0],tx_st_hdr_wire[63:32],tx_st_hdr_wire[95:64],tx_st_hdr_wire[127:96]} = tx_st_hdr_switch_wire;
  end endgenerate

  assign tx_st_tlp_prfx_o = '0;
  assign  tx_st_data_par_o = '0;
  assign  tx_st_hdr_par_o = '0;
  assign  tx_st_tlp_prfx_par_o = '0;
   
   assign rx_st_ready_o        = rx_st_ready_wire;
   assign rx_st_valid_wire     = rx_st_valid_i;
   assign rx_st_sop_wire       = rx_st_sop_i;
   assign rx_st_eop_wire       = rx_st_eop_i;
   assign rx_st_hdr_wire       = rx_st_hdr_i;
   assign rx_st_data_wire      = rx_st_data_i;
   assign rx_st_vf_active_wire = rx_st_vf_active_i;
// assign rx_st_func_num_wire  = {rx_st_func_num_i[3+PFNUM_WIDTH-1:3] , rx_st_func_num_i[PFNUM_WIDTH-1:0]};
// assign rx_st_vf_num_wire    = {rx_st_vf_num_i[11+VFNUM_WIDTH-1:0], rx_st_vf_num_i[VFNUM_WIDTH-1:0]};
   assign rx_st_func_num_wire  = rx_st_func_num_i;
   assign rx_st_vf_num_wire    = rx_st_vf_num_i;
   assign rx_st_bar_range_wire = rx_st_bar_range_i;
   assign rx_par_err_wire      = rx_par_err_i;

   assign tx_st_ready_wire     = tx_st_ready_i;
   assign tx_par_err_wire      = tx_par_err_i;
   assign tx_st_valid_o        = tx_st_valid_wire;
   assign tx_st_sop_o          = tx_st_sop_wire;
   assign tx_st_eop_o          = tx_st_eop_wire;
   assign tx_st_err_o          = tx_st_err_wire;
   assign tx_st_hdr_o          = tx_st_hdr_wire;
   assign tx_st_data_o         = tx_st_data_wire;
   assign tx_st_vf_active_o    = tx_st_vf_active_wire;

   //assign tx_cdts_limit_wire           = tx_cdts_limit_i           ;
   //assign tx_cdts_limit_tdm_idx_wire   = tx_cdts_limit_tdm_idx_i   ;
   //assign rx_buffer_limit_o            = rx_buffer_limit_wire;
   //assign rx_buffer_limit_tdm_idx_o    = rx_buffer_limit_tdm_idx_wire;      
   
   assign tl_cfg_func_wire             = tl_cfg_func_i             ;
   assign tl_cfg_add_wire              = tl_cfg_add_i              ;
   assign tl_cfg_ctl_wire              = tl_cfg_ctl_i              ;
   
   generate if (enable_data_mover_hwtcl) begin : dm_mode

      for (genvar i=0; i<4; i++) begin : h2d_avst_port
         assign h2d_st_sof_o      [i] = '0;
         assign h2d_st_eof_o      [i] = '0;
         assign h2d_st_empty_o    [i] = '0;
         assign h2d_st_valid_o    [i] = '0;
         assign h2d_st_data_o     [i] = '0;
         assign h2d_st_channel_o  [i] = '0;
      end

      for (genvar i=0; i<4; i++) begin : d2h_avst_port
         assign d2h_st_ready_o    [i] = '0;
      end

      assign usr_event_msix_ready_o    = '0;
      assign usr_flr_rcvd_val_o        = '0;
      assign usr_flr_rcvd_chan_num_o   = '0;

      assign cs_readdata_o             = '0;
      assign cs_readdatavalid_o        = '0;
      assign cs_response_o             = '0;
      assign cs_waitrequest_o          = '0;
      assign cs_writeresponsevalid_o   = '0;

  // Data Mover for External Descriptor controller IP instantiation
   intel_pcie_mcdma_dm
      #(
      // The value type (integer/string) will change based on hw_tcl development.
       .device_family_hwtcl                        (device_family_hwtcl          ),
       .tile_hwtcl                                 (tile_hwtcl                   ),
       .avst_endianness_big                        (avst_endianness_big          ),
       .enable_user_flr_hwtcl                      (enable_user_flr_hwtcl        ),
       .en_metadata_8_hwtcl                        (en_metadata_8_hwtcl          ),
       .enable_bursting_master_hwtcl               (enable_bursting_master_hwtcl ),
       .enable_bursting_slave_hwtcl                (enable_bursting_slave_hwtcl  ),
       .enable_cs_hwtcl                            (enable_cs_hwtcl              ),
       .data_width_hwtcl                           (data_width_hwtcl             ),
       .burst_width_hwtcl                          (burst_width_hwtcl            ),
       .empty_width_hwtcl                          (empty_width_hwtcl            ),
       .einfo_width_hwtcl                          (einfo_width_hwtcl            ),
       .pfnum_hwtcl                                (pfnum_hwtcl                  ),
       .pfcnt_w_hwtcl                              (pfcnt_w_hwtcl                ),
       .vfcnt_w_hwtcl                              (vfcnt_w_hwtcl                ),
       .max_bar_address_width_hwtcl                (max_bar_address_width_hwtcl  ),
       .pfnum_width_hwtcl                          (pfnum_width_hwtcl            ),
       .vfnum_width_hwtcl                          (vfnum_width_hwtcl            ),
       .pio_address_width_hwtcl                    (pio_address_width_hwtcl      ),
       .pio_data_width_hwtcl                       (pio_data_width_hwtcl         ),
       .pio_bar2_size_per_f_hwtcl                  (pio_bar2_size_per_f_hwtcl    ),
       .pf0_enable_sriov_hwtcl                     (pf0_enable_sriov_hwtcl       ),
       .pf0_num_vf_per_pf_hwtcl                    (pf0_num_vf_per_pf_hwtcl      ),
       .pf1_enable_sriov_hwtcl                     (pf1_enable_sriov_hwtcl       ),
       .pf1_num_vf_per_pf_hwtcl                    (pf1_num_vf_per_pf_hwtcl      ),
       .pf2_enable_sriov_hwtcl                     (pf2_enable_sriov_hwtcl       ),
       .pf2_num_vf_per_pf_hwtcl                    (pf2_num_vf_per_pf_hwtcl      ),
       .pf3_enable_sriov_hwtcl                     (pf3_enable_sriov_hwtcl       ),
       .pf3_num_vf_per_pf_hwtcl                    (pf3_num_vf_per_pf_hwtcl      ),
       .pf4_enable_sriov_hwtcl                     (pf4_enable_sriov_hwtcl       ),
       .pf4_num_vf_per_pf_hwtcl                    (pf4_num_vf_per_pf_hwtcl      ),
       .pf5_enable_sriov_hwtcl                     (pf5_enable_sriov_hwtcl       ),
       .pf5_num_vf_per_pf_hwtcl                    (pf5_num_vf_per_pf_hwtcl      ),
       .pf6_enable_sriov_hwtcl                     (pf6_enable_sriov_hwtcl       ),
       .pf6_num_vf_per_pf_hwtcl                    (pf6_num_vf_per_pf_hwtcl      ),
       .pf7_enable_sriov_hwtcl                     (pf7_enable_sriov_hwtcl       ),
       .pf7_num_vf_per_pf_hwtcl                    (pf7_num_vf_per_pf_hwtcl      ),
       .cs_address_width_hwtcl                     (cs_address_width_hwtcl       ),

       .pf0_bar0_address_width_hwtcl               (core16_pf0_bar0_address_width_hwtcl),
       .pf0_bar1_address_width_hwtcl               (core16_pf0_bar1_address_width_hwtcl),
       .pf0_bar2_address_width_hwtcl               (core16_pf0_bar2_address_width_hwtcl),
       .pf0_bar3_address_width_hwtcl               (core16_pf0_bar3_address_width_hwtcl),
       .pf0_bar4_address_width_hwtcl               (core16_pf0_bar4_address_width_hwtcl),
       .pf0_bar5_address_width_hwtcl               (core16_pf0_bar5_address_width_hwtcl),
       .pf1_bar0_address_width_hwtcl               (core16_pf1_bar0_address_width_hwtcl),
       .pf1_bar1_address_width_hwtcl               (core16_pf1_bar1_address_width_hwtcl),
       .pf1_bar2_address_width_hwtcl               (core16_pf1_bar2_address_width_hwtcl),
       .pf1_bar3_address_width_hwtcl               (core16_pf1_bar3_address_width_hwtcl),
       .pf1_bar4_address_width_hwtcl               (core16_pf1_bar4_address_width_hwtcl),
       .pf1_bar5_address_width_hwtcl               (core16_pf1_bar5_address_width_hwtcl),
       .pf2_bar0_address_width_hwtcl               (core16_pf2_bar0_address_width_hwtcl),
       .pf2_bar1_address_width_hwtcl               (core16_pf2_bar1_address_width_hwtcl),
       .pf2_bar2_address_width_hwtcl               (core16_pf2_bar2_address_width_hwtcl),
       .pf2_bar3_address_width_hwtcl               (core16_pf2_bar3_address_width_hwtcl),
       .pf2_bar4_address_width_hwtcl               (core16_pf2_bar4_address_width_hwtcl),
       .pf2_bar5_address_width_hwtcl               (core16_pf2_bar5_address_width_hwtcl),
       .pf3_bar0_address_width_hwtcl               (core16_pf3_bar0_address_width_hwtcl),
       .pf3_bar1_address_width_hwtcl               (core16_pf3_bar1_address_width_hwtcl),
       .pf3_bar2_address_width_hwtcl               (core16_pf3_bar2_address_width_hwtcl),
       .pf3_bar3_address_width_hwtcl               (core16_pf3_bar3_address_width_hwtcl),
       .pf3_bar4_address_width_hwtcl               (core16_pf3_bar4_address_width_hwtcl),
       .pf3_bar5_address_width_hwtcl               (core16_pf3_bar5_address_width_hwtcl),
       .pf4_bar0_address_width_hwtcl               (core16_pf4_bar0_address_width_hwtcl),
       .pf4_bar1_address_width_hwtcl               (core16_pf4_bar1_address_width_hwtcl),
       .pf4_bar2_address_width_hwtcl               (core16_pf4_bar2_address_width_hwtcl),
       .pf4_bar3_address_width_hwtcl               (core16_pf4_bar3_address_width_hwtcl),
       .pf4_bar4_address_width_hwtcl               (core16_pf4_bar4_address_width_hwtcl),
       .pf4_bar5_address_width_hwtcl               (core16_pf4_bar5_address_width_hwtcl),
       .pf5_bar0_address_width_hwtcl               (core16_pf5_bar0_address_width_hwtcl),
       .pf5_bar1_address_width_hwtcl               (core16_pf5_bar1_address_width_hwtcl),
       .pf5_bar2_address_width_hwtcl               (core16_pf5_bar2_address_width_hwtcl),
       .pf5_bar3_address_width_hwtcl               (core16_pf5_bar3_address_width_hwtcl),
       .pf5_bar4_address_width_hwtcl               (core16_pf5_bar4_address_width_hwtcl),
       .pf5_bar5_address_width_hwtcl               (core16_pf5_bar5_address_width_hwtcl),
       .pf6_bar0_address_width_hwtcl               (core16_pf6_bar0_address_width_hwtcl),
       .pf6_bar1_address_width_hwtcl               (core16_pf6_bar1_address_width_hwtcl),
       .pf6_bar2_address_width_hwtcl               (core16_pf6_bar2_address_width_hwtcl),
       .pf6_bar3_address_width_hwtcl               (core16_pf6_bar3_address_width_hwtcl),
       .pf6_bar4_address_width_hwtcl               (core16_pf6_bar4_address_width_hwtcl),
       .pf6_bar5_address_width_hwtcl               (core16_pf6_bar5_address_width_hwtcl),
       .pf7_bar0_address_width_hwtcl               (core16_pf7_bar0_address_width_hwtcl),
       .pf7_bar1_address_width_hwtcl               (core16_pf7_bar1_address_width_hwtcl),
       .pf7_bar2_address_width_hwtcl               (core16_pf7_bar2_address_width_hwtcl),
       .pf7_bar3_address_width_hwtcl               (core16_pf7_bar3_address_width_hwtcl),
       .pf7_bar4_address_width_hwtcl               (core16_pf7_bar4_address_width_hwtcl),
       .pf7_bar5_address_width_hwtcl               (core16_pf7_bar5_address_width_hwtcl),

       .pf0_vf_bar0_address_width_hwtcl            (core16_pf0_sriov_vf_bar0_address_width_hwtcl),
       .pf0_vf_bar1_address_width_hwtcl            (core16_pf0_sriov_vf_bar1_address_width_hwtcl),
       .pf0_vf_bar2_address_width_hwtcl            (core16_pf0_sriov_vf_bar2_address_width_hwtcl),
       .pf0_vf_bar3_address_width_hwtcl            (core16_pf0_sriov_vf_bar3_address_width_hwtcl),
       .pf0_vf_bar4_address_width_hwtcl            (core16_pf0_sriov_vf_bar4_address_width_hwtcl),
       .pf0_vf_bar5_address_width_hwtcl            (core16_pf0_sriov_vf_bar5_address_width_hwtcl),
       .pf1_vf_bar0_address_width_hwtcl            (core16_pf1_sriov_vf_bar0_address_width_hwtcl),
       .pf1_vf_bar1_address_width_hwtcl            (core16_pf1_sriov_vf_bar1_address_width_hwtcl),
       .pf1_vf_bar2_address_width_hwtcl            (core16_pf1_sriov_vf_bar2_address_width_hwtcl),
       .pf1_vf_bar3_address_width_hwtcl            (core16_pf1_sriov_vf_bar3_address_width_hwtcl),
       .pf1_vf_bar4_address_width_hwtcl            (core16_pf1_sriov_vf_bar4_address_width_hwtcl),
       .pf1_vf_bar5_address_width_hwtcl            (core16_pf1_sriov_vf_bar5_address_width_hwtcl),
       .pf2_vf_bar0_address_width_hwtcl            (core16_pf2_sriov_vf_bar0_address_width_hwtcl),
       .pf2_vf_bar1_address_width_hwtcl            (core16_pf2_sriov_vf_bar1_address_width_hwtcl),
       .pf2_vf_bar2_address_width_hwtcl            (core16_pf2_sriov_vf_bar2_address_width_hwtcl),
       .pf2_vf_bar3_address_width_hwtcl            (core16_pf2_sriov_vf_bar3_address_width_hwtcl),
       .pf2_vf_bar4_address_width_hwtcl            (core16_pf2_sriov_vf_bar4_address_width_hwtcl),
       .pf2_vf_bar5_address_width_hwtcl            (core16_pf2_sriov_vf_bar5_address_width_hwtcl),
       .pf3_vf_bar0_address_width_hwtcl            (core16_pf3_sriov_vf_bar0_address_width_hwtcl),
       .pf3_vf_bar1_address_width_hwtcl            (core16_pf3_sriov_vf_bar1_address_width_hwtcl),
       .pf3_vf_bar2_address_width_hwtcl            (core16_pf3_sriov_vf_bar2_address_width_hwtcl),
       .pf3_vf_bar3_address_width_hwtcl            (core16_pf3_sriov_vf_bar3_address_width_hwtcl),
       .pf3_vf_bar4_address_width_hwtcl            (core16_pf3_sriov_vf_bar4_address_width_hwtcl),
       .pf3_vf_bar5_address_width_hwtcl            (core16_pf3_sriov_vf_bar5_address_width_hwtcl),
       .pf4_vf_bar0_address_width_hwtcl            (core16_pf4_sriov_vf_bar0_address_width_hwtcl),
       .pf4_vf_bar1_address_width_hwtcl            (core16_pf4_sriov_vf_bar1_address_width_hwtcl),
       .pf4_vf_bar2_address_width_hwtcl            (core16_pf4_sriov_vf_bar2_address_width_hwtcl),
       .pf4_vf_bar3_address_width_hwtcl            (core16_pf4_sriov_vf_bar3_address_width_hwtcl),
       .pf4_vf_bar4_address_width_hwtcl            (core16_pf4_sriov_vf_bar4_address_width_hwtcl),
       .pf4_vf_bar5_address_width_hwtcl            (core16_pf4_sriov_vf_bar5_address_width_hwtcl),
       .pf5_vf_bar0_address_width_hwtcl            (core16_pf5_sriov_vf_bar0_address_width_hwtcl),
       .pf5_vf_bar1_address_width_hwtcl            (core16_pf5_sriov_vf_bar1_address_width_hwtcl),
       .pf5_vf_bar2_address_width_hwtcl            (core16_pf5_sriov_vf_bar2_address_width_hwtcl),
       .pf5_vf_bar3_address_width_hwtcl            (core16_pf5_sriov_vf_bar3_address_width_hwtcl),
       .pf5_vf_bar4_address_width_hwtcl            (core16_pf5_sriov_vf_bar4_address_width_hwtcl),
       .pf5_vf_bar5_address_width_hwtcl            (core16_pf5_sriov_vf_bar5_address_width_hwtcl),
       .pf6_vf_bar0_address_width_hwtcl            (core16_pf6_sriov_vf_bar0_address_width_hwtcl),
       .pf6_vf_bar1_address_width_hwtcl            (core16_pf6_sriov_vf_bar1_address_width_hwtcl),
       .pf6_vf_bar2_address_width_hwtcl            (core16_pf6_sriov_vf_bar2_address_width_hwtcl),
       .pf6_vf_bar3_address_width_hwtcl            (core16_pf6_sriov_vf_bar3_address_width_hwtcl),
       .pf6_vf_bar4_address_width_hwtcl            (core16_pf6_sriov_vf_bar4_address_width_hwtcl),
       .pf6_vf_bar5_address_width_hwtcl            (core16_pf6_sriov_vf_bar5_address_width_hwtcl),
       .pf7_vf_bar0_address_width_hwtcl            (core16_pf7_sriov_vf_bar0_address_width_hwtcl),
       .pf7_vf_bar1_address_width_hwtcl            (core16_pf7_sriov_vf_bar1_address_width_hwtcl),
       .pf7_vf_bar2_address_width_hwtcl            (core16_pf7_sriov_vf_bar2_address_width_hwtcl),
       .pf7_vf_bar3_address_width_hwtcl            (core16_pf7_sriov_vf_bar3_address_width_hwtcl),
       .pf7_vf_bar4_address_width_hwtcl            (core16_pf7_sriov_vf_bar4_address_width_hwtcl),
       .pf7_vf_bar5_address_width_hwtcl            (core16_pf7_sriov_vf_bar5_address_width_hwtcl)
      
    ) data_mover_inst  (
        // clock and reset
        .clk                                   (clk_wire),
        .rst_n                                 (rst_n_wire),
                                               
        .app_rst_n                             (app_rst_n),

        // Interface to the Streaming ports of HIP.
        //RX Ports
        .rx_st_ready_o                         (rx_st_ready_wire),
        .rx_st_valid_i                         (rx_st_valid_wire),
        .rx_st_sop_i                           (rx_st_sop_wire),
        .rx_st_eop_i                           (rx_st_eop_wire),
        .rx_st_hdr_i                           (rx_st_hdr_switch_wire),
        .rx_st_data_i                          (rx_st_data_wire),
        .rx_st_vf_active_i                     (rx_st_vf_active_wire),
        .rx_st_func_num_i                      (rx_st_func_num_wire),
        .rx_st_vf_num_i                        (rx_st_vf_num_wire),
        .rx_st_bar_range_i                     (rx_st_bar_range_wire),
        .rx_par_err_i                          (rx_par_err_wire),

        //TX Ports
        .tx_st_ready_i                         (tx_st_ready_wire),
        .tx_par_err_i                          (tx_par_err_wire),
        .tx_st_valid_o                         (tx_st_valid_wire),
        .tx_st_sop_o                           (tx_st_sop_wire),
        .tx_st_eop_o                           (tx_st_eop_wire),
        .tx_st_err_o                           (tx_st_err_wire),
        .tx_st_hdr_o                           (tx_st_hdr_switch_wire),
        .tx_st_data_o                          (tx_st_data_wire),
        .tx_st_vf_active_o                     (tx_st_vf_active_wire),

        // Streaming Packets HIP Credit Interface.
        .tx_cdts_limit_i                       (tx_cdts_limit_i            ),
        .tx_cdts_limit_tdm_idx_i               (tx_cdts_limit_tdm_idx_i    ),
        .rx_buffer_limit_o                     (rx_buffer_limit_o          ),
        .rx_buffer_limit_tdm_idx_o             (rx_buffer_limit_tdm_idx_o  ),


        // HIP Misc interface
        // Config Interface
        .hip_tl_cfg_func_i                     (tl_cfg_func_wire),
        .hip_tl_cfg_add_i                      (tl_cfg_add_wire ),
        .hip_tl_cfg_ctl_i                      (tl_cfg_ctl_wire ),

        // HIP REconfig interface
        .hip_reconfig_clk_o                    ( hip_reconfig_clk_o           ) ,
        .hip_reconfig_address_o                ( hip_reconfig_address_o       ) ,
        .hip_reconfig_read_o                   ( hip_reconfig_read_o          ) ,
        .hip_reconfig_readdata_i               ( hip_reconfig_readdata_i      ) ,
        .hip_reconfig_readdatavalid_i          ( hip_reconfig_readdatavalid_i ) ,
        .hip_reconfig_waitrequest_i            ( hip_reconfig_waitrequest_i   ) ,
        .hip_reconfig_write_o                  ( hip_reconfig_write_o         ),
        .hip_reconfig_writedata_o              ( hip_reconfig_writedata_o     ),
        

        .usr_hip_reconfig_clk_i          (usr_hip_reconfig_clk_i            ),
        .usr_hip_reconfig_address_i      (usr_hip_reconfig_address_i        ),  
        .usr_hip_reconfig_read_i         (usr_hip_reconfig_read_i           ),  
        .usr_hip_reconfig_write_i        (usr_hip_reconfig_write_i          ),   
        .usr_hip_reconfig_writedata_i    (usr_hip_reconfig_writedata_i      ),
        .usr_hip_reconfig_readdata_o     (usr_hip_reconfig_readdata_o       ),     
        .usr_hip_reconfig_readdatavalid_o(usr_hip_reconfig_readdatavalid_o  ),
        .usr_hip_reconfig_waitrequest_o  (usr_hip_reconfig_waitrequest_o    ),

        .usr_hip_tl_cfg_ctl_o (usr_hip_tl_cfg_ctl_o ),
        .usr_hip_tl_cfg_add_o (usr_hip_tl_cfg_add_o ), 
        .usr_hip_tl_cfg_func_o(usr_hip_tl_cfg_func_o),

        // H2D AVMM Master Interface
        .h2ddm_waitrequest_i                   ( h2ddm_waitrequest_i          ) ,
        .h2ddm_writeresponsevalid_i            ( h2ddm_writeresponsevalid_i   ) ,
        .h2ddm_write_o                         ( h2ddm_write_o                ) ,
        .h2ddm_address_o                       ( h2ddm_address_o              ) ,
        .h2ddm_burstcount_o                    ( h2ddm_burstcount_o           ) ,
        .h2ddm_byteenable_o                    ( h2ddm_byteenable_o           ) ,
        .h2ddm_writedata_o                     ( h2ddm_writedata_o            ) ,

        // D2H AVMM Read Master Interface
        .d2hdm_address_o                       ( d2hdm_address_o              ) ,
        .d2hdm_byteenable_o                    ( d2hdm_byteenable_o           ) ,
        .d2hdm_read_o                          ( d2hdm_read_o                 ) ,
        .d2hdm_burstcount_o                    ( d2hdm_burstcount_o           ) ,
        .d2hdm_waitrequest_i                   ( d2hdm_waitrequest_i          ) ,
        .d2hdm_readdata_i                      ( d2hdm_readdata_i             ) ,
        .d2hdm_readdatavalid_i                 ( d2hdm_readdatavalid_i        ) ,
        .d2hdm_response_i                      ( d2hdm_response_i             ) ,

        .h2ddm_desc_ready_o                    ( h2ddm_desc_ready_o                ),
        .h2ddm_desc_valid_i                    ( h2ddm_desc_valid_i                ), 
        .h2ddm_desc_data_i                     ( h2ddm_desc_data_i                 ), // h2d_desc_bypass_t
                                               
        .h2ddm_desc_status_data_o              ( h2ddm_desc_status_data_o          ), // h2d_desc_status_t
        .h2ddm_desc_status_valid_o             ( h2ddm_desc_status_valid_o         ),
                                               
        .h2ddm_desc_cmpl_data_o                ( h2ddm_desc_cmpl_data_o            ), // h2d_desc_cmpl_t
        .h2ddm_desc_cmpl_empty_o               ( h2ddm_desc_cmpl_empty_o           ), 
        .h2ddm_desc_cmpl_sop_o                 ( h2ddm_desc_cmpl_sop_o             ), 
        .h2ddm_desc_cmpl_eop_o                 ( h2ddm_desc_cmpl_eop_o             ), 
        .h2ddm_desc_cmpl_valid_o               ( h2ddm_desc_cmpl_valid_o           ), 
        .h2ddm_desc_cmpl_ready_i               ( h2ddm_desc_cmpl_ready_i           ),
                                               
        .d2hdm_desc_ready_o                    ( d2hdm_desc_ready_o                ), 
        .d2hdm_desc_valid_i                    ( d2hdm_desc_valid_i                ), 
        .d2hdm_desc_data_i                     ( d2hdm_desc_data_i                 ), // d2h_desc_bypass_t
                                               
        .d2hdm_desc_status_data_o              ( d2hdm_desc_status_data_o          ), // d2h_desc_status_t
        .d2hdm_desc_status_valid_o             ( d2hdm_desc_status_valid_o         ),

        // AVMM Master PIO interface
        .rx_pio_address_o                      ( rx_pio_address_o             ) ,
        .rx_pio_byteenable_o                   ( rx_pio_byteenable_o          ) ,
        .rx_pio_read_o                         ( rx_pio_read_o                ) ,
        .rx_pio_write_o                        ( rx_pio_write_o               ) ,
        .rx_pio_writedata_o                    ( rx_pio_writedata_o           ) ,
        .rx_pio_burstcount_o                   ( rx_pio_burstcount_o          ) ,
        .rx_pio_waitrequest_i                  ( rx_pio_waitrequest_i         ) ,
        .rx_pio_readdata_i                     ( rx_pio_readdata_i            ) ,
        .rx_pio_readdatavalid_i                ( rx_pio_readdatavalid_i       ) ,
        .rx_pio_response_i                     ( rx_pio_response_i            ) ,
        .rx_pio_writeresponsevalid_i           ( rx_pio_writeresponsevalid_i  ) ,

        // FLR interface from HIP
        .flr_rcvd_pf_i                         ( flr_rcvd_pf_i                ) ,
        .flr_rcvd_vf_i                         ( flr_rcvd_vf_i                ) ,
        .flr_rcvd_pf_num_i                     ( flr_rcvd_pf_num_i            ) ,
        .flr_rcvd_vf_num_i                     ( flr_rcvd_vf_num_i            ) ,
        .flr_completed_pf_o                    ( flr_completed_pf_o           ) ,
        .flr_completed_vf_o                    ( flr_completed_vf_o           ) ,
        .flr_completed_pf_num_o                ( flr_completed_pf_num_o       ) ,
        .flr_completed_vf_num_o                ( flr_completed_vf_num_o       ) ,
        //  Completion Timeout Interface (only in P-tile)
        .cpl_timeout_i                         ( cpl_timeout_i                    ),
        .cpl_timeout_avmm_clk_o                ( cpl_timeout_avmm_clk_o           ),
        .cpl_timeout_avmm_waitrequest_i        ( cpl_timeout_avmm_waitrequest_i   ),
        .cpl_timeout_avmm_read_o               ( cpl_timeout_avmm_read_o          ),
        .cpl_timeout_avmm_address_o            ( cpl_timeout_avmm_address_o       ), // [20:3] : Reserved. Tie them to 0. 
        .cpl_timeout_avmm_write_o              ( cpl_timeout_avmm_write_o         ),
        .cpl_timeout_avmm_writedata_o          ( cpl_timeout_avmm_writedata_o     ),
        .cpl_timeout_avmm_readdata_i           ( cpl_timeout_avmm_readdata_i      ),
        .cpl_timeout_avmm_readdatavalid_i      ( cpl_timeout_avmm_readdatavalid_i ),
        // Error interface to HIP
        .app_err_valid_o                       ( app_err_valid_o              ) ,
        .app_err_hdr_o                         ( app_err_hdr_o                ) ,
        .app_err_info_o                        ( app_err_info_o               ) , //S10:app_err_info[10:0]
        .app_err_func_num_o                    ( app_err_func_num_o           ) , //S10: app_err_func_num[1:0]

        //BAS
        .bas_vfactive_i                        ( (enable_bursting_slave_hwtcl) ? bas_vfactive_i    : '0 ),
        .bas_pfnum_i                           ( (enable_bursting_slave_hwtcl) ? bas_pfnum_i       : '0 ),              
        .bas_vfnum_i                           ( (enable_bursting_slave_hwtcl) ? bas_vfnum_i       : '0 ),   
        .bas_address_i                         ( (enable_bursting_slave_hwtcl) ? bas_address_i     : '0 ),     
        .bas_byteenable_i                      ( (enable_bursting_slave_hwtcl) ? bas_byteenable_i  : '0 ),            
        .bas_read_i                            ( (enable_bursting_slave_hwtcl) ? bas_read_i        : '0 ),      
        .bas_write_i                           ( (enable_bursting_slave_hwtcl) ? bas_write_i       : '0 ),  
        .bas_writedata_i                       ( (enable_bursting_slave_hwtcl) ? bas_writedata_i   : '0 ),
        .bas_burstcount_i                      ( (enable_bursting_slave_hwtcl) ? bas_burstcount_i  : '0 ),
        .bas_waitrequest_o                     (  bas_waitrequest_o   ),
        .bas_readdata_o                        (  bas_readdata_o      ),
        .bas_readdatavalid_o                   (  bas_readdatavalid_o ),
        .bas_response_o                        (  bas_response_o      ),

        // BAM interface
        .bam_readdatavalid_i                   ( (enable_bursting_master_hwtcl) ? bam_readdatavalid_i : '0 ),
        .bam_readdata_i                        ( (enable_bursting_master_hwtcl) ? bam_readdata_i      : '0 ),
        .bam_waitrequest_i                     ( (enable_bursting_master_hwtcl) ? bam_waitrequest_i   : '0 ),
      //.bam_vfactive_o                        ( bam_vfactive_o   ),
      //.bam_pfnum_o                           ( bam_pfnum_o      ),
      //.bam_vfnum_o                           ( bam_vfnum_o      ),
      //.bam_bar_o                             ( bam_bar_o        ),
        .bam_address_o                         ( bam_address_o    ),
        .bam_burstcount_o                      ( bam_burstcount_o ),
        .bam_byteenable_o                      ( bam_byteenable_o ),
        .bam_read_o                            ( bam_read_o       ),
        .bam_write_o                           ( bam_write_o      ),
        .bam_writedata_o                       ( bam_writedata_o  )
      );

   end else begin : dma_mode

      if (num_h2d_uport_hwtcl <= 1) begin : h2d_avst_port
         for (genvar i=1; i<4; i++) begin : port_loop
            assign h2d_st_sof_o      [i] = '0;
            assign h2d_st_eof_o      [i] = '0;
            assign h2d_st_empty_o    [i] = '0;
            assign h2d_st_valid_o    [i] = '0;
            assign h2d_st_data_o     [i] = '0;
            assign h2d_st_channel_o  [i] = '0;
         end
      end

      if (num_d2h_uport_hwtcl <= 1) begin : d2h_avst_port
         for (genvar i=1; i<4; i++) begin : port_loop
            assign d2h_st_ready_o    [i] = '0;
         end
      end

      assign d2hdm_desc_ready_o           = '0;
      assign d2hdm_desc_status_data_o     = '0;
      assign d2hdm_desc_status_valid_o    = '0;
      assign h2ddm_desc_cmpl_data_o       = '0;
      assign h2ddm_desc_cmpl_empty_o      = '0;
      assign h2ddm_desc_cmpl_eop_o        = '0;
      assign h2ddm_desc_cmpl_sop_o        = '0;
      assign h2ddm_desc_cmpl_valid_o      = '0;
      assign h2ddm_desc_ready_o           = '0;
      assign h2ddm_desc_status_data_o     = '0;
      assign h2ddm_desc_status_valid_o    = '0;

  // Multi Channel DMA IP instantiation
   intel_pcie_mcdma  
      #(
      // The value type (integer/string) will change based on hw_tcl development.
       .device_family_hwtcl                        (device_family_hwtcl          ),
       .tile_hwtcl                                 (tile_hwtcl                   ),
       .avst_endianness_big                        (avst_endianness_big          ),
       .enable_user_flr_hwtcl                      (enable_user_flr_hwtcl        ),
       .en_metadata_8_hwtcl                        (en_metadata_8_hwtcl          ),
       .en_10bit_tag_hwtcl                         (en_10bit_tag_hwtcl           ),
       .enable_bursting_master_hwtcl               (enable_bursting_master_hwtcl ),
       .enable_bursting_slave_hwtcl                (enable_bursting_slave_hwtcl  ),
       .enable_mcdma_hwtcl                         (enable_mcdma_hwtcl           ),
       .enable_cs_hwtcl                            (enable_cs_hwtcl              ),
       .data_width_hwtcl                           (data_width_hwtcl             ),
       .einfo_width_hwtcl                          (einfo_width_hwtcl            ),
       .pfnum_hwtcl                                (pfnum_hwtcl                  ),
       .pfcnt_w_hwtcl                              (pfcnt_w_hwtcl                ),
       .vfcnt_w_hwtcl                              (vfcnt_w_hwtcl                ),
       .max_bar_address_width_hwtcl                (max_bar_address_width_hwtcl  ),
       .pfnum_width_hwtcl                          (pfnum_width_hwtcl            ),
       .vfnum_width_hwtcl                          (vfnum_width_hwtcl            ),
       .pio_address_width_hwtcl                    (pio_address_width_hwtcl      ),
       .pio_data_width_hwtcl                       (pio_data_width_hwtcl         ),
       .pio_bar2_size_per_f_hwtcl                  (pio_bar2_size_per_f_hwtcl    ),
       .num_h2d_uport_hwtcl                        (num_h2d_uport_hwtcl          ),
       .num_d2h_uport_hwtcl                        (num_d2h_uport_hwtcl          ),
       .uport_type_h2d_hwtcl                       (uport_type_h2d_hwtcl         ),
       .uport_type_d2h_hwtcl                       (uport_type_d2h_hwtcl         ),
       .d2h_num_active_channel_hwtcl               (d2h_num_active_channel_hwtcl ),
       .d2h_max_num_desc_fetch_hwtcl               (d2h_max_num_desc_fetch_hwtcl ),
       .pf0_enable_sriov_hwtcl                     (pf0_enable_sriov_hwtcl       ),
       .pf0_num_vf_per_pf_hwtcl                    (pf0_num_vf_per_pf_hwtcl      ),
       .pf0_num_dma_chan_pf_hwtcl                  (pf0_num_dma_chan_pf_hwtcl    ),
       .pf0_num_dma_chan_per_vf_hwtcl              (pf0_num_dma_chan_per_vf_hwtcl),
       .pf1_enable_sriov_hwtcl                     (pf1_enable_sriov_hwtcl       ),
       .pf1_num_vf_per_pf_hwtcl                    (pf1_num_vf_per_pf_hwtcl      ),
       .pf1_num_dma_chan_pf_hwtcl                  (pf1_num_dma_chan_pf_hwtcl    ),
       .pf1_num_dma_chan_per_vf_hwtcl              (pf1_num_dma_chan_per_vf_hwtcl),
       .pf2_enable_sriov_hwtcl                     (pf2_enable_sriov_hwtcl       ),
       .pf2_num_vf_per_pf_hwtcl                    (pf2_num_vf_per_pf_hwtcl      ),
       .pf2_num_dma_chan_pf_hwtcl                  (pf2_num_dma_chan_pf_hwtcl    ),
       .pf2_num_dma_chan_per_vf_hwtcl              (pf2_num_dma_chan_per_vf_hwtcl),
       .pf3_enable_sriov_hwtcl                     (pf3_enable_sriov_hwtcl       ),
       .pf3_num_vf_per_pf_hwtcl                    (pf3_num_vf_per_pf_hwtcl      ),
       .pf3_num_dma_chan_pf_hwtcl                  (pf3_num_dma_chan_pf_hwtcl    ),
       .pf3_num_dma_chan_per_vf_hwtcl              (pf3_num_dma_chan_per_vf_hwtcl),
       .pf4_enable_sriov_hwtcl                     (pf4_enable_sriov_hwtcl       ),
       .pf4_num_vf_per_pf_hwtcl                    (pf4_num_vf_per_pf_hwtcl      ),
       .pf4_num_dma_chan_pf_hwtcl                  (pf4_num_dma_chan_pf_hwtcl    ),
       .pf4_num_dma_chan_per_vf_hwtcl              (pf4_num_dma_chan_per_vf_hwtcl),
       .pf5_enable_sriov_hwtcl                     (pf5_enable_sriov_hwtcl       ),
       .pf5_num_vf_per_pf_hwtcl                    (pf5_num_vf_per_pf_hwtcl      ),
       .pf5_num_dma_chan_pf_hwtcl                  (pf5_num_dma_chan_pf_hwtcl    ),
       .pf5_num_dma_chan_per_vf_hwtcl              (pf5_num_dma_chan_per_vf_hwtcl),
       .pf6_enable_sriov_hwtcl                     (pf6_enable_sriov_hwtcl       ),
       .pf6_num_vf_per_pf_hwtcl                    (pf6_num_vf_per_pf_hwtcl      ),
       .pf6_num_dma_chan_pf_hwtcl                  (pf6_num_dma_chan_pf_hwtcl    ),
       .pf6_num_dma_chan_per_vf_hwtcl              (pf6_num_dma_chan_per_vf_hwtcl),
       .pf7_enable_sriov_hwtcl                     (pf7_enable_sriov_hwtcl       ),
       .pf7_num_vf_per_pf_hwtcl                    (pf7_num_vf_per_pf_hwtcl      ),
       .pf7_num_dma_chan_pf_hwtcl                  (pf7_num_dma_chan_pf_hwtcl    ),
       .pf7_num_dma_chan_per_vf_hwtcl              (pf7_num_dma_chan_per_vf_hwtcl),
       .cs_address_width_hwtcl                     (cs_address_width_hwtcl       ),

       .pf0_bar0_address_width_hwtcl               (core16_pf0_bar0_address_width_hwtcl),
       .pf0_bar1_address_width_hwtcl               (core16_pf0_bar1_address_width_hwtcl),
       .pf0_bar2_address_width_hwtcl               (core16_pf0_bar2_address_width_hwtcl),
       .pf0_bar3_address_width_hwtcl               (core16_pf0_bar3_address_width_hwtcl),
       .pf0_bar4_address_width_hwtcl               (core16_pf0_bar4_address_width_hwtcl),
       .pf0_bar5_address_width_hwtcl               (core16_pf0_bar5_address_width_hwtcl),
       .pf1_bar0_address_width_hwtcl               (core16_pf1_bar0_address_width_hwtcl),
       .pf1_bar1_address_width_hwtcl               (core16_pf1_bar1_address_width_hwtcl),
       .pf1_bar2_address_width_hwtcl               (core16_pf1_bar2_address_width_hwtcl),
       .pf1_bar3_address_width_hwtcl               (core16_pf1_bar3_address_width_hwtcl),
       .pf1_bar4_address_width_hwtcl               (core16_pf1_bar4_address_width_hwtcl),
       .pf1_bar5_address_width_hwtcl               (core16_pf1_bar5_address_width_hwtcl),
       .pf2_bar0_address_width_hwtcl               (core16_pf2_bar0_address_width_hwtcl),
       .pf2_bar1_address_width_hwtcl               (core16_pf2_bar1_address_width_hwtcl),
       .pf2_bar2_address_width_hwtcl               (core16_pf2_bar2_address_width_hwtcl),
       .pf2_bar3_address_width_hwtcl               (core16_pf2_bar3_address_width_hwtcl),
       .pf2_bar4_address_width_hwtcl               (core16_pf2_bar4_address_width_hwtcl),
       .pf2_bar5_address_width_hwtcl               (core16_pf2_bar5_address_width_hwtcl),
       .pf3_bar0_address_width_hwtcl               (core16_pf3_bar0_address_width_hwtcl),
       .pf3_bar1_address_width_hwtcl               (core16_pf3_bar1_address_width_hwtcl),
       .pf3_bar2_address_width_hwtcl               (core16_pf3_bar2_address_width_hwtcl),
       .pf3_bar3_address_width_hwtcl               (core16_pf3_bar3_address_width_hwtcl),
       .pf3_bar4_address_width_hwtcl               (core16_pf3_bar4_address_width_hwtcl),
       .pf3_bar5_address_width_hwtcl               (core16_pf3_bar5_address_width_hwtcl),
       .pf4_bar0_address_width_hwtcl               (core16_pf4_bar0_address_width_hwtcl),
       .pf4_bar1_address_width_hwtcl               (core16_pf4_bar1_address_width_hwtcl),
       .pf4_bar2_address_width_hwtcl               (core16_pf4_bar2_address_width_hwtcl),
       .pf4_bar3_address_width_hwtcl               (core16_pf4_bar3_address_width_hwtcl),
       .pf4_bar4_address_width_hwtcl               (core16_pf4_bar4_address_width_hwtcl),
       .pf4_bar5_address_width_hwtcl               (core16_pf4_bar5_address_width_hwtcl),
       .pf5_bar0_address_width_hwtcl               (core16_pf5_bar0_address_width_hwtcl),
       .pf5_bar1_address_width_hwtcl               (core16_pf5_bar1_address_width_hwtcl),
       .pf5_bar2_address_width_hwtcl               (core16_pf5_bar2_address_width_hwtcl),
       .pf5_bar3_address_width_hwtcl               (core16_pf5_bar3_address_width_hwtcl),
       .pf5_bar4_address_width_hwtcl               (core16_pf5_bar4_address_width_hwtcl),
       .pf5_bar5_address_width_hwtcl               (core16_pf5_bar5_address_width_hwtcl),
       .pf6_bar0_address_width_hwtcl               (core16_pf6_bar0_address_width_hwtcl),
       .pf6_bar1_address_width_hwtcl               (core16_pf6_bar1_address_width_hwtcl),
       .pf6_bar2_address_width_hwtcl               (core16_pf6_bar2_address_width_hwtcl),
       .pf6_bar3_address_width_hwtcl               (core16_pf6_bar3_address_width_hwtcl),
       .pf6_bar4_address_width_hwtcl               (core16_pf6_bar4_address_width_hwtcl),
       .pf6_bar5_address_width_hwtcl               (core16_pf6_bar5_address_width_hwtcl),
       .pf7_bar0_address_width_hwtcl               (core16_pf7_bar0_address_width_hwtcl),
       .pf7_bar1_address_width_hwtcl               (core16_pf7_bar1_address_width_hwtcl),
       .pf7_bar2_address_width_hwtcl               (core16_pf7_bar2_address_width_hwtcl),
       .pf7_bar3_address_width_hwtcl               (core16_pf7_bar3_address_width_hwtcl),
       .pf7_bar4_address_width_hwtcl               (core16_pf7_bar4_address_width_hwtcl),
       .pf7_bar5_address_width_hwtcl               (core16_pf7_bar5_address_width_hwtcl),

       .pf0_vf_bar0_address_width_hwtcl            (core16_pf0_sriov_vf_bar0_address_width_hwtcl),
       .pf0_vf_bar1_address_width_hwtcl            (core16_pf0_sriov_vf_bar1_address_width_hwtcl),
       .pf0_vf_bar2_address_width_hwtcl            (core16_pf0_sriov_vf_bar2_address_width_hwtcl),
       .pf0_vf_bar3_address_width_hwtcl            (core16_pf0_sriov_vf_bar3_address_width_hwtcl),
       .pf0_vf_bar4_address_width_hwtcl            (core16_pf0_sriov_vf_bar4_address_width_hwtcl),
       .pf0_vf_bar5_address_width_hwtcl            (core16_pf0_sriov_vf_bar5_address_width_hwtcl),
       .pf1_vf_bar0_address_width_hwtcl            (core16_pf1_sriov_vf_bar0_address_width_hwtcl),
       .pf1_vf_bar1_address_width_hwtcl            (core16_pf1_sriov_vf_bar1_address_width_hwtcl),
       .pf1_vf_bar2_address_width_hwtcl            (core16_pf1_sriov_vf_bar2_address_width_hwtcl),
       .pf1_vf_bar3_address_width_hwtcl            (core16_pf1_sriov_vf_bar3_address_width_hwtcl),
       .pf1_vf_bar4_address_width_hwtcl            (core16_pf1_sriov_vf_bar4_address_width_hwtcl),
       .pf1_vf_bar5_address_width_hwtcl            (core16_pf1_sriov_vf_bar5_address_width_hwtcl),
       .pf2_vf_bar0_address_width_hwtcl            (core16_pf2_sriov_vf_bar0_address_width_hwtcl),
       .pf2_vf_bar1_address_width_hwtcl            (core16_pf2_sriov_vf_bar1_address_width_hwtcl),
       .pf2_vf_bar2_address_width_hwtcl            (core16_pf2_sriov_vf_bar2_address_width_hwtcl),
       .pf2_vf_bar3_address_width_hwtcl            (core16_pf2_sriov_vf_bar3_address_width_hwtcl),
       .pf2_vf_bar4_address_width_hwtcl            (core16_pf2_sriov_vf_bar4_address_width_hwtcl),
       .pf2_vf_bar5_address_width_hwtcl            (core16_pf2_sriov_vf_bar5_address_width_hwtcl),
       .pf3_vf_bar0_address_width_hwtcl            (core16_pf3_sriov_vf_bar0_address_width_hwtcl),
       .pf3_vf_bar1_address_width_hwtcl            (core16_pf3_sriov_vf_bar1_address_width_hwtcl),
       .pf3_vf_bar2_address_width_hwtcl            (core16_pf3_sriov_vf_bar2_address_width_hwtcl),
       .pf3_vf_bar3_address_width_hwtcl            (core16_pf3_sriov_vf_bar3_address_width_hwtcl),
       .pf3_vf_bar4_address_width_hwtcl            (core16_pf3_sriov_vf_bar4_address_width_hwtcl),
       .pf3_vf_bar5_address_width_hwtcl            (core16_pf3_sriov_vf_bar5_address_width_hwtcl),
       .pf4_vf_bar0_address_width_hwtcl            (core16_pf4_sriov_vf_bar0_address_width_hwtcl),
       .pf4_vf_bar1_address_width_hwtcl            (core16_pf4_sriov_vf_bar1_address_width_hwtcl),
       .pf4_vf_bar2_address_width_hwtcl            (core16_pf4_sriov_vf_bar2_address_width_hwtcl),
       .pf4_vf_bar3_address_width_hwtcl            (core16_pf4_sriov_vf_bar3_address_width_hwtcl),
       .pf4_vf_bar4_address_width_hwtcl            (core16_pf4_sriov_vf_bar4_address_width_hwtcl),
       .pf4_vf_bar5_address_width_hwtcl            (core16_pf4_sriov_vf_bar5_address_width_hwtcl),
       .pf5_vf_bar0_address_width_hwtcl            (core16_pf5_sriov_vf_bar0_address_width_hwtcl),
       .pf5_vf_bar1_address_width_hwtcl            (core16_pf5_sriov_vf_bar1_address_width_hwtcl),
       .pf5_vf_bar2_address_width_hwtcl            (core16_pf5_sriov_vf_bar2_address_width_hwtcl),
       .pf5_vf_bar3_address_width_hwtcl            (core16_pf5_sriov_vf_bar3_address_width_hwtcl),
       .pf5_vf_bar4_address_width_hwtcl            (core16_pf5_sriov_vf_bar4_address_width_hwtcl),
       .pf5_vf_bar5_address_width_hwtcl            (core16_pf5_sriov_vf_bar5_address_width_hwtcl),
       .pf6_vf_bar0_address_width_hwtcl            (core16_pf6_sriov_vf_bar0_address_width_hwtcl),
       .pf6_vf_bar1_address_width_hwtcl            (core16_pf6_sriov_vf_bar1_address_width_hwtcl),
       .pf6_vf_bar2_address_width_hwtcl            (core16_pf6_sriov_vf_bar2_address_width_hwtcl),
       .pf6_vf_bar3_address_width_hwtcl            (core16_pf6_sriov_vf_bar3_address_width_hwtcl),
       .pf6_vf_bar4_address_width_hwtcl            (core16_pf6_sriov_vf_bar4_address_width_hwtcl),
       .pf6_vf_bar5_address_width_hwtcl            (core16_pf6_sriov_vf_bar5_address_width_hwtcl),
       .pf7_vf_bar0_address_width_hwtcl            (core16_pf7_sriov_vf_bar0_address_width_hwtcl),
       .pf7_vf_bar1_address_width_hwtcl            (core16_pf7_sriov_vf_bar1_address_width_hwtcl),
       .pf7_vf_bar2_address_width_hwtcl            (core16_pf7_sriov_vf_bar2_address_width_hwtcl),
       .pf7_vf_bar3_address_width_hwtcl            (core16_pf7_sriov_vf_bar3_address_width_hwtcl),
       .pf7_vf_bar4_address_width_hwtcl            (core16_pf7_sriov_vf_bar4_address_width_hwtcl),
       .pf7_vf_bar5_address_width_hwtcl            (core16_pf7_sriov_vf_bar5_address_width_hwtcl)
      
    ) mcdma_inst  (
        // clock and reset
        .clk                                   (clk_wire),
        .rst_n                                 (rst_n_wire),
                                               
        .app_rst_n                             (app_rst_n),

        // Interface to the Streaming ports of HIP.
        //RX Ports
        .rx_st_ready_o                         (rx_st_ready_wire),
        .rx_st_valid_i                         (rx_st_valid_wire),
        .rx_st_sop_i                           (rx_st_sop_wire),
        .rx_st_eop_i                           (rx_st_eop_wire),
        .rx_st_hdr_i                           (rx_st_hdr_switch_wire),
        .rx_st_data_i                          (rx_st_data_wire),
        .rx_st_vf_active_i                     (rx_st_vf_active_wire),
        .rx_st_func_num_i                      (rx_st_func_num_wire),
        .rx_st_vf_num_i                        (rx_st_vf_num_wire),
        .rx_st_bar_range_i                     (rx_st_bar_range_wire),
        .rx_par_err_i                          (rx_par_err_wire),

        //TX Ports
        .tx_st_ready_i                         (tx_st_ready_wire),
        .tx_par_err_i                          (tx_par_err_wire),
        .tx_st_valid_o                         (tx_st_valid_wire),
        .tx_st_sop_o                           (tx_st_sop_wire),
        .tx_st_eop_o                           (tx_st_eop_wire),
        .tx_st_err_o                           (tx_st_err_wire),
        .tx_st_hdr_o                           (tx_st_hdr_switch_wire),
        .tx_st_data_o                          (tx_st_data_wire),
        .tx_st_vf_active_o                     (tx_st_vf_active_wire),

        // Streaming Packets HIP Credit Interface.
        .tx_cdts_limit_i                       (tx_cdts_limit_i            ),
        .tx_cdts_limit_tdm_idx_i               (tx_cdts_limit_tdm_idx_i    ),
        .rx_buffer_limit_o                     (rx_buffer_limit_o          ),
        .rx_buffer_limit_tdm_idx_o             (rx_buffer_limit_tdm_idx_o  ),


        // HIP Misc interface
        // Config Interface
        .hip_tl_cfg_func_i                     (tl_cfg_func_wire),
        .hip_tl_cfg_add_i                      (tl_cfg_add_wire ),
        .hip_tl_cfg_ctl_i                      (tl_cfg_ctl_wire ),

        // HIP REconfig interface
        .hip_reconfig_clk_o                    ( hip_reconfig_clk_o           ) ,
        .hip_reconfig_address_o                ( hip_reconfig_address_o       ) ,
        .hip_reconfig_read_o                   ( hip_reconfig_read_o          ) ,
        .hip_reconfig_readdata_i               ( hip_reconfig_readdata_i      ) ,
        .hip_reconfig_readdatavalid_i          ( hip_reconfig_readdatavalid_i ) ,
        .hip_reconfig_waitrequest_i            ( hip_reconfig_waitrequest_i   ) ,
        .hip_reconfig_write_o                  ( hip_reconfig_write_o         ),
        .hip_reconfig_writedata_o              ( hip_reconfig_writedata_o     ),
        

        .usr_hip_reconfig_clk_i          (usr_hip_reconfig_clk_i            ),
        .usr_hip_reconfig_address_i      (usr_hip_reconfig_address_i        ),  
        .usr_hip_reconfig_read_i         (usr_hip_reconfig_read_i           ),  
        .usr_hip_reconfig_write_i        (usr_hip_reconfig_write_i          ),   
        .usr_hip_reconfig_writedata_i    (usr_hip_reconfig_writedata_i      ),
        .usr_hip_reconfig_readdata_o     (usr_hip_reconfig_readdata_o       ),     
        .usr_hip_reconfig_readdatavalid_o(usr_hip_reconfig_readdatavalid_o  ),
        .usr_hip_reconfig_waitrequest_o  (usr_hip_reconfig_waitrequest_o    ),

        .usr_hip_tl_cfg_ctl_o (usr_hip_tl_cfg_ctl_o ),
        .usr_hip_tl_cfg_add_o (usr_hip_tl_cfg_add_o ), 
        .usr_hip_tl_cfg_func_o(usr_hip_tl_cfg_func_o),



        // H2D AVST Master Interface
        .h2d_st_sof_o                          ( h2d_st_sof_o     [0:num_h2d_uport_hwtcl-1] ) ,
        .h2d_st_eof_o                          ( h2d_st_eof_o     [0:num_h2d_uport_hwtcl-1] ) ,
        .h2d_st_empty_o                        ( h2d_st_empty_o   [0:num_h2d_uport_hwtcl-1] ) ,
        .h2d_st_ready_i                        ( h2d_st_ready_i   [0:num_h2d_uport_hwtcl-1] ) ,
        .h2d_st_valid_o                        ( h2d_st_valid_o   [0:num_h2d_uport_hwtcl-1] ) ,
        .h2d_st_data_o                         ( h2d_st_data_o    [0:num_h2d_uport_hwtcl-1] ) ,
        .h2d_st_channel_o                      ( h2d_st_channel_o [0:num_h2d_uport_hwtcl-1] ) ,

        // H2D AVMM Master Interface
        .h2ddm_waitrequest_i                   ( h2ddm_waitrequest_i          ) ,
        .h2ddm_writeresponsevalid_i            ( h2ddm_writeresponsevalid_i   ) ,
        .h2ddm_write_o                         ( h2ddm_write_o                ) ,
        .h2ddm_address_o                       ( h2ddm_address_o              ) ,
        .h2ddm_burstcount_o                    ( h2ddm_burstcount_o           ) ,
        .h2ddm_byteenable_o                    ( h2ddm_byteenable_o           ) ,
        .h2ddm_writedata_o                     ( h2ddm_writedata_o            ) ,

        // D2H AVST Slave Interface
        .d2h_st_sof_i                          ( d2h_st_sof_i     [0:num_d2h_uport_hwtcl-1] ) ,
        .d2h_st_eof_i                          ( d2h_st_eof_i     [0:num_d2h_uport_hwtcl-1] ) ,
        .d2h_st_empty_i                        ( d2h_st_empty_i   [0:num_d2h_uport_hwtcl-1] ) ,
        .d2h_st_channel_i                      ( d2h_st_channel_i [0:num_d2h_uport_hwtcl-1] ) ,
        .d2h_st_valid_i                        ( d2h_st_valid_i   [0:num_d2h_uport_hwtcl-1] ) ,
        .d2h_st_data_i                         ( d2h_st_data_i    [0:num_d2h_uport_hwtcl-1] ) ,
        .d2h_st_ready_o                        ( d2h_st_ready_o   [0:num_d2h_uport_hwtcl-1] ) ,

        // D2H AVMM Read Master Interface
        .d2hdm_address_o                       ( d2hdm_address_o              ) ,
        .d2hdm_byteenable_o                    ( d2hdm_byteenable_o           ) ,
        .d2hdm_read_o                          ( d2hdm_read_o                 ) ,
        .d2hdm_burstcount_o                    ( d2hdm_burstcount_o           ) ,
        .d2hdm_waitrequest_i                   ( d2hdm_waitrequest_i          ) ,
        .d2hdm_readdata_i                      ( d2hdm_readdata_i             ) ,
        .d2hdm_readdatavalid_i                 ( d2hdm_readdatavalid_i        ) ,
        .d2hdm_response_i                      ( d2hdm_response_i             ) ,
        // AVMM Master PIO interface
        .rx_pio_address_o                      ( rx_pio_address_o             ) ,
        .rx_pio_byteenable_o                   ( rx_pio_byteenable_o          ) ,
        .rx_pio_read_o                         ( rx_pio_read_o                ) ,
        .rx_pio_write_o                        ( rx_pio_write_o               ) ,
        .rx_pio_writedata_o                    ( rx_pio_writedata_o           ) ,
        .rx_pio_burstcount_o                   ( rx_pio_burstcount_o          ) ,
        .rx_pio_waitrequest_i                  ( rx_pio_waitrequest_i         ) ,
        .rx_pio_readdata_i                     ( rx_pio_readdata_i            ) ,
        .rx_pio_readdatavalid_i                ( rx_pio_readdatavalid_i       ) ,
        .rx_pio_response_i                     ( rx_pio_response_i            ) ,
        .rx_pio_writeresponsevalid_i           ( rx_pio_writeresponsevalid_i  ) ,

        // FLR interface from HIP
        .flr_rcvd_pf_i                         ( flr_rcvd_pf_i                ) ,
        .flr_rcvd_vf_i                         ( flr_rcvd_vf_i                ) ,
        .flr_rcvd_pf_num_i                     ( flr_rcvd_pf_num_i            ) ,
        .flr_rcvd_vf_num_i                     ( flr_rcvd_vf_num_i            ) ,
        .flr_completed_pf_o                    ( flr_completed_pf_o           ) ,
        .flr_completed_vf_o                    ( flr_completed_vf_o           ) ,
        .flr_completed_pf_num_o                ( flr_completed_pf_num_o       ) ,
        .flr_completed_vf_num_o                ( flr_completed_vf_num_o       ) ,
        // FLR interface to application/user side
        .usr_flr_rcvd_val_o                    ( usr_flr_rcvd_val_o           ) ,
        .usr_flr_rcvd_chan_num_o               ( usr_flr_rcvd_chan_num_o      ) ,
        .usr_flr_completed_i                   ( usr_flr_completed_i          ) ,
        //  Completion Timeout Interface (only in P-tile)
        .cpl_timeout_i                         ( cpl_timeout_i                    ),
        .cpl_timeout_avmm_clk_o                ( cpl_timeout_avmm_clk_o           ),
        .cpl_timeout_avmm_waitrequest_i        ( cpl_timeout_avmm_waitrequest_i   ),
        .cpl_timeout_avmm_read_o               ( cpl_timeout_avmm_read_o          ),
        .cpl_timeout_avmm_address_o            ( cpl_timeout_avmm_address_o       ), // [20:3] : Reserved. Tie them to 0. 
        .cpl_timeout_avmm_write_o              ( cpl_timeout_avmm_write_o         ),
        .cpl_timeout_avmm_writedata_o          ( cpl_timeout_avmm_writedata_o     ),
        .cpl_timeout_avmm_readdata_i           ( cpl_timeout_avmm_readdata_i      ),
        .cpl_timeout_avmm_readdatavalid_i      ( cpl_timeout_avmm_readdatavalid_i ),
        // Error interface to HIP
        .app_err_valid_o                       ( app_err_valid_o              ) ,
        .app_err_hdr_o                         ( app_err_hdr_o                ) ,
        .app_err_info_o                        ( app_err_info_o               ) , //S10:app_err_info[10:0]
        .app_err_func_num_o                    ( app_err_func_num_o           ) , //S10: app_err_func_num[1:0]
        // MSI-X Request interface from application/user side
        .usr_event_msix_valid_i                ( (enable_user_msix_hwtcl) ? usr_event_msix_valid_i  : '0     ) ,
        .usr_event_msix_ready_o                ( usr_event_msix_ready_o       ) ,
        .usr_event_msix_data_i                 ( (enable_user_msix_hwtcl) ? usr_event_msix_data_i   : '0     ) ,
        //BAS
        .bas_vfactive_i                        ( (enable_bursting_slave_hwtcl) ? bas_vfactive_i    : '0 ),
        .bas_pfnum_i                           ( (enable_bursting_slave_hwtcl) ? bas_pfnum_i       : '0 ),              
        .bas_vfnum_i                           ( (enable_bursting_slave_hwtcl) ? bas_vfnum_i       : '0 ),   
        .bas_address_i                         ( (enable_bursting_slave_hwtcl) ? bas_address_i     : '0 ),     
        .bas_byteenable_i                      ( (enable_bursting_slave_hwtcl) ? bas_byteenable_i  : '0 ),            
        .bas_read_i                            ( (enable_bursting_slave_hwtcl) ? bas_read_i        : '0 ),      
        .bas_write_i                           ( (enable_bursting_slave_hwtcl) ? bas_write_i       : '0 ),  
        .bas_writedata_i                       ( (enable_bursting_slave_hwtcl) ? bas_writedata_i   : '0 ),
        .bas_burstcount_i                      ( (enable_bursting_slave_hwtcl) ? bas_burstcount_i  : '0 ),
        .bas_waitrequest_o                     (  bas_waitrequest_o   ),
        .bas_readdata_o                        (  bas_readdata_o      ),
        .bas_readdatavalid_o                   (  bas_readdatavalid_o ),
        .bas_response_o                        (  bas_response_o      ),
    
        // BAM interface
        .bam_readdatavalid_i                   ( (enable_bursting_master_hwtcl) ? bam_readdatavalid_i : '0 ),
        .bam_readdata_i                        ( (enable_bursting_master_hwtcl) ? bam_readdata_i      : '0 ),
        .bam_waitrequest_i                     ( (enable_bursting_master_hwtcl) ? bam_waitrequest_i   : '0 ),
      //.bam_vfactive_o                        ( bam_vfactive_o   ),
      //.bam_pfnum_o                           ( bam_pfnum_o      ),
      //.bam_vfnum_o                           ( bam_vfnum_o      ),
      //.bam_bar_o                             ( bam_bar_o        ),
        .bam_address_o                         ( bam_address_o    ),
        .bam_burstcount_o                      ( bam_burstcount_o ),
        .bam_byteenable_o                      ( bam_byteenable_o ),
        .bam_read_o                            ( bam_read_o       ),
        .bam_write_o                           ( bam_write_o      ),
        .bam_writedata_o                       ( bam_writedata_o  ),

        // CS AVMM slave interface
        .cs_waitrequest_o                      ( cs_waitrequest_o ),
        .cs_address_i                          ( (enable_cs_hwtcl) ? cs_address_i : '0 ),
        .cs_byteenable_i                       ( (enable_cs_hwtcl) ? cs_byteenable_i : '0 ),
        .cs_read_i                             ( (enable_cs_hwtcl) ? cs_read_i : '0 ),
        .cs_readdata_o                         ( cs_readdata_o ),
        .cs_readdatavalid_o                    ( cs_readdatavalid_o ),
        .cs_write_i                            ( (enable_cs_hwtcl) ? cs_write_i : '0 ),
        .cs_writedata_i                        ( (enable_cs_hwtcl) ? cs_writedata_i : '0 ),
        .cs_response_o                         ( cs_response_o ),
        .cs_writeresponsevalid_o               ( cs_writeresponsevalid_o )

      );

   end endgenerate

endmodule

