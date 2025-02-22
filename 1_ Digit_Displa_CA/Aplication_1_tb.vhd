library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- VHDL code for Aplication 1 test bench
-- who uses
-- BCD to one Digit 7-Segment C0mm0n Anode Display FPGA Driver

entity Aplication_1_tb is	
end Aplication_1_tb;

architecture testbench of Aplication_1_tb is

-- we declare the components under test
component Aplication_1 is
    Port (
		clk50MHz: in STD_LOGIC; -- Main clock 50 MHz
		rst_n: in STD_LOGIC; -- Reset button
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments control outputs 
		dp: out STD_LOGIC; -- DP on Piswords PIAX301V2 FPGA board control output
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board control output
		);	
end component;

-- input signals of the mode under test
SIGNAL clk50MHz_tb: std_logic := '0';
SIGNAL rst_n: std_logic := '0';

-- output signals of the module under test
SIGNAL SEG_tb: STD_LOGIC_VECTOR (6 downto 0);
SIGNAL dp_tb: STD_LOGIC;
SIGNAL SEL7_tb: STD_LOGIC;

begin
-- we generate a clock signal with a frequency of 50 MHz
clock_process: process
begin
	clk50MHz_tb <= '0';
	wait for 10 ns;
	clk50MHz_tb <= '1';
	wait for 10 ns;	
end process;

-- unit under test port maping           
uut : component Aplication_1 port map (
	clk50MHz => clk50MHz_tb,
	rst_n => rst_n,
	Segments => SEG_tb,
	dp => dp_tb,
	SEL7 => SEL7_tb);
	
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