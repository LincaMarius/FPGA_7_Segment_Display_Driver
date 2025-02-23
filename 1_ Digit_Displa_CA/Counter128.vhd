library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- binary counter - counts from 0 to 128
entity Counter128 is
	Port 
	( 
		clk 		: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		count 	: OUT	STD_LOGIC_VECTOR (6 downto 0)
	);
end Counter128;

architecture Behavioral of Counter128 is

signal count_tmp : STD_LOGIC_VECTOR (6 downto 0) := "0000000";

begin
process (clk,rst_n)
	
	begin
		if(rst_n = '0') then
			count_tmp <= (others => '0');
		elsif (rising_edge(clk)) then
			count_tmp <= count_tmp + 1;				
			if (count_tmp = 128) then	   			
				count_tmp <= (others => '0');								
			end if;
		end if;
		count <= count_tmp;
	end process;

end Behavioral;