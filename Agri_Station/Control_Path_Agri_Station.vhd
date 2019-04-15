----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:52:44 03/28/2019
-- Design Name: 
-- Module Name:    Control_Path_Agri_Station - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:   The template for this was taken from ECNG 3016 notes, any similarities can be
--								attributed to that. The template was the work of Mr. Marcus George.
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


entity Control_Path_Agri_Station is
    Port ( clk 				 	: in  std_logic;
           reset 			 	: in  std_logic;
					 switch				: in  std_logic;
					 ADC_DONE 	 	: in  std_logic;
					 IRRI_DONE	 	: in  std_logic;
					 UART_TX_DONE : in  std_logic;
					 CONFIG_DONE 	: in  std_logic;
					 CONFIGURE_EN	: out  std_logic;
					 ADC_EN			 	: out  std_logic;
					 IRRI_ACTIVATE: out  std_logic;
					 TRANSMIT_EN  : out  std_logic);
end Control_Path_Agri_Station;

architecture Behavioral of Control_Path_Agri_Station is

type CEC_fsm is (	initialize,configure_system,adc_sample,system_correction,message_transmission,done);
signal pstate, nstate : CEC_fsm;

begin

clkPROC : process(clk, reset)
		begin
			if(reset = '1') then
				pstate <= initialize;
			elsif rising_edge(clk) then
			 if(switch='1')then
					pstate <= nstate;
			 end if;
			end if;
		end process;
		
next_statePROC : process(	pstate,CONFIG_DONE,ADC_DONE,IRRI_DONE,UART_TX_DONE)							
								
		begin
			case pstate is
			
				when initialize =>nstate <= configure_system;
				
				when configure_system =>
					if (CONFIG_DONE = '1') then
						nstate <= adc_sample;
					else
						nstate <= configure_system;
					end if;
					
				when adc_sample =>
					if (ADC_DONE = '1') then
						nstate <= system_correction;
					else
						nstate <= adc_sample;
					end if;

				when system_correction =>
					if (IRRI_DONE = '1') then
						nstate <= message_transmission;
					else
						nstate <= system_correction;
					end if;
				
			
				when message_transmission =>
					if (UART_TX_DONE  = '1') then
						nstate <= done;
					else
						nstate <= message_transmission;
					end if;
					
				when done =>nstate <= adc_sample;
				
			end case;
		end process;
		
outputPROC : process(pstate)
		begin
			case pstate is
			
				when initialize =>
					CONFIGURE_EN 	<= '0';
					ADC_EN 				<= '0';
					IRRI_ACTIVATE <= '0';
					TRANSMIT_EN 	<= '0';
					
				when configure_system =>
					CONFIGURE_EN 	<= '1';
					ADC_EN 				<= '0';
					IRRI_ACTIVATE <= '0';
					TRANSMIT_EN 	<= '0';
					
				when adc_sample =>
					CONFIGURE_EN 	<= '0';
					ADC_EN 				<= '1';
					IRRI_ACTIVATE <= '0';
					TRANSMIT_EN 	<= '0';
					
				when system_correction =>
					CONFIGURE_EN 	<= '0';
					ADC_EN 				<= '0';
					IRRI_ACTIVATE <= '1';
					TRANSMIT_EN 	<= '0';
					
				when message_transmission =>
					CONFIGURE_EN 	<= '0';
					ADC_EN 				<= '0';
					IRRI_ACTIVATE <= '0';
					TRANSMIT_EN 	<= '1';
					
				when done =>
					CONFIGURE_EN 	<= '0';
					ADC_EN 				<= '0';
					IRRI_ACTIVATE <= '0';
					TRANSMIT_EN 	<= '0';
				
			end case;
		end process;

end Behavioral;

