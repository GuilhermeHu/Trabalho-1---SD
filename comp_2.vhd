----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:11:05 10/27/2023 
-- Design Name: 
-- Module Name:    comp2 - Behavioral 
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


-- Realiza o complemento a 2 de um binário de 4 bits, sendo com 3 bits de magnitude e um de sinal
-- Complemento a 2 é uma inversão de todos os bits, em seguida, um incremento a 1
entity comp_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);             --Entrada, o número binário de 4 bits do qual se quer calcular o complemento a 2
           s : out  STD_LOGIC_VECTOR (3 downto 0);            --Resultado da operação, que retorna o complemento a 2 da entrada dada
			  bit_sinal : out STD_LOGIC;          --Flag de sinal, apontando se o resultado da operação é positivo (0) ou negativo (1)
			  zero : out STD_LOGIC);              --Flag de zero, apontando se o resultado da operação é o valor zero ("0000")
end comp_2;

architecture Behavioral of comp_2 is

component somador_4bits is                                    --Declaração do component do somador de 4 bits, que será utilizado para incrementar +1
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);             --durante a operação de complemento a 2, após a inversão da entrada fornecida
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC;
	   carrys : out STD_LOGIC_VECTOR (4 downto 0));
end component;

signal a_inv : STD_LOGIC_VECTOR (3 downto 0);                 --signal que contém a entrada toda invertida
signal a_inv_incr : STD_LOGIC_VECTOR (3 downto 0);            --signal que contém o complemento a 2 da entrada, sendo o número dado invertido e acrescido a 1
signal b : STD_LOGIC_VECTOR (3 downto 0);
signal carry : STD_LOGIC_VECTOR (4 downto 0);
signal c_out: STD_LOGIC;

begin

b <= "0001";                    --Segunda entrada do somador de 4 bits, sendo sempre "0001" por estarmos realizando o incremento a 1

--Inversão de todos os bits do binário de entrada
a_inv(3) <= NOT a(3);
a_inv(2) <= NOT a(2);
a_inv(1) <= NOT a(1);
a_inv(0) <= NOT a(0);

soma: somador_4bits PORT MAP(a_inv, b, '0', a_inv_incr, c_out, carry);     --Exxecução do component do somador de 4 bits, que será utilizado para incrementar +1 

s <= a_inv_incr;

bit_sinal <= a_inv_incr(3);
zero <= '1' when a_inv_incr = "0000" else '0';

end Behavioral;
