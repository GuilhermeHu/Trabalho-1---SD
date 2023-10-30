----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:32:18 10/14/2023 
-- Design Name: 
-- Module Name:    desl_dir - Behavioral 
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

entity desl_dir is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end desl_dir;

architecture Behavioral of desl_dir is

signal z : STD_LOGIC_VECTOR (3 downto 0);

begin

z(3) <= '0';
z(2) <= a(3);
z(1) <= a(2);
z(0) <= a(1);

s <= z;

bit_sinal <= '0';
-- Sempre positivo

zero <= '1' when z = "0000" else '0';

end Behavioral;

