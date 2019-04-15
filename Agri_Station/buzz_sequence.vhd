----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:20 02/13/2019 
-- Design Name: 
-- Module Name:    buzz_sequence - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD;



entity buzz_sequence is
  Port		(clk 			: in std_logic;
					 reset 			: in std_logic;
					 switch			: in std_logic;
					 buzz_event	: in std_logic;
					 buzzer 		: out std_logic);
end buzz_sequence;

	architecture Behavioral of buzz_sequence is
constant stop_buzz	 	: std_logic :='0';
constant start_buzz	 	: std_logic :='1';

begin
 keypress: process(clk,reset)
  begin
	 if(reset = '1')then
		 buzzer<=stop_buzz;
	 elsif rising_edge(clk) then
		if(switch = '1')then
			if(buzz_event='1')then
			 buzzer<=start_buzz;
			else
			 buzzer<=stop_buzz;
			end if;
	 end if;
	 end if;
	end process;

end Behavioral;

