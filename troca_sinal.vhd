----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:57:25 10/14/2023 
-- Design Name: 
-- Module Name:    troca_sinal - Behavioral 
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

entity troca_sinal is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end troca_sinal;

architecture Behavioral of troca_sinal is

component comp_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal r : STD_LOGIC_VECTOR (3 downto 0);
signal r2 : STD_LOGIC_VECTOR (3 downto 0);
signal z : STD_LOGIC_VECTOR (3 downto 0);

begin

comp2: comp_2 PORT MAP(a, r);

r2 <= a when a(3) = '0' else r;

z(0) <= r2(0);
z(1) <= r2(1);
z(2) <= r2(2);
z(3) <= NOT r2(3) when NOT (r2(0) = '0' AND r2(1) = '0' AND r2(2) = '0') AND a(3) = '0' else r2(3);

-- Entrada negativa seria dada em complemento a 2?

s <= z;

bit_sinal <= z(3);

zero <= '1' when z = "0000" else '0';

end Behavioral;

