----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:32 10/31/2023 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
use IEEE.numeric_std.all;


entity main is --entidade que junta tudo para funcionar na placa
	port(selector: in std_logic_vector (2 downto 0); -- chave de controle que define a operação
		  clk: in std_logic; --entrada de clock
	     reset: in std_logic; --reset, reinicia os valores do contador
	     s: out std_logic_vector (3 downto 0); -- resultado da operação
	     flag_overflow : out std_logic; -- flag caso ocorra overflow na operação
		  flag_carry_out : out std_logic; -- flag caso o carry out seja 1
		  flag_sinal : out std_logic; -- flag caso o resultado seja negativo
		  flag_zero : out std_logic); --flag caso o resultado seja igual a zero
end main;

architecture hardware of main is

component ula -- declaração do componente da ula
	Port (a : in  STD_LOGIC_VECTOR (3 downto 0);
			b : in  STD_LOGIC_VECTOR (3 downto 0);
			selector : in  STD_LOGIC_VECTOR (2 downto 0);
			s : out  STD_LOGIC_VECTOR (3 downto 0);
			overflow : out std_logic;
			carry_out : out std_logic;
			bit_sinal : out std_logic;
			zero : out std_logic);
end component;

component counter_seconds is
	PORT (clock_50 : in STD_LOGIC;
			reset : in STD_LOGIC;
			counter_out: out unsigned (7 downto 0) := "00000000"); -- saida
end component;

	--sinais que servirão de entrada para a ULA
	signal A,B: std_logic_vector (3 downto 0);
	signal AB: unsigned (7 downto 0);

begin

	ula_process: ula PORT MAP (A, B, selector, s, flag_overflow, flag_carry_out, flag_sinal, flag_zero); -- ULA
	conta: counter_seconds PORT MAP(clk, reset, AB); -- contador

	--atribuição dos valores de entrada da ULA
	A <= std_logic_vector(AB(3 downto 0));
	B <= std_logic_vector(AB(7 downto 4));

end hardware;
