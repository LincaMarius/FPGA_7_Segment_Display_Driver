library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- VHDL code for ASCII to one Digit 7-Segment Common Anode Display FPGA Driver
-- I replaced the special characters in the ASCII set 
--with binary to hexadecimal decoding of the codes between 0x00 and 0x0F

entity ASCII_to_1_Digit_CA is
    Port (
		ASCII_in: in STD_LOGIC_VECTOR (6 downto 0);
		dp_in: in STD_LOGIC; -- DP signal
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments 
		dp: out STD_LOGIC; -- DP on Piswords PIAX301V2 FPGA board
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board
		);		
end ASCII_to_1_Digit_CA;

architecture Behavioral of ASCII_to_1_Digit_CA is

begin
	with ASCII_in select
					 -- gfedcba - active low	
		Segments <= "1000000" WHEN "0000000", --x"00", -- 0, active a,b,c,d,e,f segments
						"1111001" WHEN "0000001", --x"01", -- 1, active b,c segments
						"0100100" WHEN "0000010", --x"02", -- 2, active a,b,d,e,g segments
						"0110000" WHEN "0000011", --x"03", -- 3, active a,b,c,d,g segments
						"0011001" WHEN "0000100", --x"04", -- 4, active b,c,f,g segments
						"0010010" WHEN "0000101", --x"05", -- 5, active a,c,d,f,g segments
						"0000010" WHEN "0000110", --x"06", -- 6, active a,c,d,e,f,g segments  
						"1011000" WHEN "0000111", --x"07", -- 7, active a,b,c,f segments
						"0000000" WHEN "0001000", --x"08", -- 8, active a,b,c,d,e,f,g segments
						"0010000" WHEN "0001001", --x"09", -- 9, active a,b,c,d,f,g segments
						"0001000" WHEN "0001010", --x"0A", -- A, active a,b,c,e,f,g segments	
						"0000011" WHEN "0001011", --x"0B", -- b, active c,d,e,f,g segments	
						"1000110" WHEN "0001100", --x"0C", -- C, active a,d,e,f segments
						"0100001" WHEN "0001101", --x"0D", -- d, active b,c,d,e,g segments
						"0000110" WHEN "0001110", --x"0E", -- E, active a,d,e,f,g segments
						"0001110" WHEN "0001111", --x"0F", -- F, active a,e,f,g segments	
				      "1111111" when "0100000", --x"20", -- Space, blank
				      "1111001" when "0100001", --x"21", -- !, active b,c segments
				      "1011101" when "0100010", --x"22", -- ", active b,f segments
				      "1011111" when "0100111", --x"27", -- ', active f segment
				      "1010110" when "0101000", --x"28", -- (, active a,d,f segments
				      "1110100" when "0101001", --x"29", -- ), active a,b,d segments
				      "1011110" when "0101010", --x"2A", -- *, active a,f segments
				      "0001111" when "0101011", --x"2B", -- +, active e,f,g segments
				      "1101111" when "0101100", --x"2C", -- ,, active e segment
				      "0111111" when "0101101", --x"2D", -- -, active g segment
				      "0101101" when "0101111", --x"2F", -- /, active b,e,g segment
				      "1000000" when "0110000", --x"30", -- 0, active a,b,c,d,e,f segments
					   "1111001" when "0110001", --x"31", -- 1, active b,c segments
					   "0100100" when "0110010", --x"32", -- 2, active a,b,d,e,g segments
					   "0110000" when "0110011", --x"33", -- 3, active a,b,c,d,g segments
					   "0011001" when "0110100", --x"34", -- 4, active b,c,f,g segments
					   "0010010" when "0110101", --x"35", -- 5, active a,c,d,f,g segments
					   "0000010" when "0110110", --x"36", -- 6, active a,c,d,e,f,g segments  
					   "1011000" when "0110111", --x"37", -- 7, active a,b,c,f segments
					   "0000000" when "0111000", --x"38", -- 8, active a,b,c,d,e,f,g segments
					   "0010000" when "0111001", --x"39", -- 9, active a,b,c,d,f,g segments
						"1100111" when "0111100", --x"3C", -- <, active d,e segments
					   "0110111" when "0111101", --x"3D", -- =, active d,g segments
					   "1110011" when "0111110", --x"3E", -- >, active c,d segments
						"0101100" when "0111111", --x"3F", -- ?, active a,b,e,g segments
					   "0100000" when "1000000", --x"40", -- @, active a,b,c,d,e,g segments
					   "0001000" when "1000001", --x"41", -- A, active a,b,c,e,f,g segments
					   "0000011" when "1000010", --x"42", -- b, active c,d,e,f,g segments
					   "1000110" when "1000011", --x"43", -- C, active a,d,e,f segments
					   "0100001" when "1000100", --x"44", -- d, active b,c,d,e,g segments
					   "0000110" when "1000101", --x"45", -- E, active a,d,e,f,g segments
						"0001110" when "1000110", --x"46", -- F, active a,e,f,g segments
						"1000010" when "1000111", --x"47", -- G, active a,c,d,e,f segments 
						"0001001" when "1001000", --x"48", -- H, active b,c,e,f,g segments
						"1001111" when "1001001", --x"49", -- I, active e,f segments
						"1100001" when "1001010", --x"4A", -- J, active b,c,d,e segments
						"0001010" when "1001011", --x"4B", -- K, active a,c,e,f,g segments
						"1000111" when "1001100", --x"4C", -- L, active d,e,f segments
						"1101010" when "1001101", --x"4D", -- m, active a,c,e segments
						"1001000" when "1001110", --x"4E", -- N, active a,b,c,e,f segments
						"0100011" when "1001111", --x"4F", -- o, active c,d,e,g segments
						"0001100" when "1010000", --x"50", -- P, active a,b,e,f,g segments
						"0011000" when "1010001", --x"51", -- q, active a,b,c,f,g segments	
						"1001100" when "1010010", --x"52", -- R, active a,b,e,f segments
						"0010010" when "1010011", --x"53", -- S, active a,c,d,f,g segments
						"0000111" when "1010100", --x"54", -- t, active d,e,f,g segments
						"1000001" when "1010101", --x"55", -- U, active b,c,d,e,f segments
						"1000101" when "1010110", --x"56", -- V, active b,d,e,f segments
						"1010101" when "1010111", --x"57", -- W, active b,d,f segments
						"0010001" when "1011001", --x"59", -- Y, active b,c,d,f,g segments
						"0011011" when "1011100", --x"5C", -- \, active c,f,g segments
						"1011100" when "1011110", --x"5E", -- ^, active a,b,f segments
						"1110111" when "1011111", --x"5F", -- _, active d segment
						"1111101" when "1100000", --x"60", -- `, active b segment
						"0100000" when "1100001", --x"61", -- a, active a,b,c,d,e,g segments
						"0000011" when "1100010", --x"62", -- b, active c,d,e,f,g segments	
						"0100111" when "1100011", --x"63", -- c, active d,e,g segments
						"0100001" when "1100100", --x"64", -- d, active b,c,d,e,g segments
						"0000100" when "1100101", --x"65", -- e, active a,b,d,e,f,g segments	
						"0001110" when "1100110", --x"66", -- F, active a,e,f,g segments
						"1000010" when "1100111", --x"67", -- G, active a,c,d,e,f segments	
						"0001011" when "1101000", --x"68", -- h, active c,e,f,g segments	
						"1001111" when "1101001", --x"69", -- I, active e,f segments		
						"1100001" when "1101010", --x"6A", -- J, active b,c,d,e segments
						"0001010" when "1101011", --x"6B", -- K, active a,c,e,f,g segments
						"1000111" when "1101100", --x"6C", -- L, active d,e,f segments
						"1101011" when "1101101", --x"6D", -- m, active c,e segments
						"0101011" when "1101110", --x"6E", -- n, active c,e,g segments
						"0100011" when "1101111", --x"6F", -- o, active c,d,e,g segments		
						"0001100" when "1110000", --x"70", -- P, active a,b,e,f,g segments	
						"0011000" when "1110001", --x"71", -- q, active a,b,c,f,g segments		
						"0101111" when "1110010", --x"72", -- r, active e,g segments	
						"0010010" when "1110011", --x"73", -- S, active a,c,d,f,g segments		
						"0000111" when "1110100", --x"74", -- t, active d,e,f,g segments	
						"1100011" when "1110101", --x"75", -- u, active c,d,e segments
						"0010001" when "1111001", --x"79", -- Y, active b,c,d,f,g segments
						"1111110" when "1111110", --x"7E", -- ~, active a segment				
						"1111111" WHEN OTHERS;	--default blank
						
	SEL7 <= '0';
	dp <= dp_in;

end Behavioral;