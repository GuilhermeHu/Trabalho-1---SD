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
entity somador_4bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
			  carrys : out STD_LOGIC_VECTOR (4 downto 0);
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end somador_4bits;

architecture Behavioral of somador_4bits is

component somador is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c_out : out  STD_LOGIC);
end component;

signal carry : STD_LOGIC_VECTOR (4 downto 0);
signal z : STD_LOGIC_VECTOR (3 downto 0);

begin
carry(0) <= c_in;

exec: for i in 0 to 3 generate
			somador_4bits: somador PORT MAP(a(i), b(i), carry(i), z(i));
			carry(i+1) <= (a(i) AND b(i)) OR (carry(i) AND (a(i) OR b(i)));
		end generate;

s <= z;

carrys <= carry;

carry_out <= carry(4);

overflow <= carry(4) XOR carry(3);

bit_sinal <= '0';
-- Sempre positivo: estamos considerando que o input nunca é dado em complemento a 2, ou seja,
-- que o input sempre é positivo. Logo, o resultado também será sempre positivo. Os casos que
-- abrangem situações com números negativos serão realizados pelo subtrator

zero <= '1' when z = "0000" else '0';

end Behavioral;

