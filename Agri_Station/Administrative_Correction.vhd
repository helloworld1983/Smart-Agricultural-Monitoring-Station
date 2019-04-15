----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:05 03/13/2019 
-- Design Name: 
-- Module Name:    IRRIGATION_ACTIVATION - Behavioral 
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

entity Administrative_Correction is
		Port (clk 					: in std_logic;
				 reset 					: in std_logic;
				 switch 				: in std_logic;
				 UPPER_THRESH		: in std_logic_vector(7 downto 0);
				 LOWER_THRESH		: in std_logic_vector(7 downto 0);
			   ADC_VAL_PER_IN : in std_logic_vector(7 downto 0);
				 CONFIG_BITS 		: in std_logic_vector(2 downto 0);
				 WARNING_SIGNAL	: out std_logic_vector(1 downto 0);
				 IRRI_ACTIVATE	: in std_logic;
				 IRRI_DONE			: out std_logic;
				 EXT_ACTUATE		: out std_logic);
end Administrative_Correction;

architecture Behavioral of Administrative_Correction is --Administrative Correction

constant IRRIGATE_ON : std_logic:='1';
constant IRRIGATE_OFF : std_logic:='0';


begin

Actuation: process(clk,reset)
variable IRRIGATE_OVER :  std_logic:='0';
variable IRRIGATE_UNDER : std_logic:='0';
constant TOL_CONFGD 	: std_logic_vector(1 downto 0):="11";
	begin
		if(reset='1')then
			IRRIGATE_OVER:=IRRIGATE_OFF;
			IRRIGATE_UNDER:=IRRIGATE_OFF;
			EXT_ACTUATE<=IRRIGATE_OFF;
			IRRI_DONE<='0';
		elsif rising_edge(clk)then
			if(switch='1')then
				if(IRRI_ACTIVATE='1')then
					if(CONFIG_BITS(1 downto 0)=TOL_CONFGD)then
					 if(ADC_VAL_PER_IN>=LOWER_THRESH and ADC_VAL_PER_IN<=UPPER_THRESH)then  --Soil Moisture within range
						IRRIGATE_OVER:=IRRIGATE_OFF;
						IRRIGATE_UNDER:=IRRIGATE_OFF;
						
					 elsif(ADC_VAL_PER_IN<=LOWER_THRESH)then		--Soil Moisture *lower* than lower threshold
						IRRIGATE_OVER:=IRRIGATE_OFF;
						IRRIGATE_UNDER:=IRRIGATE_ON;
						
					 elsif(ADC_VAL_PER_IN>=UPPER_THRESH)then   --Soil Moisture *higher* than high threshold
						IRRIGATE_OVER:=IRRIGATE_ON;
						IRRIGATE_UNDER:=IRRIGATE_OFF;
					end if;
				 end if;
					IRRI_DONE<='1';
				elsif(IRRI_ACTIVATE='0')then
					IRRI_DONE<='0';
				end if;
			end if;
		end if;
	WARNING_SIGNAL<=IRRIGATE_UNDER&IRRIGATE_OVER;
	EXT_ACTUATE<=IRRIGATE_UNDER;
end process;

end Behavioral;

