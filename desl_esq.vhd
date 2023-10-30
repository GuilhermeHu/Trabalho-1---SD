----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:40:35 10/14/2023 
-- Design Name: 
-- Module Name:    desl_esq - Behavioral 
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

entity desl_esq is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end desl_esq;

architecture Behavioral of desl_esq is

signal z : STD_LOGIC_VECTOR (3 downto 0);

begin

z(3) <= a(2);
z(2) <= a(1);
z(1) <= a(0);
z(0) <= '0';

s <= z;

bit_sinal <= '0';
-- Sempre positivo

zero <= '1' when z = "0000" else '0';

end Behavioral;

