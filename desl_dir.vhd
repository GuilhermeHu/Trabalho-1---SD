----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:32:18 10/14/2023 
-- Design Name: 
-- Module Name:    desl_dir - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity desl_dir is                                         --Desloca todos os bits da entrada para a direita. Adiciona-se um '0' na posição mais à esquerda
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);          --Entrada, o número binário de 4 bits do qual se quer fazer o deslocamento
           s : out  STD_LOGIC_VECTOR (3 downto 0);         --Resultado da operação, que retorna o delocamento à direita da entrada dada
	   bit_sinal : out STD_LOGIC;                      --Flag de sinal, apontando se o resultado da operação é positivo (0) ou negativo (1)
	   zero : out STD_LOGIC);                          --Flag de zero, apontando se o resultado da operação é o valor zero ("0000")
end desl_dir;

architecture Behavioral of desl_dir is

signal z : STD_LOGIC_VECTOR (3 downto 0);

begin

--Deslocamento dos bits: o bit da posição n recebe o bit da posição n+1. Como o bit mais à esquerda (bit 3) não possui um correspondente, receberá sempre 0
z(3) <= '0';
z(2) <= a(3);
z(1) <= a(2);
z(0) <= a(1);

s <= z;

--Como o bit mais a esquerda sempre receberá 0, o número sempre será positivo pois é essa a posição que apresenta o bit de sinal 
bit_sinal <= '0';   --bit_sinal <= z(3);

zero <= '1' when z = "0000" else '0';

end Behavioral;

