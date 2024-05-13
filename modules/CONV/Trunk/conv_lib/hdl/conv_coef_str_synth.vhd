----------------------------------------------------------------------------
-- Module Name:  CONV_COEF_STR
--
-- Source Path:  conv_coef_str_synth.vhd
--
-- Description:  Implements a RAM to store the convolution coefficients.
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  JT     18/05/2017  Initial revision.
-- 0.2  RJH    11/06/2020  Changed 'coef_init_s' signal to constant.
--                         Moved loadfile function inside synth off section.
--                         Added retime to micro read data to improve timing.
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2020 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
architecture synth of conv_coef_str is

  type ram_t is array (0 to depth_g-1) of std_logic_vector(dbits_g-1 downto 0);
  type ram_array_t is array (0 to loop_g-1) of ram_t;
  signal rdatastore_s      : ram_array_t;
  signal idatastore_s      : ram_array_t;
  signal rden1_s           : std_logic_vector(loop_g-1 downto 0);
  signal rdaddr_s          : unsigned(abits_g-1 downto 0);
  signal rdconjaddr_s      : unsigned(abits_g-1 downto 0);
  type ramrd_array_t is array (0 to loop_g-1) of std_logic_vector(dbits_g-1 downto 0);
  signal ramrdrdata_s      : ramrd_array_t;
  signal ramrdidata_s      : ramrd_array_t;
  signal ramrdrdataconj_s  : ramrd_array_t;
  signal ramrdidataconj_s  : ramrd_array_t;
  signal mcrdataout_s      : ramrd_array_t;
  signal mcidataout_s      : ramrd_array_t;

  -- RTL_SYNTHESIS OFF
  impure function loadfile (initfilename : in string) return cmplx_array_t is
    file initfile : text;
    variable fileline_v : line;
    variable ram : cmplx_array_t(0 to 1023);
  begin
    file_open(initfile, initfilename, READ_MODE);
    for i in 0 to 1023 loop
      readline(initfile, fileline_v);
      hread(fileline_v, ram(i).RE);
      hread(fileline_v, ram(i).IM);
    end loop;
    return ram;
  end function;

  signal coef_init_c : cmplx_array_t(0 to 1023) := loadfile("template1.txt");
  -- RTL_SYNTHESIS ON

begin

  rdaddr_s <= unsigned(RDADDR);
  rdconjaddr_s <= unsigned(not RDADDR) + 1;

  -- READ SIDE

  --------------------------------------------------------------------------
  -- retime read
  -- retime read enable for output enable
  --------------------------------------------------------------------------
  rtread : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      rden1_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then

      rden1_s <= RDEN;

    end if;
  end process rtread;

  --------------------------------------------------------------------------
  -- read data
  --------------------------------------------------------------------------
  readdata : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      RDATAOUT <= (others => '0');
      IDATAOUT <= (others => '0');
      RDATACONJOUT <= (others => '0');
      IDATACONJOUT <= (others => '0');
    elsif rising_edge(CLK_SYS) then

      RDATAOUT <= (others => '0');
      IDATAOUT <= (others => '0');
      RDATACONJOUT <= (others => '0');
      IDATACONJOUT <= (others => '0');
      -- check if new read data
      for i in 0 to loop_g-1 loop
        if rden1_s(i)='1' then
          RDATAOUT <= ramrdrdata_s(i);
          IDATAOUT <= ramrdidata_s(i);
          RDATACONJOUT <= ramrdrdataconj_s(i);
          IDATACONJOUT <= not ramrdidataconj_s(i)(31) & ramrdidataconj_s(i)(30 downto 0);
        end if;
      end loop;
    end if;
  end process readdata;

  ramgen: for i in 0 to loop_g-1 generate

    --------------------------------------------------------------------------
    -- RAM read (infer ram with non-registered outputs)
    --------------------------------------------------------------------------
    rdstore  : process (CLK_SYS)
    begin
      if rising_edge(CLK_SYS) then

        if RDEN(i)='1' then
          ramrdrdata_s(i) <= rdatastore_s(i)(to_integer(rdaddr_s));
          ramrdidata_s(i) <= idatastore_s(i)(to_integer(rdaddr_s));
          ramrdrdataconj_s(i) <= rdatastore_s(i)(to_integer(rdconjaddr_s));
          ramrdidataconj_s(i) <= idatastore_s(i)(to_integer(rdconjaddr_s));
        end if;

      end if;
    end process rdstore;


    --------------------------------------------------------------------------
    -- MCI write store
    --------------------------------------------------------------------------
    mcwrstore : process (CLK_MC,RST_MC_N)
    begin
      if rising_edge(CLK_MC) then

        if MCWREN(i)='1' then
          if MCADDR(0)='0' then
            rdatastore_s(i)(to_integer(unsigned(MCADDR(abits_g downto 1)))) <= MCDATA;
          else
            idatastore_s(i)(to_integer(unsigned(MCADDR(abits_g downto 1)))) <= MCDATA;
          end if;
        end if;

      end if;

      -- RTL_SYNTHESIS OFF
      if RST_MC_N='0' then
        for j in 0 to 1023 loop
          rdatastore_s(i)(j) <= coef_init_c(j).RE;
          idatastore_s(i)(j) <= coef_init_c(j).IM;
        end loop;
      end if;
      -- RTL_SYNTHESIS ON

    end process mcwrstore;

    --------------------------------------------------------------------------
    -- MCI read store
    --------------------------------------------------------------------------
    mcrdstore : process (CLK_MC)
    begin
      if rising_edge(CLK_MC) then

        if MCRDEN(i)='1' then
          mcrdataout_s(i) <= rdatastore_s(i)(to_integer(unsigned(MCADDR(abits_g downto 1))));
          mcidataout_s(i) <= idatastore_s(i)(to_integer(unsigned(MCADDR(abits_g downto 1))));
        end if;
      end if;
    end process mcrdstore;


  end generate;

  readmcdata : process (CLK_MC)
  begin
    if rising_edge(CLK_MC) then
      MCDATAOUT <= (others => '0');
      for i in 0 to loop_g-1 loop
        if MCRDEN(i)='1' then
          if MCADDR(0)='0' then
            MCDATAOUT <= mcrdataout_s(i);
          else
            MCDATAOUT <= mcidataout_s(i);
          end if;
        end if;
      end loop;
    end if;
  end process readmcdata;


end synth;
