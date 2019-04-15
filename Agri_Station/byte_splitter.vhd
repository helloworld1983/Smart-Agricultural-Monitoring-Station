----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:55:10 10/04/2018 
-- Design Name: 
-- Module Name:    byte_splitter - Behavioral 
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

library UNISIM;
use UNISIM.VComponents.all;

entity Sys_Status_LEDs is
		Port (clk 					: in std_logic;
				 reset 					: in std_logic;
				 switch 				: in std_logic;
				 CONFIG_BITS		: in std_logic_vector(2 downto 0);
				 WARNING_SIGNAL	: in std_logic_vector(1 downto 0);
			   led 						: out std_logic_vector(7 downto 0));
end Sys_Status_LEDs;

architecture Behavioral of Sys_Status_LEDs is --Sys_Status_LEDs


begin

 led_illumination: process (clk,reset,switch)
	begin
		if(reset='1') then
			led <=(others=>'0');
		elsif rising_edge(clk)then 
			if (switch = '1') then
			led(0) <= '0';
			led(1) <= '0';
			led(2) <= WARNING_SIGNAL(0);  --Under Lower Threshold
			led(3) <= WARNING_SIGNAL(1);	--Over Upper Threshold
			led(4) <= '0';
			led(5) <= CONFIG_BITS(0);--upper_thresh_set;
			led(6) <= CONFIG_BITS(1);--lower_thresh_set;
			led(7) <= CONFIG_BITS(2);--phone_num_set;
			end if;
		end if;
 end process;
		


end Behavioral;

