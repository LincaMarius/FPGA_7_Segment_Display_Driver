library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- VHDL code for test bench for Hexadecimal to one Digit 7-Segment Display FPGA Driver

entity HEX_to_1_Digit_CA_tb is	
end HEX_to_1_Digit_CA_tb;

architecture testbench of HEX_to_1_Digit_CA_tb is

-- we declare the components under test
component HEX_to_1_Digit_CA is
    Port (
		HEX_in: in STD_LOGIC_VECTOR (3 downto 0); -- BCD data input
		dp_in: in STD_LOGIC; -- DP signal
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments 
		dp: out STD_LOGIC; -- DP on Piswords PIAX301V2 FPGA board
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board
		);
end component;

-- we declare other components that help the test
component Clk_2Hz is
	Port 
	( 
		clk_in 	: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		clk_out 	: OUT	STD_LOGIC
	);
end component;

component Counter16 is
	Port 
	( 
		clk 		: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		count 	: OUT	STD_LOGIC_VECTOR (3 downto 0)
	);
end component;

-- input signals of the mode under test
SIGNAL HEX_tb: STD_LOGIC_VECTOR (3 downto 0) := "0000";

-- output signals of the module under test
SIGNAL SEG_tb: STD_LOGIC_VECTOR (6 downto 0);
SIGNAL dp_tb: STD_LOGIC;
SIGNAL SEL7_tb: STD_LOGIC;

-- other input signals
SIGNAL clk_tb: std_logic := '0';
SIGNAL rst_n: std_logic := '0';

-- other output signals
SIGNAL clk2Hz_tb: std_logic := '0';

begin
-- we generate a clock signal with a frequency of 50 MHz
clock_process: process
begin
	clk_tb <= '0';
	wait for 10 ns;
	clk_tb <= '1';
	wait for 10 ns;	
end process;

-- unit under test port maping           
uut : component HEX_to_1_Digit_CA port map (
	HEX_in => HEX_tb,
	dp_in => HEX_tb(0),
	Segments => SEG_tb,
	dp => dp_tb,
	SEL7 => SEL7_tb);
	
clk2Hz : component Clk_2Hz port map (
	clk_in => clk_tb,
	rst_n	=> rst_n,
	clk_out => clk2Hz_tb);
	
counttb : component Counter16 port map (
	clk => clk2Hz_tb,
	rst_n	=> rst_n,
	count => HEX_tb);
	
-- the testing process
stimuli : process 
	begin
		report("Start simulation");
		
		-- initial conditions
		rst_n <= '0';
		wait for 1 ms;
		
		rst_n <= '1';
		wait for 30000 ms;

		report("End of simulation");
	
	wait; -- End of simulation
end process;	
		

end testbench;