----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:11:05 10/27/2023 
-- Design Name: 
-- Module Name:    comp2 - Behavioral 
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


-- complemento a 2 de um numero com 3 bits de magnitude, e um de sinal
entity comp_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end comp_2;

architecture Behavioral of comp_2 is

component somador_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC;
			  carrys : out STD_LOGIC_VECTOR (4 downto 0));
end component;

signal a_inv : STD_LOGIC_VECTOR (3 downto 0);
signal a_inv_incr : STD_LOGIC_VECTOR (3 downto 0);
signal b : STD_LOGIC_VECTOR (3 downto 0);
signal carry : STD_LOGIC_VECTOR (4 downto 0);
signal c_out: STD_LOGIC;

begin

b <= "0001";

a_inv(3) <= NOT a(3);
a_inv(2) <= NOT a(2);
a_inv(1) <= NOT a(1);
a_inv(0) <= NOT a(0);

soma: somador_4bits PORT MAP(a_inv, b, '0', a_inv_incr, c_out, carry);

s <= a_inv_incr;

bit_sinal <= a_inv_incr(3);
zero <= '1' when a_inv_incr = "0000" else '0';

end Behavioral;
