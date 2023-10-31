----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:39 10/12/2023 
-- Design Name: 
-- Module Name:    somador - Behavioral 
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

entity somador is                         --somador: retorna a soma e carry do bit A com o bit B e com o carry_in (c_in, carry do bit anterior), std_logic -> std_logic
    Port ( a : in  STD_LOGIC;             --entrada do bit A
           b : in  STD_LOGIC;             --entrada do bit B
           c_in : in  STD_LOGIC;          --entrada do bit c_in
           s : out  STD_LOGIC;            --resultado da soma
           c_out : out  STD_LOGIC);       --c_out da soma
end somador;
    
architecture Behavioral of somador is

begin

s <= (a XOR b) XOR c_in;                         --soma de dois bits se dá pela expressão booleana [(A XOR B) XOR cin], encontrado através da simplificação da tabela verdade 
c_out <= (a AND b) OR (c_in AND (a OR b));       --c_out de dois bits se dá pela expressão booleana [(A AND B) OR  (cin AND (A OR B))], encontrado através da tabela verdade 

end Behavioral;

