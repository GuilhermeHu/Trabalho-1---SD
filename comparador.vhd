----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:36 10/14/2023 
-- Design Name: 
-- Module Name:    comparador - Behavioral 
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


-- O comparador verifica se os dois binários de entrada são iguais (mesmo número). Caso sejam iguais, resultará em '1', caso contrário, resultará em '0'
entity comparador is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);           --Entrada A, um binário de 4 bits
           b : in  STD_LOGIC_VECTOR (3 downto 0);           --Entrada B, um binário de 4 bits
           s : out  STD_LOGIC);                             --Resultado da comparação, podendo ser '1' ou '0', por isso std_logic
end comparador;

architecture Behavioral of comparador is

begin

--Para realizar a comparação, basta comparar cada um dos bits das entradas em seus respectivos índices (posições). A comparação pode ser feita usado-se a 
--porta lógica XNOR, que dará '1' quando os bits de entrada forem iguais (0 com 0, ou 1 com 1). O AND é para confirmar se todas as comparações resultaram em 
--'1', ou seja, que todos os bits das entradas em uma determinada posição são iguais.
s <= (a(0) XNOR b(0)) AND (a(1) XNOR b(1)) AND (a(2) XNOR b(2)) AND (a(3) XNOR b(3));

end Behavioral;

