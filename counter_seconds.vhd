----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:11:42 10/30/2023 
-- Design Name: 
-- Module Name:    counter_seconds - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity counter_seconds is
	GENERIC (t_max : INTEGER := 1000000);
	PORT (clock_50 : in STD_LOGIC;
			counter_out: out unsigned (3 downto 0) := "0000";
			counter_out_2: out unsigned (3 downto 0) := "0000");
end counter_seconds;

architecture Behavioral of counter_seconds is

 
SIGNAL counter_temp : unsigned(3 downto 0) := "0000";
SIGNAL counter_temp_2 : unsigned(3 downto 0) := "0000";


begin


counter_label : process (clock_50)
variable slow_clock : INTEGER RANGE t_max downto 0 := 0;
	begin
	if (clock_50'event AND clock_50 = '1') then
	--if (rising_edge (clock_50)) then
			if (slow_clock <= t_max) then
				slow_clock := slow_clock + 1;
			else counter_temp <= counter_temp + 1;
			slow_clock := 0;
			end if;
		end if;
end process;


counter_label_2 : process (clock_50)
variable slow_clock_2 : INTEGER RANGE t_max downto 0 := 0;
	begin
		if (clock_50'event AND clock_50 = '1') then
		--if (rising_edge (clock_50)) then
			if (slow_clock_2 <= t_max) then
				slow_clock_2 := slow_clock_2 + 2;
			else counter_temp_2 <= counter_temp_2 + 2;
			slow_clock_2 := 0;
			end if;
		end if;
end process;
			
counter_out <= counter_temp;
counter_out_2 <= counter_temp_2;
	
end Behavioral;



