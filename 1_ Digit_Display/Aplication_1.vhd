library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Aplicațion for testing
-- BCD to one Digit 7-Segment Display FPGA Driver

entity Aplication_1 is
    Port (
		clk50MHz: in STD_LOGIC; -- Main clock 50 MHz
		rst_n: in STD_LOGIC; -- Reset button
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments control outputs 
		bp: out STD_LOGIC; -- BP on Piswords PIAX301V2 FPGA board control output
		SEL7:	out STD_LOGIC -- SEL7 on Piswords PIAX301V2 FPGA board control output
		);		
end Aplication_1;

architecture Behavioral of Aplication_1 is

-- we declare the components
component BCD_to_1_Digit is
    Port (
		BCD_in: in STD_LOGIC_VECTOR (3 downto 0); -- BCD data input
		bp_in: in STD_LOGIC; 	-- BP signal
		Segments: out STD_LOGIC_VECTOR (6 downto 0); -- Cathode segments 
		bp: out STD_LOGIC;	-- BP on Piswords PIAX301V2 FPGA board
		SEL7:	out STD_LOGIC	-- SEL7 on Piswords PIAX301V2 FPGA board
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
		clk 	: IN	STD_LOGIC;
		rst_n		: IN	STD_LOGIC;
		count 	: OUT	STD_LOGIC_VECTOR (3 downto 0)
	);
end component;

-- signals for connection between modules
SIGNAL clk2Hz: std_logic := '0';
SIGNAL BCD_data: STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin
-- modules mapping           
decoder : component BCD_to_1_Digit port map (
	BCD_in => BCD_data,
	bp_in => BCD_data(0),
	Segments => Segments,
	bp => bp,
	SEL7 => SEL7);
	
clk_2_Hz : component Clk_2Hz port map (
	clk_in => clk50MHz,
	rst_n	=> rst_n,
	clk_out => clk2Hz);
	
counttb : component Counter16 port map (
	clk => clk2Hz,
	rst_n	=> rst_n,
	count => BCD_data);
	
end Behavioral;