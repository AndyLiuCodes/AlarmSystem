LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Alarm IS
	PORT (Clock: IN STD_LOGIC;
			Enable: IN STD_LOGIC;
			Seg0, Seg1, Seg2: OUT  STD_LOGIC_VECTOR(6 DOWNTO 0));
END Alarm;

ARCHITECTURE BEHAVIOUR OF Alarm IS
SIGNAL Count2: UNSIGNED(5 DOWNTO 0):=(others=>'0');
SIGNAL Out_Clock2: STD_LOGIC;
BEGIN
	PROCESS(Clock)
	BEGIN 
		IF rising_edge(Clock) THEN
			Count2 <= Count2 + "000001";  
			Out_Clock2 <= Out_Clock2;
			IF (COUNT2="110010") THEN  
--- 110010 corresponds to 50 in decimals. It is considered here, as 50 cycles of Clock would correspond to half period of 1hz signal.
				Out_Clock2 <= NOT Out_Clock2;
				Count2 <= (others=>'0');  
			END IF;
		END IF;
	END PROCESS;
	
	Seg0 <= "1111001" when  Out_Clock2 = '1' and Enable = '1' else "1111111";
	Seg1 <= "1111001" when  Out_Clock2 = '1' and Enable = '1' else "1111111";
	Seg2 <= "0011000" when  Out_Clock2 = '1' and Enable = '1' else "1111111";

END BEHAVIOUR;