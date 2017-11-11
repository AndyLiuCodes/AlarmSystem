LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TenSecDelay IS
	PORT (Clk, Load: IN STD_LOGIC;
			NC: Out  STD_LOGIC :='0');
END TenSecDelay;

ARCHITECTURE BEHAVIOUR OF TenSecDelay IS

SIGNAL Count: UNSIGNED(9 DOWNTO 0) :="0000000000";

BEGIN
PROCESS(Clk,Load)
	
	BEGIN 
		IF rising_edge(Clk) THEN
			IF Load='1' then
				Count<="1111101000";
			ELSIF Count>"0000000000" then
					Count <= Count - "0000000001" ;
				ELSE
					Count<="0000000000" ;
			END IF;
		END IF;
	
END PROCESS;
NC<='0' when Count="0000000000" else '1';

END BEHAVIOUR;


