----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:45:07 10/14/2023 
-- Design Name: 
-- Module Name:    par_ou_impar - Behavioral 
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


-- Esse módulo nos informa se o resultado da soma de dois números deu um número par ou
-- ímpar, semelhante ao jogo par ou ímpar que é cotidianamente realizado entre pessoas 
-- que querem definir algo. Definimos par como 0 e ímpar como 1 por causa de suas paridades.
entity par_ou_impar is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
			  b : in  STD_LOGIC_VECTOR (3 downto 0);
           s : out  STD_LOGIC;
			  overflow : out STD_LOGIC;
			  carry_out : out STD_LOGIC;
			  bit_sinal : out STD_LOGIC;
			  zero : out STD_LOGIC);
end par_ou_impar;

architecture Behavioral of par_ou_impar is

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

signal r : STD_LOGIC_VECTOR (3 downto 0);
signal cin : STD_LOGIC;
signal ov : STD_LOGIC;
signal c_out : STD_LOGIC;
signal bit_sin: STD_LOGIC;
signal zeron : STD_LOGIC;

begin

cin <= '0';

soma: somador_4bits PORT MAP(a, b, cin, r, ov, c_out, bit_sin, zeron);

s <= r(0);
overflow <= ov;
carry_out <= c_out;
bit_sinal <= '0';
zero <= zeron;

end Behavioral;

