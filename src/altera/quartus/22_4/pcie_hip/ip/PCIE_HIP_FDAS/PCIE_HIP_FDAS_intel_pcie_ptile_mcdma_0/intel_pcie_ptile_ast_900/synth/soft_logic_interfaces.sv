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


// interface declaration:
// ---------------------------------------------------------------------------------
// |	avst																																					|
// |		-------------------				-------------------------------------------				|
// |		|	soft_glue 			|				|	wrapper							------------------	|				|
// |		|									|				|											|	atom    				|	|				|
// |		|									|				|											|									|	|				|
// |		|	a							p	|				|	h										|									|	|				|
// |		|	p							l	|				|	i										|									|	|				|
// |		|	p							d	|				|	p										|									|	|				|
// |		|									|				|											|									|	|				|
// |		|									|				|											|									|	|				|
// |		|									|				|											|									|	|				|
// |		|									|				|											|									|	|				|
// |		|									|				|											|									|	|				|
// |		|									|				|											------------------	|				|
// |		-------------------				-------------------------------------------				|
// ---------------------------------------------------------------------------------




interface aib_ch_interface;
logic                                                  pld_adapter_tx_pld_rst_n;
logic                                                  pld_tx_dll_lock_req;
logic                                                  pld_fabric_tx_transfer_en;
logic                                                  pld_adapter_rx_pld_rst_n;
logic                                                  pld_rx_dll_lock_req;
logic                                                  pld_hssi_rx_transfer_en;
logic 												   											 pld_hssi_osc_transfer_en;
logic 																								 pld_rx_fabric_fifo_align_clr;
//tie pld_rx_fabric_fifo_align_clr to 0;
//assign 	pld_rx_fabric_fifo_align_clr = 0;

  modport  pld_aib_ch_rst_port(
  	input  																									pld_hssi_osc_transfer_en,
    output                                                  pld_adapter_tx_pld_rst_n,
    output                                                  pld_tx_dll_lock_req,
    input                                                   pld_fabric_tx_transfer_en,
    output                                                  pld_adapter_rx_pld_rst_n,
    output                                                  pld_rx_dll_lock_req,
    input                                                   pld_hssi_rx_transfer_en
  );
  modport hip_aib_ch_rst_port (
  	output 												   												pld_hssi_osc_transfer_en,
    input                                                  pld_adapter_tx_pld_rst_n,
    input                                                  pld_tx_dll_lock_req,
    output                                                 pld_fabric_tx_transfer_en,
    input                                                  pld_adapter_rx_pld_rst_n,
    input                                                  pld_rx_dll_lock_req,
    output                                                 pld_hssi_rx_transfer_en,
    input 																								 pld_rx_fabric_fifo_align_clr
  );

endinterface

interface pcie_core_rst_interface (input coreclkout_hip);
logic			  pld_core_rst_n;
logic       user_mode_to_pld;
logic       pld_in_use;
logic       pld_ready;

logic       hip_pld_link_req_rst;
logic       hip_pld_warm_rst_rdy;

logic       pld_link_req_rst_n;
logic       pld_warm_rst_rdy;

logic 			app_pld_link_req_rst_n;
logic 			app_pld_warm_rst_rdy;

//assign 		hip_pld_warm_rst_rdy		=		pld_warm_rst_rdy ;
//assign 		app_pld_link_req_rst_n 	=		pld_link_req_rst_n;
//assign 		pld_link_req_rst_n 	=		~hip_pld_link_req_rst;

	modport pld_pcie_core_rst_port(
	input			  pld_core_rst_n,
	input       user_mode_to_pld,
	input       pld_in_use,
	input       pld_link_req_rst_n,
	output      pld_warm_rst_rdy,
	output      pld_ready
	);
	modport hip_pcie_core_rst_port(
	output			pld_core_rst_n,
	output      user_mode_to_pld,
	output      pld_in_use,
	output      hip_pld_link_req_rst,
	input       hip_pld_warm_rst_rdy,
	input       pld_ready
	);
	//APP 	
	modport app_pcie_core_rst_port(
	output      app_pld_link_req_rst_n,
	input       app_pld_warm_rst_rdy
	);	
endinterface	

interface user_avmm_interface;

logic 			  											user_avmm_writedone;
logic               								user_avmm_read;
logic    [20:0]     								user_avmm_address;
logic               								user_avmm_write;
logic    [7:0]      								user_avmm_writedata;
logic               								user_avmm_clk;
logic              									user_avmm_readdatavalid;
logic    [7:0]     									user_avmm_readdata;
logic 	 [4:0]											phyq_sel;
logic              									app_user_avmm_waitrequest;
logic               								app_user_avmm_read;
logic    [20:0]     								app_user_avmm_address;
logic               								app_user_avmm_write;
logic    [7:0]      								app_user_avmm_writedata;
logic               								app_user_avmm_clk;
logic              									app_user_avmm_readdatavalid;
logic    [7:0]     									app_user_avmm_readdata;
logic 	 [4:0] 											app_phyq_sel;

	modport  app_user_avmm_ports(
		output              									app_user_avmm_waitrequest,
		input               									app_user_avmm_read,
		input			           									app_user_avmm_address,
		input               									app_user_avmm_write,
		input               									app_user_avmm_writedata,
		input               									app_user_avmm_clk,
		output              									app_user_avmm_readdatavalid,
		output              									app_user_avmm_readdata,
		input 																app_phyq_sel
		);
	modport  hip_user_avmm_ports(
		output              									user_avmm_writedone,
		input               									user_avmm_read,
		input               									user_avmm_address,
		input               									user_avmm_write,
		input               									user_avmm_writedata,
		input               									user_avmm_clk,
		output              									user_avmm_readdatavalid,
		output              									user_avmm_readdata,
		input 																phyq_sel
		);
	modport  pld_user_avmm_ports(
		output			    											user_avmm_clk,
		output			    											user_avmm_read,
		output               									user_avmm_address,
		output			    											user_avmm_write,
		output               									user_avmm_writedata,
		input			    												user_avmm_readdatavalid,
		input              										user_avmm_readdata,
		input 			    											user_avmm_writedone,
	  output 																phyq_sel
	);

endinterface : user_avmm_interface

interface completion_to_interface;
logic 															cpl_timeout;
logic 			  											cpl_timeout_avmm_writedone;
logic              									cpl_timeout_avmm_waitrequest;
logic               								cpl_timeout_avmm_read;
logic    [20:0]     								cpl_timeout_avmm_address;
logic               								cpl_timeout_avmm_write;
logic    [7:0]      								cpl_timeout_avmm_writedata;
logic               								cpl_timeout_avmm_clk;
logic              									cpl_timeout_avmm_readdatavalid;
logic    [7:0]     									cpl_timeout_avmm_readdata;
logic 															cpl_timeout_tagvalid;
logic 	[1:0]											  cpl_timeout_tag;
logic 															cpl_timeout_overflow;

	modport  app_completion_to_ports(
		output 													cpl_timeout_tagvalid,
		output 	     										cpl_timeout_tag,
		output 													cpl_timeout_overflow
		);
	modport  hip_completion_to_avmm_ports(
		output 																cpl_timeout,
		output              									cpl_timeout_avmm_writedone,
		input               									cpl_timeout_avmm_read,
		input               									cpl_timeout_avmm_address,
		input               									cpl_timeout_avmm_write,
		input               									cpl_timeout_avmm_writedata,
		input               									cpl_timeout_avmm_clk,
		output              									cpl_timeout_avmm_readdatavalid,
		output              									cpl_timeout_avmm_readdata
		);
	modport  pld_completion_to_avmm_ports(
		input 																cpl_timeout,
		output			    											cpl_timeout_avmm_clk,
		output			    											cpl_timeout_avmm_read,
		output               									cpl_timeout_avmm_address,
		output			    											cpl_timeout_avmm_write,
		output               									cpl_timeout_avmm_writedata,
		input			    												cpl_timeout_avmm_readdatavalid,
		input              										cpl_timeout_avmm_readdata,
		input 			    											cpl_timeout_avmm_writedone
	);

endinterface : completion_to_interface
