----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:48:20 10/14/2023 
-- Design Name: 
-- Module Name:    subtrator_4bits - Behavioral 
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


-- Módulo de subtrartor: bit de sinal (4) + 3 bits magnitude. Logo, trata-se de um subtrator
-- de 3 bits, realizando operações xom operandos na faixa de -8 a 7.
entity subtrator_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  overflow : out STD_LOGIC;
			  carry_out : out STD_LOGIC;
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end subtrator_4bits;

architecture Behavioral of subtrator_4bits is

component somador_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC;
			  carrys : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component comp_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal r : STD_LOGIC_VECTOR (3 downto 0);
signal soma : STD_LOGIC_VECTOR (3 downto 0);
signal c_out : STD_LOGIC;
signal compl2_soma : STD_LOGIC_VECTOR (3 downto 0);
signal r_neg : STD_LOGIC_VECTOR (3 downto 0);
signal z : STD_LOGIC_VECTOR (3 downto 0);
signal carry : STD_LOGIC_VECTOR (4 downto 0);

begin

comp2: comp_2 PORT MAP(b, r); 
-- Primeiramente, realizamos o complemento a 2 do valor da entrada B

subtrair: somador_4bits PORT MAP(a, r, '0', soma, c_out, carry);
-- Em seguida, acontece a soma A + (-B)

carry_out <= carry(4);

overflow <= ((NOT a(3)) AND (NOT b(3)) AND soma(3)) OR (a(3) AND b(3) AND (NOT soma(3)));

-- Como o resultado não pode sair em complemento a dois, caso dê negativojá que terá que ser 
-- convertido em BCD para aparecer no display de 7 segmentos, temos que manipular a saída de 
-- modo que mostre o módulo do valor resultado da soma, em binário normal, mas com um bit de 
-- sinal na frente para mostrar que o valor é negativo. Assim, fazemos o complemento a 2 do 
-- resultado caso este seja negativo:
comp2_2: comp_2 PORT MAP(soma, compl2_soma);

r_neg(0) <= compl2_soma(0);
r_neg(1) <= compl2_soma(1);
r_neg(2) <= compl2_soma(2);
r_neg(3) <= '1';

-- Nesse trecho de código abaixo, determinamos se o resutado da soma deve aparecer positivo ou  
-- negativo. Dependerá do bit de sinal da resposta de A-B. Caso tal cálculo resulte em um valor
-- positivo (bit de sinal 0), o resultado será a própria soma, caso dê negativo (bit de sinal 1)
-- a soma será o "r_neg", o resultado convertido em módulo e com bit de sinal 1:
s <= soma when soma(3) = '0' else r_neg;

bit_sinal <= '1' when soma(3) = '1' else '0';

z <= soma when soma(3) = '0' else r_neg;

zero <= '1' when z = "0000" else '0';

end Behavioral;

