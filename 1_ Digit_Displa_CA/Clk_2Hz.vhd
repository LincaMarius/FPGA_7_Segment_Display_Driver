library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- frequency divider from 50 MHz to 2 Hz
entity Clk_2Hz is
	Port 
	( 
		clk_in 	: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		clk_out 	: OUT	STD_LOGIC
	);
end Clk_2Hz;

architecture Behavioral of Clk_2Hz is

signal clk : STD_LOGIC := '0'; 

begin
process (clk_in,rst_n)
	variable count : integer RANGE 0 to 25000000 := 0;
	begin
		if(rst_n = '0') then
			count := 0;
			clk <= '0';
		elsif (rising_edge(clk_in)) then
			count := count + 1;				
			if (count = 25000000) then	   			
				count := 0;						
				clk <= not clk;		
			end if;
		end if;
		clk_out <= clk;	
	end process;

end Behavioral;