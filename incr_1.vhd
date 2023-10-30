----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:56 10/13/2023 
-- Design Name: 
-- Module Name:    incr_1 - Behavioral 
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

entity incr_1 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end incr_1;

architecture Behavioral of incr_1 is

component somador_4bits is
	 Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c_in : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end component;

signal vetor : STD_LOGIC_VECTOR (3 downto 0);
signal ov : STD_LOGIC;
signal c_out : STD_LOGIC;
signal bit_sin: STD_LOGIC;
signal zeron : STD_LOGIC;

begin

vetor(3) <= '0';
vetor(2) <= '0';
vetor(1) <= '0';
vetor(0) <= '1';

incr: somador_4bits PORT MAP(a, vetor, '0', s, ov, c_out, bit_sin, zeron);

overflow <= ov;

carry_out <= c_out;

bit_sinal <= bit_sin;

zero <= zeron;

end Behavioral;

