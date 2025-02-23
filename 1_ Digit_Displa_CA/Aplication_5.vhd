library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Aplicațion for testing
-- ASCII to one Digit 7-Segment Common Anode Display FPGA Driver

entity Aplication_5 is
	Port (
		clk50MHz: in STD_LOGIC; -- Main clock 50 MHz
		rst_n: in STD_LOGIC; -- Reset button
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments control outputs 
		dp: out STD_LOGIC; -- DP on Piswords PIAX301V2 FPGA board control output
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board control output
	);		
end Aplication_5;

architecture Behavioral of Aplication_5 is

-- we declare the components
component ASCII_to_1_Digit_CA is
	Port (
		ASCII_in: in STD_LOGIC_VECTOR (6 downto 0); -- ASCII data input
		dp_in: in STD_LOGIC; -- DP signal
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments 
		dp: out STD_LOGIC; -- DP on Piswords PIAX301V2 FPGA board
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board
	);
end component;

component Clk_2Hz is
	Port 
	( 
		clk_in 	: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		clk_out 	: OUT	STD_LOGIC
	);
end component;

component Counter128 is
	Port 
	( 
		clk 		: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		count 	: OUT	STD_LOGIC_VECTOR (6 downto 0)
	);
end component;

-- signals for connection between modules
SIGNAL clk2Hz: std_logic := '0';
SIGNAL ASCII_data: STD_LOGIC_VECTOR (6 downto 0) := "0000000";

begin
-- modules mapping           
decoder : component ASCII_to_1_Digit_CA port map (
	ASCII_in => ASCII_data,
	dp_in => ASCII_data(0),
	Segments => Segments,
	dp => dp,
	SEL7 => SEL7);
	
clk_2_Hz : component Clk_2Hz port map (
	clk_in => clk50MHz,
	rst_n	=> rst_n,
	clk_out => clk2Hz);
	
counttb : component Counter128 port map (
	clk => clk2Hz,
	rst_n	=> rst_n,
	count => ASCII_data);
	
end Behavioral;