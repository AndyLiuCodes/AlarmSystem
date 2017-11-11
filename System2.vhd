LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY System2 IS
	PORT (clock, ARM: IN STD_LOGIC;
			Doors: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			Ready, SysArmed, AlarmOn, Delay: OUT  STD_LOGIC);
END System2;

ARCHITECTURE Basic OF System2 IS
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

ARCHITECTURE Delayed2 OF System2 IS
TYPE NewState IS (SysOff, Sysactive, SysAlarmed, DelayAlarm, DelayedSystem);
Signal PreSt: NewState := SysOff;
Signal NxtSt: NewState;
Signal load, nc: std_logic :='0';
Begin

step1: entity work.TenSecDelay port map(clock,load,nc);
Process(clock,PreSt,NxtSt)
Begin

If rising_edge(clock) then
PreSt<=NxtSt ;
end If;

Case PreSt IS
	when SysOff =>
			if ARM='1' then
					load<='1';
					NxtSt<= DelayedSystem;
			end if;
	when DelayedSystem =>
			if load='1' then
					NxtSt<= SysActive;
			end if;
	when SysActive =>
			if ARM='1' then
				NxtSt<= SysOff;
			elsif not(Doors="0000") then
				load<='1';
				NxtSt<= DelayAlarm;
			end if;
	when DelayAlarm =>
			if load='1'then
				NxtSt<=SysAlarmed;
			elsif ARM='1' then
				NxtSt<= SysOff;
			end if;
	when SysAlarmed =>
			if ARM='1' then 
				NxtSt<= SysOff;
			end if;
end Case;
if load='1' then
load <='0';
end if;

end Process;

Ready <= '1' when (Doors="0000") else '0';
SysArmed <= '1' when PreSt=SysActive else '0';
AlarmOn <= '1' when PreSt=SysAlarmed else '0';
Delay <='1' when load='1' else '0';
End Delayed2;