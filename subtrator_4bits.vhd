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


-- Módulo de subtrator, que realiza a subtração de dois binários de 4 bits, sendo um bit de sinal e 3 bits de magnitude. Assim, esse módulo
-- realiza operações na faixa de -8 a 7, em decimal.
-- Um subtrator nada mais é do que uma soma, na qual o segundo operando está em complemento a dois: A-B = A+(-B). Desse modo, nesse módulo,
-- serão usados os componentes de complemento a dois e de somador.
entity subtrator_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);                  --Operando A da subtração, um número binário de 4 bits, sendo 1 de sinal e 3 de magnitude
           b : in  STD_LOGIC_VECTOR (3 downto 0);                  --Operando B da subtração, um número binário de 4 bits, sendo 1 de sinal e 3 de magnitude
           s : out  STD_LOGIC_VECTOR (3 downto 0);                 --Resultado da subtração, um número binário de 4 bits, sendo 1 de sinal e 3 de magnitude
			  overflow : out STD_LOGIC;                --Flag de overflow, apontando se houve overflow (passou o limite de representação do binário) na subtração
			  carry_out : out STD_LOGIC;               --Flag de carry out, apontando se houve carry out na subtração (durante a soma com o complemento a 2)
			  bit_sinal : out STD_LOGIC;               --Flag de sinal, mostrando se o resultado da subtração deu um valor positivo (0) ou negativo (1)
			  zero : out STD_LOGIC);                   --Flag de zero, apontando se o resultado da subtração deu exatamente o valor zero ("0000")
end subtrator_4bits;

architecture Behavioral of subtrator_4bits is

component somador_4bits is                                        --Declaração do componente de somador de 4 bits, que será utilizado para realizar
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);                 -- A + (-B), estando B em sua representação de complemento a 2
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC;
	   carrys : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component comp_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);                 --Declaração do componente de complemento a 2, que converte um valor dado a sua forma
           s : out  STD_LOGIC_VECTOR (3 downto 0));               --de complemento a 2. Na subtração, o operando B será convertido para complemento a 2
end component;

signal r : STD_LOGIC_VECTOR (3 downto 0);
signal soma : STD_LOGIC_VECTOR (3 downto 0);
signal c_out : STD_LOGIC;
signal compl2_soma : STD_LOGIC_VECTOR (3 downto 0);
signal r_neg : STD_LOGIC_VECTOR (3 downto 0);
signal z : STD_LOGIC_VECTOR (3 downto 0);
signal carry : STD_LOGIC_VECTOR (4 downto 0);

begin

comp2: comp_2 PORT MAP(b, r);                                             -- Realização do complemento a 2 do valor da entrada B

subtrair: somador_4bits PORT MAP(a, r, '0', soma, c_out, carry);          -- Execução do somador de 4 bits, que fará A + (-B)
	
carry_out <= carry(4);

overflow <= carry(4) XOR carry(3);      --Overflow pode ser identificado caso os carrys dos bits mais significativos sejam diferentes

-- Como o resultado não pode sair em complemento a dois, caso o resultado dê um valor negativo, já que o resultado terá que ser convertido à forma
-- BCD para aparecer no display de 7 segmentos, temos que manipular a saída de modo que mostre o módulo do valor resultado da soma, em binário normal, 
-- mas com um bit de sinal na frente para mostrar que o valor é negativo. Assim, fazemos o complemento a 2 do resultado caso este seja negativo:
comp2_2: comp_2 PORT MAP(soma, compl2_soma);  

-- Apenas os 3 bits de magnitude são convertidos de volta a sua versão positiva, o bit de sinal se mantém negativo
r_neg(0) <= compl2_soma(0);
r_neg(1) <= compl2_soma(1);
r_neg(2) <= compl2_soma(2);
r_neg(3) <= '1';

-- Caso o bit de sinal do resultado da operação de subtração indique uma resposta positiva, a resposta do módulo da subtração será a própria saída da
-- soma realizada. Porém, se for negativo, deve-se calcular o r_neg, em que o bit de sinal se mantém, mas os bit de magnitude são dados em sua versão
-- positiva (uma espécie de módulo do valor)
s <= soma when soma(3) = '0' else r_neg;

bit_sinal <= '1' when soma(3) = '1' else '0';

z <= soma when soma(3) = '0' else r_neg;

zero <= '1' when z = "0000" else '0';

end Behavioral;

