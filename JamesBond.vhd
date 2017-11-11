Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

entity JamesBond is
	port(Go : in std_logic;
		  Digit : in std_logic_vector(2 downto 0);
		  Clk: in std_logic;
		  GotCode : out std_logic);
end entity;

Architecture Behaviour of JamesBond is
	signal Output: std_logic_vector (2 downto 0) :="000";
	signal Count: unsigned(9 DOWNTO 0) :="1111101000";
	
Begin

Process(Clk)
	
Begin 
		if rising_edge(Clk) then
			if (Digit(0)='1' and Count >"0000000000") then
				Count <= Count-"0000000001";
				Output(0) <= '1';
			else
				Output(0) <= '0';
			end if;
			if (Digit(1)='1' and Output(0) = '1' and Count >"0000000000") then
				Count <= Count-"0000000001";
				Output(1) <= '1';
			else
				Output(1) <= '0';
			end if;
			if (Digit(2)='1' and Output(1) = '1' and Count >"0000000000") then
				Count <= Count-"0000000001";
				Output(2) <= '1';
			else 
				Output(2) <= '0';
			end if;
	      if (Output(2)='1' and (Count >"0000000000") and Go = '1') then
			
					GotCode<='1';
					Count<= "0000000001";
				else
					GotCode<='0';
			end if;
		end if;
end Process;
 

End Behaviour;
				