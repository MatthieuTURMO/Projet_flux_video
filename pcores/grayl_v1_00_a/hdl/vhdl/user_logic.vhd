------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Mon Nov 28 14:26:27 2016 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--   C_NUM_REG                    -- Number of software accessible registers
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
	C_XSVI_DWIDTH : integer := 24;
	COUNTER_SIZE : integer := 11;
	C_FAMILY : string := "spartan6";
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_SLV_DWIDTH                   : integer              := 32;
    C_NUM_REG                      : integer              := 1
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    --USER ports added here
	clk : in std_logic;

	-- XSVI_IN ports
	active_video_in : in std_logic;
	hblank_in : in std_logic;
	vblank_in : in std_logic;
	hsync_in : in std_logic;
	vsync_in : in std_logic;
	video_data_in : in std_logic_vector(0 to C_XSVI_DWIDTH - 1);
	hcount_in: in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
    vcount_in : in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
	
	-- XSVI_OUT ports
	active_video_out : out std_logic;
	hblank_out : out std_logic;
	vblank_out : out std_logic;
	hsync_out : out std_logic;
	vsync_out : out std_logic;
	video_data_out : out std_logic_vector(0 to C_XSVI_DWIDTH - 1 );
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(0 to C_SLV_DWIDTH-1);
    Bus2IP_BE                      : in  std_logic_vector(0 to C_SLV_DWIDTH/8-1);
    Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    IP2Bus_Data                    : out std_logic_vector(0 to C_SLV_DWIDTH-1);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Reset  : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic
  -- multiplexer select
	signal gray_sel_d1 : std_logic;
	signal gray_sel_d2 : std_logic;
	signal gray_sel_d3 : std_logic;
	signal gray_sel_d4 : std_logic;
	signal gray_sel : std_logic_vector(1 downto 0) := "11";
  -- multiplexer module
	component grayl_ip is
	generic (
		C_XSVI_DWIDTH : INTEGER := 24;
		COUNTER_SIZE : INTEGER := 11;
		C_FAMILY : string := "spartan6"
		
	);
	port (
		clk : in std_logic;
		gray_sel : in  std_logic_vector(1 downto 0);
		-- XSVI_IN ports
		active_video_in : in std_logic;
		hblank_in : in std_logic;
		vblank_in : in std_logic;
		hsync_in : in std_logic;
		vsync_in : in std_logic;
		video_data_in : in std_logic_vector(0 to C_XSVI_DWIDTH - 1);
		hcount_in : in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
		vcount_in : in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
		
		-- XSVI_OUT ports
		active_video_out : out std_logic;
		hblank_out : out std_logic;
		vblank_out : out std_logic;
		hsync_out : out std_logic;
		vsync_out : out std_logic;
		video_data_out : out std_logic_vector(0 to C_XSVI_DWIDTH - 1 )
	);
	end component;

  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg0                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg_write_sel              : std_logic_vector(0 to 0);
  signal slv_reg_read_sel               : std_logic_vector(0 to 0);
  signal slv_ip2bus_data                : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_read_ack                   : std_logic;
  signal slv_write_ack                  : std_logic;

begin

  --USER logic implementation added here
  -- multiplexer select
	-- slv_reg0 is big endian, which means slv_reg0(31) is the least		significant bit
	-- grayl_sel is synchronized to video clock
	gray_sel_l : process (clk)
	begin
		if rising_edge(clk) then
			gray_sel_d1 <= slv_reg0(31);
			gray_sel_d2 <= gray_sel_d1;
			gray_sel(0) <= gray_sel_d2;
			gray_sel_d3 <= slv_reg0(30);
			gray_sel_d4 <= gray_sel_d3;
			gray_sel(1) <= gray_sel_d4;
		end if;
	end process;
	-- multiplexer module
	grayl_l : grayl_ip
	generic map (
		C_XSVI_DWIDTH => C_XSVI_DWIDTH,
		COUNTER_SIZE => COUNTER_SIZE,
		C_FAMILY => C_FAMILY
	)
	port map (
		clk => clk,
		-- ici cetait grayl_sel ma gueule
		gray_sel(0) => gray_sel_d2,
		gray_sel(1) => gray_sel_d4,
		
		-- XSVI_IN ports
		active_video_in => active_video_in,
		hblank_in => hblank_in,
		vblank_in => vblank_in,
		hsync_in => hsync_in,
		vsync_in => vsync_in,
		video_data_in => video_data_in,
		hcount_in => hcount_in,
		vcount_in => vcount_in,
		
		-- XSVI_OUT ports
		active_video_out => active_video_out,
		hblank_out => hblank_out,
		vblank_out => vblank_out,
		hsync_out => hsync_out,
		vsync_out => vsync_out,
		video_data_out => video_data_out
	);

  ------------------------------------------
  -- Example code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(0 to 0);
  slv_reg_read_sel  <= Bus2IP_RdCE(0 to 0);
  slv_write_ack     <= Bus2IP_WrCE(0);
  slv_read_ack      <= Bus2IP_RdCE(0);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Reset = '1' then
        slv_reg0 <= (others => '0');
      else
        case slv_reg_write_sel is
          when "1" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg0(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when others => null;
        end case;
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read grayl
  SLAVE_REG_READ_PROC : process( slv_reg_read_sel, slv_reg0 ) is
  begin

    case slv_reg_read_sel is
      when "1" => slv_ip2bus_data <= slv_reg0;
      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data  <= slv_ip2bus_data when slv_read_ack = '1' else
                  (others => '0');

  IP2Bus_WrAck <= slv_write_ack;
  IP2Bus_RdAck <= slv_read_ack;
  IP2Bus_Error <= '0';

end IMP;
