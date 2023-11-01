----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:13:03 05/21/2019 
-- Design Name: 
-- Module Name:    ULA - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ULA is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);                 --Operando A da ULA, um número binário de 4 bits
	   b : in STD_LOGIC_VECTOR (3 downto 0);                 --Operando B da ULA, um número binário de 4 bits
	   selector : in STD_LOGIC_VECTOR (2 downto 0);          --chave de controle que define a operação a ser feita na ULA (vai de 000 a 111)
           s : out  STD_LOGIC_VECTOR (3 downto 0);               --Resultado da operação escolhida na ULA, um número binário de 4 bits
	   overflow : out  STD_LOGIC;                            --Flag de overflow, apontando se houve overflow em uma operação que envolva a soma das entradas
           carry_out : out  STD_LOGIC;                           --Flag de carry out, apontando se houve carry out em uma operação que envolva a soma das entradas
	   bit_sinal : out  STD_LOGIC;                           --Flag de sinal, que aponta se o resultado da operação da ULA deu um valor positivo (0) ou negativo (1)
           zero : out  STD_LOGIC);                               --Flag de zero, apontando se o resultado da operação da ULA deu exatamente o valor zero ("0000")
end ULA;

architecture Behavioral of ULA is

-- Declaração do módulo de somador de 4 bits
-- Esse módulo realiza a soma de dois operandos de 4 bits, sendo 1 bit de sinal e 3 de magnitude
component somador_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
	   overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
           carrys : out STD_LOGIC_VECTOR (4 downto 0);
	   bit_sinal : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end component;

-- Declaração do componente de subtrator de 4 bits
-- Esse módulo realiza a subtração de dois operandos de 4 bits, sendo 1 bit de sinal e 3 de magnitude. Ou seja, realiza a soma do operando A com a versão
-- em complemento a 2 do operando B
component subtrator_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  overflow : out STD_LOGIC;
			  carry_out : out STD_LOGIC;
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end component;

-- Declaração do componente de incremento a 1
-- Esse módulo adiciona +1 a um número de 4 bits fornecido, sendo 1 bit de sinal e 3 de magnitude
component incr_1 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
	   overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
	   bit_sinal : out  STD_LOGIC;
	   zero : out STD_LOGIC);
end component;

-- Declaração do componente de complemento a 2
-- Esse módulo realiza o complemento a 2 do número fornecido
component comp_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
	   bit_sinal : out STD_LOGIC;
           zero : out  STD_LOGIC);
end component;

-- Declaração do componente de deslocamento à direita
-- Desloca, à direita, todos os bits do número fornecido. No lado mais à equerda, acrescenta-se um 0.
component desl_dir is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
	   bit_sinal : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end component;

-- Declaração do componente de deslocamento à esquerda
-- Esse módulo desloca, à esquerda, todos os bits do número fornecido. No lado mais à direita, acrescenta-se um 0.
component desl_esq is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
	   bit_sinal : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end component;

-- Declaração do componente do comparador
-- Esse módulo verifica se os dois valores fornecidos são iguais. A resposta é "0001" se forem iguais, caso contrário é "0000".
component comparador is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
	   s : out  STD_LOGIC);
end component;

-- Declaração do componente do módulo de "par ou ímpar da soma"
-- Esse módulo verifica se a soma de dois números fornecidos é par ou ímpar. Caso seja par, resulta em "0000", por outro lado, se for ímpar, resulta em "0001".
component par_ou_impar is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC;
			  overflow : out STD_LOGIC;
			  carry_out : out STD_LOGIC;
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end component;

--Declaração dos sinais que representam as saídas (outputs) da ULA
SIGNAL somador_4bits_s : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL somador_4bits_carrys : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL subtrator_4bits_s : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL incr_1_s : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL comp_2_s : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL desl_dir_s : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL desl_esq_s : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL comparador_s : STD_LOGIC;
SIGNAL par_ou_impar_s : STD_LOGIC;


--Declaração sinais usados que representam as flags (overflow, carry_out, sinal e zero) da ULA
SIGNAL somador_4bits_overflow, subtrator_4bits_overflow, incr_1_overflow, par_ou_impar_overflow: STD_LOGIC;
SIGNAL somador_4bits_carry_out, subtrator_4bits_carry_out, incr_1_carry_out, par_ou_impar_carry_out : STD_LOGIC;
SIGNAL somador_4bits_zero, subtrator_4bits_zero, incr_1_zero, comp_2_zero, desl_esq_zero, desl_dir_zero, par_ou_impar_zero, comparador_zero : STD_LOGIC;
SIGNAL somador_4bits_bit_sinal, subtrator_4bits_bit_sinal, incr_1_bit_sinal, comp_2_bit_sinal, desl_esq_bit_sinal, desl_dir_bit_sinal, par_ou_impar_bit_sinal, comparador_bit_sinal : STD_LOGIC;


begin

--Atribuição dos componentes aos sinais correspontes e execução dos módulos
somador_4bits_Label: somador_4bits port map (a, b, '0', somador_4bits_s, somador_4bits_overflow, somador_4bits_carry_out, somador_4bits_carrys, somador_4bits_bit_sinal, somador_4bits_zero);
subtrator_4bits_Label : subtrator_4bits port map (a, b, subtrator_4bits_s, subtrator_4bits_overflow, subtrator_4bits_carry_out, subtrator_4bits_bit_sinal, subtrator_4bits_zero);
incr_1_Label: incr_1 port map (a, incr_1_s, incr_1_overflow, incr_1_carry_out, incr_1_bit_sinal, incr_1_zero);
comp_2_Label : comp_2 port map (a, comp_2_s, comp_2_bit_sinal, comp_2_zero);
desl_esq_Label: desl_esq port map(a, desl_esq_s, desl_esq_bit_sinal, desl_esq_zero);
desl_dir_Label : desl_dir port map (a, desl_dir_s, desl_dir_bit_sinal, desl_dir_zero);
comparador_Label : comparador port map (a, b, comparador_s);
par_ou_impar_Label : par_ou_impar port map (a, b, par_ou_impar_s, par_ou_impar_overflow, par_ou_impar_carry_out, par_ou_impar_zero, par_ou_impar_bit_sinal);


process(selector, incr_1_s, desl_esq_s, somador_4bits_s, subtrator_4bits_s, desl_dir_s, par_ou_impar_s, comp_2_s, comparador_s)

begin
	case selector is
		when "000" => -- somador de 4 bits                                  -- "000" -> somador de 4 bits
		   overflow <= somador_4bits_overflow;                              -- "001" -> subtrator de 4 bits
			carry_out <= somador_4bits_carry_out;                       -- "010" -> incremento a 1
			zero <= somador_4bits_zero;                                 -- "011" -> complemento a 2
			bit_sinal <= somador_4bits_bit_sinal;                       -- "100" -> deslocamento à direita
			s <= somador_4bits_s;                                       -- "101" -> deslocamento à esquerda
		when "001" => -- subtrator de 4 bits                                -- "110" -> comparador
			overflow <= subtrator_4bits_overflow;                       -- "111" -> par ou ímpar da soma
			carry_out <= subtrator_4bits_carry_out;
			zero <= subtrator_4bits_zero;
			bit_sinal <= subtrator_4bits_bit_sinal;
			s <= subtrator_4bits_s;
		when "010" => -- incremento a 1
			overflow <= incr_1_overflow;
			carry_out <= incr_1_zero;
			zero <= incr_1_zero;
			bit_sinal <= incr_1_bit_sinal;
			s <= incr_1_s;
		when "011" => -- complemento a 2
			carry_out <= '0';
			zero <= comp_2_zero;
			bit_sinal <= comp_2_bit_sinal;
			s <= comp_2_s;
		when "100" => -- deslocamento à direita
			carry_out <= '0';
			zero <= desl_dir_zero;
			bit_sinal <= desl_dir_bit_sinal;
			s <= desl_dir_s;
		when "101" => -- deslocamento à esquerda
			carry_out <= '0';
			zero <= desl_esq_zero;
			bit_sinal <= desl_esq_bit_sinal;
			s <= desl_esq_s;
		when "110" => -- comparador
			carry_out <= '0';
			zero <= comparador_zero;
			bit_sinal <= comparador_bit_sinal;
			s(3) <= '0';
			s(2) <= '0';
			s(1) <= '0';
			s(0) <= comparador_s;
		when others => -- par ou ímpar
			overflow <= par_ou_impar_overflow;
			carry_out <= par_ou_impar_carry_out;
			zero <= par_ou_impar_zero;
			bit_sinal <= par_ou_impar_bit_sinal;
			s(3) <= '0';
			s(2) <= '0';
			s(1) <= '0';
			s(0) <= par_ou_impar_s;

	end case;
	end process;

end Behavioral;
