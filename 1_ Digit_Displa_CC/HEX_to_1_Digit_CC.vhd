library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- VHDL code for Hexadecimal to one Digit 7-Segment Common Chatode Display FPGA Driver

entity HEX_to_1_Digit_CC is
    Port (
		HEX_in: in STD_LOGIC_VECTOR (3 downto 0);
		dp_in: in STD_LOGIC; -- DP signal
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Anode segments 
		dp: out STD_LOGIC; -- DP on Piswords PIAX301V2 FPGA board
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board
		);		
end HEX_to_1_Digit_CC;

architecture Behavioral of HEX_to_1_Digit_CC is

begin
	with HEX_in select
					 -- gfedcba - active High	
		Segments <= "0111111" WHEN "0000", --0, active a,b,c,d,e,f segments
						"0000110" WHEN "0001", --1, active b,c segments		
						"1011011" WHEN "0010", --2, active a,b,d,e,g segments
						"1001111" WHEN "0011", --3, active a,b,c,d,g segments
						"1100110" WHEN "0100", --4, active b,c,f,g segments
						"1101101" WHEN "0101", --5, active a,c,d,f,g segments
						"1111101" WHEN "0110", --6, active a,c,d,e,f,g segments  
						"0000111" WHEN "0111", --7, active a,b,c segments
						"1111111" WHEN "1000", --8, active a,b,c,d,e,f,g segments
						"1101111" WHEN "1001", --9, active a,b,c,d,e,g segments
						"1110111" WHEN "1010", --A, active a,b,c,e,f,g segments	
						"1111100" WHEN "1011", --b, active c,d,e,f,g segments	
						"0111001" WHEN "1100", --C, active a,d,e,f segments
						"1011110" WHEN "1101", --d, active b,c,d,e,g segments
						"1111001" WHEN "1110", --E, active a,d,e,f,g segments
						"1110001" WHEN "1111", --F, active a,e,f,g segments	
						"0000000" WHEN OTHERS;	--default blank
		
	SEL7 <= '0';
	dp <= dp_in;

end Behavioral;