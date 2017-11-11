LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY System IS
	PORT (clock, ARM: IN STD_LOGIC;
			Doors: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			Ready, SysArmed, AlarmOn: OUT  STD_LOGIC);
END System;

ARCHITECTURE Basic OF System IS
TYPE MyState IS (Sys_Off, Sys_active, Sys_Alarmed);
Signal PreSt: MyState := Sys_Off;
Signal NxtSt: MyState;

Begin
Process(clock,PreSt,NxtSt)
Begin

If rising_edge(clock) then
PreSt<=NxtSt ;
end If;

Case PreSt IS
	when Sys_Off =>
			if ARM='1' then
				if Doors="0000" then
					NxtSt<= Sys_Active;
				else
					NxtSt<= Sys_Alarmed;
				end if;
			end if;
	when Sys_Active =>
			if ARM='1' then
				NxtSt<= Sys_Off;
			elsif not(Doors="0000") then
				NxtSt<= Sys_Alarmed;
			end if;
	when Sys_Alarmed =>
			if ARM='1' then
				NxtSt<= Sys_Off;
			end if;
end Case;
end Process;

Ready <= '1' when (Doors="0000") else '0';
SysArmed <= '1' when PreSt=Sys_Active else '0';
AlarmOn <= '1' when PreSt=Sys_Alarmed else '0';
End Basic;
				
