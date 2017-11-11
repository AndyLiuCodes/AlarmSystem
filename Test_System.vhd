LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Test_System IS
	PORT (CLOCK_50: IN STD_LOGIC;
			SW: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			KEY: IN STD_LOGIC_VECTOR (3 DOWNTO 3);
			HEX0, HEX1, HEX2: OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
			LEDG: OUT  STD_LOGIC_VECTOR(7 DOWNTO 0); 
			LEDR: OUT  STD_LOGIC_VECTOR(3 DOWNTO 0));
END Test_System;

ARCHITECTURE TEST OF Test_System IS

Signal slow_clock, ready, armed, al_on, del: std_logic;

Begin

prescaler: work.Prescale port map(CLOCK_50, slow_clock);
--sys_basic: work.System port map(slow_clock,KEY(3),SW(3 downto 0),ready,armed,al_on);
sys_delay: work.System2(Delayed2) port map(slow_clock,KEY(3),SW(3 downto 0),ready,armed,al_on,del);

alarm_msg: work.Alarm port map(slow_clock,al_on,HEX0,HEX1,HEX2);
LEDG(2)<=ready;
LEDG(1)<=armed;
LEDG(0)<=al_on;
LEDR(3 downto 0) <= SW(3 downto 0);
LEDG(7)<=del;

End TEST;