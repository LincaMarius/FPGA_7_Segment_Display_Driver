library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- VHDL code for BCD to one Digit 7-Segment Common Anode Display FPGA Driver

entity BCD_to_1_Digit_CA is
    Port (
		BCD_in: in STD_LOGIC_VECTOR (3 downto 0);
		bp_in: in STD_LOGIC; 	-- BP signal
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments 
		bp: out STD_LOGIC;	-- BP on Piswords PIAX301V2 FPGA board
		SEL7:	out STD_LOGIC	-- SEL7 on Piswords PIAX301V2 FPGA board
		);		
end BCD_to_1_Digit_CA;

architecture Behavioral of BCD_to_1_Digit_CA is

begin
	with BCD_in select
					 -- gfedcba - active low	
		Segments <= "1000000" WHEN "0000", --0, active a,b,c,d,e,f segments
						"1111001" WHEN "0001", --1, active b,c segments
						"0100100" WHEN "0010", --2, active a,b,d,e,g segments
						"0110000" WHEN "0011", --3, active a,b,c,d,g segments
						"0011001" WHEN "0100", --4, active b,c,f,g segments
						"0010010" WHEN "0101", --5, active a,c,d,f,g segments
						"0000010" WHEN "0110", --6, active a,c,d,e,f,g segments  
						"1111000" WHEN "0111", --7, active a,b,c segments
						"0000000" WHEN "1000", --8, active a,b,c,d,e,f,g segments
						"0010000" WHEN "1001", --9, active a,b,c,d,e,g segments
						"1111111" WHEN OTHERS;	--default blank
						
	SEL7 <= '0';
	bp <= bp_in;

end Behavioral;