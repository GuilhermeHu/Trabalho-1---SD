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


entity counter_seconds is                                                --Contador, o módulo auxiliar de nossa ULA que serivirá para nos fornecer os valores de entrada para a ULA
	GENERIC (t_max : INTEGER := 100000000);                          --Valor que servirá para ajustar o clock padrão da placa FPGA, que possui frequência de 50MHz, para que dure 2s
	PORT (clock_50 : in STD_LOGIC;                                   --Entrada de clock, associada ao clock padrão fornecido pela placa FPGA
	      reset : in STD_LOGIC ;	                                 --Entrada de reset, que reinicia os valores do contador
	      counter_out: out unsigned (7 downto 0) := "00000000");     --Vetor de 8 bits que será dividido pela metade em dois vetores de 4 bits, que servirão como entradas para a ULA
end counter_seconds;

architecture Behavioral of counter_seconds is
 
SIGNAL contagem_geral : unsigned(7 downto 0) := "00000000";              --Signal que representa o vetor com a contagem 

begin

counter_label : process (clock_50, reset)
variable slow_clock : INTEGER RANGE t_max downto 0 := 0;
	begin
	if (reset = '1') then
		contagem_geral <= "00000000";                             --Caso o reset seja habilitado (igual a '1'), o contador será zerado
	elsif rising_edge (clock_50) then                                 --Ativado por subida do clock
	-- if (clock_50'event AND clock_50 = '1') then
		if (slow_clock <= t_max) then
				slow_clock := slow_clock + 1;
			else contagem_geral <= contagem_geral + 1;        --Realização da contagem 
			slow_clock := 0;
			end if;
		end if;
end process;
			
counter_out <= contagem_geral;

end Behavioral;



