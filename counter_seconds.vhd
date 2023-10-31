----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:11:42 10/30/2023 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
	GENERIC (t_max : INTEGER := 100000000);
	PORT (clock_50 : in STD_LOGIC;
			reset : in STD_LOGIC ;	
			counter_out: out unsigned (7 downto 0) := "00000000");
end counter_seconds;

architecture Behavioral of counter_seconds is
 
SIGNAL contagem_geral : unsigned(7 downto 0) := "00000000";

begin

counter_label : process (clock_50, reset)
variable slow_clock : INTEGER RANGE t_max downto 0 := 0;
	begin
	if (reset = '1') then
		contagem_geral <= "00000000"; --zerar o contador quando o reset for habilitado
	elsif rising_edge (clock_50) then 
	-- if (clock_50'event AND clock_50 = '1') then
		if (slow_clock <= t_max) then
				slow_clock := slow_clock + 1;
			else contagem_geral <= contagem_geral + 1;
			slow_clock := 0;
			end if;
		end if;
end process;
			
counter_out <= contagem_geral;

end Behavioral;



