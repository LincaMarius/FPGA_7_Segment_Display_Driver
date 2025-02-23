library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Aplicațion for testing
-- Hexadecimal to one Digit 7-Segment Common Anode Display FPGA Driver

entity Aplication_3 is
    Port (
		clk50MHz: in STD_LOGIC; -- Main clock 50 MHz
		rst_n: in STD_LOGIC; -- Reset button
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments control outputs 
		dp: out STD_LOGIC; -- DP on Piswords PIAX301V2 FPGA board control output
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board control output
		);		
end Aplication_3;

architecture Behavioral of Aplication_3 is

-- we declare the components
component HEX_to_1_Digit_CA is
    Port (
		HEX_in: in STD_LOGIC_VECTOR (3 downto 0); -- HEX data input
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

component Counter16 is
	Port 
	( 
		clk 		: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		count 	: OUT	STD_LOGIC_VECTOR (3 downto 0)
	);
end component;

-- signals for connection between modules
SIGNAL clk2Hz: std_logic := '0';
SIGNAL HEX_data: STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin
-- modules mapping           
decoder : component HEX_to_1_Digit_CA port map (
	HEX_in => HEX_data,
	dp_in => HEX_data(0),
	Segments => Segments,
	dp => dp,
	SEL7 => SEL7);
	
clk_2_Hz : component Clk_2Hz port map (
	clk_in => clk50MHz,
	rst_n	=> rst_n,
	clk_out => clk2Hz);
	
counttb : component Counter16 port map (
	clk => clk2Hz,
	rst_n	=> rst_n,
	count => HEX_data);
	
end Behavioral;