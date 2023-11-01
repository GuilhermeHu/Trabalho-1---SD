----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:43:53 10/13/2023 
-- Design Name: 
-- Module Name:    somador_4bits - Behavioral 
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


-- Somador de operandos com 4 bits, sendo um bit de sinal e 3 de magnitude
-- O somador de 4 bits é a concatenação de 4 módulos de somadores completos de 1 bit, no qual o cout do módulo de somador do bit anterior (n-1) serve de cin para o módulo atual (n)
entity somador_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);           --Operando A da soma, um número binário de 4 bits, sendo 1 de sinal e 3 de magnitude
           b : in  STD_LOGIC_VECTOR (3 downto 0);           --Operando A da soma, um número binário de 4 bits, sendo 1 de sinal e 3 de magnitude
           c_in : in  STD_LOGIC;                            --C_in do primeiro módulo de somador de um bit (posição 0). Em uma soma, sempre é 0
           s : out  STD_LOGIC_VECTOR (3 downto 0);          --Resultado da operação de soma, sendo um número binário de 4 bits, 1 de sinal e 3 de magnitude
	   overflow : out  STD_LOGIC;                       --Flag de overflow, apontando se houve overflow (passou o limite de representação do binário) na soma
           carry_out : out  STD_LOGIC;                      --Flag de carry out, apontando se houve carry out na soma
	   carrys : out STD_LOGIC_VECTOR (4 downto 0);      --Vetor que contém os valores dos carrys de cada módulo de somador de um bit
	   bit_sinal : out STD_LOGIC;                       --Flag de sinal, mostrando se o resultado da soma deu um valor positivo (0) ou negativo (1)
	   zero : out STD_LOGIC);                           --Flag de zero, apontando se o resultado da soma deu exatamente o valor zero ("0000")
end somador_4bits; 

architecture Behavioral of somador_4bits is
	
component somador is                               --Como o somador de 4 bits é a concatenação de 4 módulos de somadores completos de 1 bit, 
    Port ( a : in  STD_LOGIC;                      --chama-se o componente de somador de 1 bit, que será usado para operar cada bit dos operandos
           b : in  STD_LOGIC;
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c_out : out  STD_LOGIC);
end component;

signal carry : STD_LOGIC_VECTOR (4 downto 0);
signal z : STD_LOGIC_VECTOR (3 downto 0);

begin
carry(0) <= c_in;          --carry do primeiro módulo de somador de um bit recebe 0 caso a operação seja de soma e recebe 1 caso seja uma subtração

exec: for i in 0 to 3 generate                                                    --Para cada posição de bit dos operandos (por serem 4 bits, vai de 0 a 3), o
	somador_4bits: somador PORT MAP(a(i), b(i), carry(i), z(i));              --somador de um bit será chamado e operará, fornecendo o resultado e o carry de  
	carry(i+1) <= (a(i) AND b(i)) OR (carry(i) AND (a(i) OR b(i)));           --cada uma das somas dos bits dessas posições. A soma será recebida pelo signal 
end generate;                                                                     --z e os carrys serão recebidos pelo signal carry

s <= z;

carrys <= carry;

carry_out <= carry(4);                 --Carry out é o carry do módulo de somador de um bit na última posição (posição do bit 3)

overflow <= carry(4) XOR carry(3);     --Overflow pode ser identificado caso os carrys dos bits mais significativos sejam diferentes

bit_sinal <= z(3);                     --Flag de sinal será igual ao bit de sinal do resultado

zero <= '1' when z = "0000" else '0';

end Behavioral;

