Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

entity Test_JamesBond is
	port(KEY : in std_logic_vector(3 downto 3);
		  SW : in std_logic_vector(17 downto 15);
		  CLOCK_50: in std_logic;
		  LEDR : out std_logic_vector(17 downto 17));
end Test_JamesBond;

Architecture Behaviour of Test_JamesBond is
	signal slw_clk: std_logic;
	
Begin
 
prescaler1: work.Prescale port map(CLOCK_50, slw_clk);
JamesB: work.JamesBond port map(KEY(3), SW(17 downto 15), slw_clk, LEDR(17));

End Behaviour;