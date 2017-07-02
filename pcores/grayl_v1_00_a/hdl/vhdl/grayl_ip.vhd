
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity grayl_ip is
	generic (
		C_XSVI_DWIDTH      : INTEGER := 24;
        C_FAMILY           : string  := "spartan6";
		COUNTER_SIZE	: INTEGER := 11
	);
	port (
        clk                    : in  std_logic;
        gray_sel               : in  std_logic_vector(1 downto 0);

		active_video_out  : out  std_logic;
		hblank_out        : out  std_logic;
		vblank_out        : out  std_logic;
		hsync_out         : out  std_logic;
		vsync_out         : out  std_logic;
		video_data_out    : out  std_logic_vector(0 to C_XSVI_DWIDTH - 1);		
		
		active_video_in  : in std_logic;
		hblank_in         : in std_logic;
		vblank_in         : in std_logic;
		hsync_in         : in std_logic;
		vsync_in          : in std_logic;
		video_data_in     : in std_logic_vector(0 to C_XSVI_DWIDTH - 1 );
		
		hcount_in : in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1);
      vcount_in : in  STD_LOGIC_VECTOR (0 to COUNTER_SIZE - 1)
		
	);
end entity;

architecture grayl_arch_ip of grayl_ip is

--constant gray_sel: std_logic_vector(1 downto 0) := "11";

begin

   -- xsvi mux code
   grayl : process(clk)
   begin
	if(rising_edge(clk)) then
		if(gray_sel="00") then --cas couleur sans chiffre
			video_data_out <= video_data_in;
			
		elsif(gray_sel="01") then --cas couleur avec chiffre
				--				30							222						30							62
			if(hcount_in >= "00000011110" AND hcount_in <= "00011011110" AND vcount_in >="00000011110" and vcount_in <= "00000111110") then --premiere barre horizontale
				video_data_out <= "111111110000000000000000";
				--				30						62							30							254
			elsif(hcount_in >= "00000011110" AND hcount_in <= "00000111110" AND vcount_in >="00000011110" and vcount_in <= "00011111110") then --grande barre verticale
				video_data_out <= "111111110000000000000000";
				--			62								222						126							158						
			elsif(hcount_in >= "00000111110" AND hcount_in <= "00011011110" AND vcount_in >="00001111110" and vcount_in <= "0001001110") then --deuxieme horizontale
				video_data_out <= "111111110000000000000000";			
				--				62							222							222							254
			elsif(hcount_in >= "00000111110" AND hcount_in <= "00011011110" AND vcount_in >="00011011110" and vcount_in <= "00011111110") then --troisieme horizontale
				video_data_out <= "111111110000000000000000";
				--				190							222							158							222
			elsif(hcount_in >= "00010111110" AND hcount_in <= "00011011110" AND vcount_in >="0001001110" and vcount_in <= "00011011110") then --troisieme horizontale
				video_data_out <= "111111110000000000000000";				
			else				
				video_data_out <= video_data_in;
			end if;
			
			
		elsif(gray_sel="10") then --cas gris sans chiffre
			video_data_out(0 to 7) <= video_data_in (0 to 7);
			video_data_out(8 to 15) <= video_data_in (0 to 7);
			video_data_out(16 to 23) <= video_data_in (0 to 7);
			
		else		--cas gris avec chiffre
			--				30							222						30							62
			if(hcount_in >= "00000011110" AND hcount_in <= "00011011110" AND vcount_in >="00000011110" and vcount_in <= "00000111110") then --premiere barre horizontale
				video_data_out <= "111111110000000000000000";
				--				30						62							30							254
			elsif(hcount_in >= "00000011110" AND hcount_in <= "00000111110" AND vcount_in >="00000011110" and vcount_in <= "00011111110") then --grande barre verticale
				video_data_out <= "111111110000000000000000";
				--			62								222						126							158						
			elsif(hcount_in >= "00000111110" AND hcount_in <= "00011011110" AND vcount_in >="00001111110" and vcount_in <= "0001001110") then --deuxieme horizontale
				video_data_out <= "111111110000000000000000";			
				--				62							222							222							254
			elsif(hcount_in >= "00000111110" AND hcount_in <= "00011011110" AND vcount_in >="00011011110" and vcount_in <= "00011111110") then --troisieme horizontale
				video_data_out <= "111111110000000000000000";
				--				190							222							158							222
			elsif(hcount_in >= "00010111110" AND hcount_in <= "00011011110" AND vcount_in >="0001001110" and vcount_in <= "00011011110") then --troisieme horizontale
				video_data_out <= "111111110000000000000000";				
			else				
				video_data_out(0 to 7) <= video_data_in (0 to 7);
				video_data_out(8 to 15) <= video_data_in (0 to 7);
				video_data_out(16 to 23) <= video_data_in (0 to 7);
			end if;
		end if;		
			hblank_out <= hblank_in;
			vblank_out <= vblank_in;
			hsync_out <= hsync_in;
			vsync_out <= vsync_in;
			active_video_out <= active_video_in;		
	end if;   
   end process;
end grayl_arch_ip;
