LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Prescale IS
	PORT (Clk: IN STD_LOGIC;
			Out_Clock: Buffer  STD_LOGIC);
END Prescale;

---If we want to generate the signal of frequency 100hz exactly ---
ARCHITECTURE BEHAVIOUR OF Prescale IS

SIGNAL Count: UNSIGNED(17 DOWNTO 0);

BEGIN
	PROCESS(Clk)
	
	BEGIN 
	
		IF rising_edge(Clk) THEN
			Count <= Count + 1;  
			Out_Clock <= Out_Clock;
			IF (COUNT="111101000010010000") THEN  
--- 111101000010010000 corresponds to 250000 in decimals. It is considered here, as 250000 cycles of Clk would correspond to half period of 100hz signal.
				Out_Clock <= NOT Out_Clock;
				Count <= (others=>'0'); 
			END IF;
		END IF;
	END PROCESS;

END BEHAVIOUR;

---OR  If we want to generate the signal of frequency ~100hz ---
--ARCHITECTURE BEHAVIOUR_2 OF Prescale IS
--
--SIGNAL Count: UNSIGNED(18 DOWNTO 0);
--
--BEGIN
--	Count <= (Count + 1) when Rising_Edge(Clk);  
--	Out_Clock<= Count(18);
--
--END BEHAVIOUR_2;
