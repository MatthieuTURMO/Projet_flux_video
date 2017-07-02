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
-- Design Name:         My XSVI Multiplexer
-- Module Name:         my_xsvi_mux_ip.vhd
-- Project Name:        IVK
-- Target Devices:      Spartan-6
-- Avnet Boards:        IVK
--
-- Tool versions:       ISE 12.2
--
-- Description:         XSVI Multiplexer
--
-- Dependencies:        
--
-- Revision:            Sep 10, 2010: 1.01 Initial version
--
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_xsvi_mux_ip is
	generic (
		C_XSVI_DWIDTH          : INTEGER := 24;
        C_FAMILY               : string  := "spartan6"
	);
	port (
            clk                    : in  std_logic;
            mux_sel                : in  std_logic;

		active_video_in_left   : in  std_logic;
		hblank_in_left         : in  std_logic;
		vblank_in_left         : in  std_logic;
		hsync_in_left          : in  std_logic;
		vsync_in_left          : in  std_logic;
		video_data_in_left     : in  std_logic_vector(0 to C_XSVI_DWIDTH - 1);

		active_video_in_right  : in  std_logic;
		hblank_in_right        : in  std_logic;
		vblank_in_right        : in  std_logic;
		hsync_in_right         : in  std_logic;
		vsync_in_right         : in  std_logic;
		video_data_in_right    : in  std_logic_vector(0 to C_XSVI_DWIDTH - 1);

		active_video_out       : out std_logic;
		hblank_out             : out std_logic;
		vblank_out             : out std_logic;
		hsync_out              : out std_logic;
		vsync_out              : out std_logic;
		video_data_out         : out std_logic_vector(0 to C_XSVI_DWIDTH - 1 )
	);
end entity;

architecture rtl of my_xsvi_mux_ip is
begin

   -- xsvi mux code
   xsvi_mux_l : process(clk)
   begin
      if rising_edge(clk) then
         if (mux_sel = '0') then
            active_video_out <= active_video_in_left;
            vblank_out       <= vblank_in_left;
            hblank_out       <= hblank_in_left;
            vsync_out        <= vsync_in_left;
            hsync_out        <= hsync_in_left;
            video_data_out   <= video_data_in_left;
         else
            active_video_out <= active_video_in_right;
            vblank_out       <= vblank_in_right;
            hblank_out       <= hblank_in_right;
            vsync_out        <= vsync_in_right;
            hsync_out        <= hsync_in_right;
            video_data_out   <= video_data_in_right;
         end if;
      end if;
   end process;

end rtl;
