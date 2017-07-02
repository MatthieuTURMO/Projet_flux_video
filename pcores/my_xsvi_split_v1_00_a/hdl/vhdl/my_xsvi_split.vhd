------------------------------------------------------------------
--      _____
--     /     \
--    /____   \____
--   / \===\   \==/
--  /___\===\___\/  AVNET
--       \======/
--        \====/    
-----------------------------------------------------------------
--
-- This design is the property of Avnet.  Publication of this
-- design is not authorized without written consent from Avnet.
-- 
-- Please direct any questions to:  technical.support@avnet.com
--
-- Disclaimer:
--    Avnet, Inc. makes no warranty for the use of this code or design.
--    This code is provided  "As Is". Avnet, Inc assumes no responsibility for
--    any errors, which may appear in this code, nor does it make a commitment
--    to update the information contained herein. Avnet, Inc specifically
--    disclaims any implied warranties of fitness for a particular purpose.
--                     Copyright(c) 2010 Avnet, Inc.
--                             All rights reserved.
--
------------------------------------------------------------------
--
-- Create Date:         Sep 10, 2010
-- Design Name:         My XSVI Splitter
-- Module Name:         my_xsvi_split.vhd
-- Project Name:        IVK
-- Target Devices:      Spartan-6
-- Avnet Boards:        IVK
--
-- Tool versions:       ISE 12.2
--
-- Description:         XSVI Splitter
--
-- Dependencies:        
--
-- Revision:            Sep 10, 2010: 1.01 Initial version
--
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_xsvi_split is
  generic (
    C_XSVI_DWIDTH          : INTEGER := 8;
    C_FAMILY               : string  := "spartan6";
	COUNTER_SIZE	: INTEGER := 11
  );
  port (
    clk                    : in  std_logic;
	
	hcount_in : in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
    vcount_in : in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
	
	hcount_out : out  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
    vcount_out : out  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
	

    active_video_in        : in  std_logic;
    hblank_in              : in  std_logic;
    vblank_in              : in  std_logic;
    hsync_in               : in  std_logic;
    vsync_in               : in  std_logic;
    video_data_in          : in  std_logic_vector(0 to C_XSVI_DWIDTH - 1);

    active_video_out_left  : out std_logic;
    hblank_out_left        : out std_logic;
    vblank_out_left        : out std_logic;
    hsync_out_left         : out std_logic;
    vsync_out_left         : out std_logic;
    video_data_out_left    : out std_logic_vector(0 to C_XSVI_DWIDTH - 1 );

    active_video_out_right : out std_logic;
    hblank_out_right       : out std_logic;
    vblank_out_right       : out std_logic;
    hsync_out_right        : out std_logic;
    vsync_out_right        : out std_logic;
    video_data_out_right   : out std_logic_vector(0 to C_XSVI_DWIDTH - 1)
  );
end entity;

architecture rtl of my_xsvi_split is
begin

  -- xsvi split code
  xsvi_split_l : process ( clk )
  begin
    if rising_edge(clk) then
      active_video_out_left  <= active_video_in;
      hblank_out_left        <= hblank_in;
      vblank_out_left        <= vblank_in;
      hsync_out_left         <= hsync_in;
      vsync_out_left         <= vsync_in;
      video_data_out_left    <= video_data_in;


      active_video_out_right <= active_video_in;
      hblank_out_right       <= hblank_in;
      vblank_out_right       <= vblank_in;
      hsync_out_right        <= hsync_in;
      vsync_out_right        <= vsync_in;
      video_data_out_right   <= video_data_in;
	  hcount_out<= hcount_in;
	  vcount_out <= vcount_in;
    end if;
  end process;

end rtl;
