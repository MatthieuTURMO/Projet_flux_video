----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:12 10/26/2012 
-- Design Name: 
-- Module Name:    synchronizer - synchronier_arch1 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity synchronizer is
	Generic (
		C_XSVI_DWIDTH 	: INTEGER := 24;
		C_FAMILY		: string := "spartan6";
		COUNTER_SIZE	: INTEGER := 11);
		
    Port (
        vid_clk : in  STD_LOGIC;
                
        active_video_in : in  STD_LOGIC;
        hblank_in : in  STD_LOGIC;
        vblank_in : in  STD_LOGIC;
        hsync_in : in  STD_LOGIC;
        vsync_in : in  STD_LOGIC;
        video_data_in : in  STD_LOGIC_VECTOR (0 to C_XSVI_DWIDTH - 1);
              
        active_video_out : out  STD_LOGIC;
        hblank_out : out  STD_LOGIC;
        vblank_out : out  STD_LOGIC;
        hsync_out : out  STD_LOGIC;
        vsync_out : out  STD_LOGIC;
        video_data_out : out  STD_LOGIC_VECTOR (0 to C_XSVI_DWIDTH - 1);
              
        hcount : out  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
        vcount : out  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1));
end synchronizer;

 architecture synchronizer_arch1 of synchronizer is

	-- Définition des différents états :
	-- 00 : état de base : deux compteurs resetés, attente de vblank = 0
	-- 01 : état de reset de hcount, vcount ++ (attention : ne pas faire lors du premier passage)
	-- 10 : état de comptage des colonnes (hcount)
	-- 11 : non utilisé, état interdit
	signal state : std_logic_vector (0 to 1) := "00";
	
	signal hcount_value : std_logic_vector (0 to COUNTER_SIZE - 1);
	signal vcount_value : std_logic_vector (0 to COUNTER_SIZE - 1);
	
	begin
		-- Process de gestion de la machine à états
		synchro_state_mach : process(vid_clk)
		begin
			if(vid_clk'event and vid_clk = '1') then
			
			case state is
				--Etat de base
				when "00" =>
				hcount_value <= (others => '0');
				vcount_value <= (others => '0');
					if(vblank_in = '0') then
						state <= "01";
					end if;
				
				-- Etat de comptage vertical (attente de donnees en colonne)
				when "01" =>
				hcount_value <= (others => '0');
					if(hblank_in = '0') then
						state <= "10";
					end if;
				
				--Etat de comptage horizontal
				when "10" =>
					hcount_value <= hcount_value + 1;
					if(hblank_in = '1') then
						state <= "01";
						vcount_value <= vcount_value + 1;
						hcount_value <= (others => '0');
					end if;
					
					if (vblank_in = '1') then
						state <= "00";
						hcount_value <= (others => '0');
						vcount_value <= (others => '0');
					end if;
					
				when others => state <= "00";
			end case;
			
			end if;
		end process;
		
		active_video_out <= active_video_in;
		hblank_out <= hblank_in;
		vblank_out <= vblank_in;
		hsync_out <= hsync_in;
		vsync_out <= vsync_in;
		video_data_out <= video_data_in;
		
		hcount <= hcount_value;
		vcount <= vcount_value;

end synchronizer_arch1;
