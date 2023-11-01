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


entity main is                                                 --entidade que relaciona a ULA e o contador, de modo a facilitar a exibição dos resultados na placa FPGA
	Port(selector: in std_logic_vector (2 downto 0);       --chave de controle que define a operação a ser feita na ULA (vai de 000 a 111)
	     clk: in std_logic;                                --entrada de clock 
	     reset: in std_logic;                              --entrada de reset, que reinicia os valores do contador
	     s: out std_logic_vector (3 downto 0);             --resultado da operação desempenhada pela ULA
	     flag_overflow : out std_logic;                    --Flag de overflow, apontando se houve overflow em uma operação que envolva a soma das entradas
	     flag_carry_out : out std_logic;                   --Flag de carry out, apontando se houve carry out em uma operação que envolva a soma das entradas
	     flag_sinal : out std_logic;                       --Flag de sinal, que aponta se o resultado da operação da ULA deu um valor positivo (0) ou negativo (1)
	     flag_zero : out std_logic);                       --Flag de zero, apontando se o resultado da operação da ULA deu exatamente o valor zero ("0000")
end main;

architecture hardware of main is

--declaração do componente da ULA:
component ula is                                                  
	Port (a : in  STD_LOGIC_VECTOR (3 downto 0);
		b : in  STD_LOGIC_VECTOR (3 downto 0);
		selector : in  STD_LOGIC_VECTOR (2 downto 0);
		s : out  STD_LOGIC_VECTOR (3 downto 0);
		overflow : out std_logic;
		carry_out : out std_logic;
		bit_sinal : out std_logic;
		zero : out std_logic);
end component;

--declaração do componente do contador:
component counter_seconds is                                     
	PORT (clock_50 : in STD_LOGIC;
	      reset : in STD_LOGIC;                                       
	      counter_out: out unsigned (7 downto 0) := "00000000");    
end component;

--Signals que servirão como valores de entrada para a ULA
signal A,B: std_logic_vector (3 downto 0);
signal BA: unsigned (7 downto 0);

--A ideia é que o contador conte um vetor de 8 bits (BA), e a parte direita desse grande vetor (os 4 bits mais à direita) seja a entrada A da ULA, enquanto
--  a parte mais à esquerda desse grande vetor (os 4 bits mais à esquerda) sejam os valores da entrada B da ULA. Objetiva-se, com isso, realizar uma
--  iteração com todos os valores possíveis para servirem de entradas para a ULA

begin
	
	ula_process: ula PORT MAP (A, B, selector, s, flag_overflow, flag_carry_out, flag_sinal, flag_zero);            --Execução da ULA
	conta: counter_seconds PORT MAP(clk, reset, BA);                                                                --Execução do contador

	--Atribuição dos valores que servirão de entrada para a ULA: 
	A <= std_logic_vector(BA(3 downto 0));                                        --Entrada A são os 4 bits mais à direita do grande vetor
	B <= std_logic_vector(BA(7 downto 4));                                        --Entrada B são os 4 bits mais à esquerda do grande vetor

end hardware;
