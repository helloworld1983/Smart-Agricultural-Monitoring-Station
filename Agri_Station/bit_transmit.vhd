----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:38 03/22/2019 
-- Design Name: 
-- Module Name:    bit_transmit - Behavioral 
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


entity bit_transmit is
		Port (clk 				: in std_logic;
				reset 				: in std_logic;
				switch 				: in std_logic;
				TX_READY			: in std_logic;
				TX_MESSAGE		: in std_logic_vector(9 downto 0);
				TX_DONE				: out std_logic;
				tx_line				: out std_logic);
end bit_transmit;

architecture Behavioral of bit_transmit is
constant idle : std_logic:='1';

begin
uart_transmit: process (clk,reset)
 variable bit_count: integer range 0 to 10:=0;
 begin
	if(reset='1') then
		tx_line<=idle;
		bit_count:=0;
		TX_DONE<='0';
		elsif rising_edge(clk)then 
			if(switch = '1')then
		
				if(TX_READY = '1')then
				 if(bit_count=10)then
					TX_DONE<='1';
					tx_line<=idle;
					bit_count:=0;
				 elsif(bit_count<=9)then
					tx_line<=TX_MESSAGE(bit_count);
					bit_count:= bit_count+1;
					TX_DONE<='0';
				 end if;
				elsif(TX_READY = '0')then
				 tx_line<=idle;
				end if;
		  end if;
		end if;
 end process;

end Behavioral;

