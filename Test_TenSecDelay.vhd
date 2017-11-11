LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Test_TenSecDelay IS
	PORT (CLOCK_50: IN STD_LOGIC;
			KEY: IN STD_LOGIC_VECTOR (0 downto 0);
			LEDG: Out  STD_LOGIC_VECTOR(7 downto 7));
END Test_TenSecDelay;

ARCHITECTURE BEHAVIOUR OF Test_TenSecDelay IS

signal slw_clk: std_logic;

Begin

Prescaler: work.PreScale port map (CLOCK_50, slw_clk);
delay: work.TenSecDelay port map (slw_clk,KEY(0),LEDG(7));

END BEHAVIOUR;
