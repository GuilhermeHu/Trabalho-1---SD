----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:56 10/13/2023 
-- Design Name: 
-- Module Name:    incr_1 - Behavioral 
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

entity incr_1 is                                          --Incrementa a 1 (soma +1) o valor fornecido na entrada
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);         --Entrada, o número binário de 4 bits do qual se quer calcular o incremento
	   s : out  STD_LOGIC_VECTOR (3 downto 0);        --Resultado do incremento a 1
	   overflow : out  STD_LOGIC;                     --Flag de overflow, apontando se houve overflow na operação 
           carry_out : out  STD_LOGIC;                    --Flag de carry out, apontando se houve carry out na operação 
	   bit_sinal : out STD_LOGIC;                     --Flag de sinal, que aponta se o resultado do incremento deu um valor positivo (0) ou negativo (1)
	   zero : out STD_LOGIC);                         --Flag de zero, apontando se o resultado do incremento da ULA deu exatamente o valor zero ("0000")
end incr_1;

architecture Behavioral of incr_1 is

component somador_4bits is                                --Declaração do component do somador de 4 bits, que será utilizado para incrementar +1 ao valor da 
	 Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);    --entrada, afinal, incremento a 1 é basicamente uma soma de um binário com "0001"
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
	   overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
	   bit_sinal : out STD_LOGIC;
	   zero : out STD_LOGIC);
end component;

signal vetor : STD_LOGIC_VECTOR (3 downto 0);
signal ov : STD_LOGIC;
signal c_out : STD_LOGIC;
signal bit_sin: STD_LOGIC;
signal zeron : STD_LOGIC;

begin

-- Operando B do somador de 4 bits, que sempre será o vetor "0001" uma vez que se objetiva realizar o incrmeento a 1
vetor(3) <= '0';
vetor(2) <= '0';
vetor(1) <= '0';
vetor(0) <= '1';

incr: somador_4bits PORT MAP(a, vetor, '0', s, ov, c_out, bit_sin, zeron);     --Execução do somador de 4 bits, com operandos que são a entrada fornecida e '0001'

overflow <= ov;

carry_out <= c_out;

bit_sinal <= bit_sin;

zero <= zeron;

end Behavioral;

