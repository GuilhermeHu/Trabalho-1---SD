----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:45:07 10/14/2023 
-- Design Name: 
-- Module Name:    par_ou_impar - Behavioral 
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


-- Esse módulo nos informa se o resultado da soma de dois números fornecidos deu um número par ou ímpar, semelhante ao jogo par ou ímpar 
-- que é cotidianamente realizado entre as pessoas. Definimos par como 0 e ímpar como 1 por causa de suas paridades.
entity par_ou_impar is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);             --Entrada A, um número binário de 4 bits
	   b : in  STD_LOGIC_VECTOR (3 downto 0);             --Entrada B, um número binário de 4 bits
           s : out  STD_LOGIC;                                --Resultado da operação, sendo '0' quando o resultado da soma de A com B for um valor par, e sendo '1' quando o resultado for ímpar
	   overflow : out STD_LOGIC;                          --Flag de overflow, apontando se houve overflow da soma entre A e B
	   carry_out : out STD_LOGIC;                         --Flag de carry out, apontando se houve carry out da soma entre A e B
	   bit_sinal : out STD_LOGIC;                         --Flag de sinal, que aponta se o resultado da soma entre A e B deu um valor positivo (0) ou negativo (1)
	   zero : out STD_LOGIC);                             --Flag de zero, apontando se o resultado da soma entre A e B deu exatamente o valor zero ("0000")
end par_ou_impar;

architecture Behavioral of par_ou_impar is

component somador_4bits is                                    --Como esse módulo precisa somar A e B antes de verificar se o resultado é par ou ímpar,
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);             --chama-se o componente do somador de 4 bits para a execução da soma
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
	   overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
	   bit_sinal : out STD_LOGIC;
	   zero : out STD_LOGIC);
end component;

signal r : STD_LOGIC_VECTOR (3 downto 0);
signal cin : STD_LOGIC;
signal ov : STD_LOGIC;
signal c_out : STD_LOGIC;
signal bit_sin: STD_LOGIC;
signal zeron : STD_LOGIC;

begin

cin <= '0';                  --C_in de uma soma sempre é 0

soma: somador_4bits PORT MAP(a, b, cin, r, ov, c_out, bit_sin, zeron);               --Execução do somador de 4 bits

s <= r(0);                   --A paridade de um número depende exclusivamente de seu bit menos significativo, que representa, em decimal, o 2^0 (1). Assim,
                             --um número binário que apresente como bit menos significativo o '1', é ímpar por em sua conversão para decimal somar-se 1
overflow <= ov;
carry_out <= c_out;
bit_sinal <= r(3);
zero <= zeron;

end Behavioral;

