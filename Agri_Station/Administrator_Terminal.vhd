----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:27:22 03/23/2019 
-- Design Name: 
-- Module Name:    Administrator_Terminal - Behavioral 
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


entity Administrator_Terminal is
	Port( clk        		: in std_logic;
			reset        		: in std_logic;
			display_cycle		: in std_logic;
			phone_num_en 		: in std_logic;
			soil_tol_en	 		: in std_logic;
		  positive_engage	: in std_logic;
			negative_engage : in std_logic;
			switch    		  : in std_logic;
			led       		  : out std_logic_vector(7 downto 0);
			seg 		    		: out std_logic_vector(7 downto 0); 
			buzzer      		: out std_logic;
			tx_line     		: out std_logic;
			rx_line	    		: in std_logic;
      anode 					: inout std_logic_vector(3 downto 0);
			keys		     		: in std_logic_vector(3 downto 0);
			DATA_AVL    		: in std_logic;
			EXT_ACTUATE     : out	std_logic;
			ADC_VAL_DISP		: in std_logic_vector(31 downto 0);
			ADC_PER_DISP		: in std_logic_vector(31 downto 0);
			ADC_PER					: in std_logic_vector(7 downto 0);
			ADC_CLK					: out std_logic;
		  CONFIGURE_EN		: in  std_logic;
			IRRI_ACTIVATE		: in  std_logic;
			TRANSMIT_EN  		: in  std_logic;
			IRRI_DONE	 			: out  std_logic;
      UART_TX_DONE		 			: out  std_logic;
		  CONFIG_DONE      :inout std_logic);
end Administrator_Terminal;

architecture Behavioral of Administrator_Terminal is

signal clk_1kHz           : std_logic:='0'; --1kHz clock signal
signal clk_115200Hz		  	: std_logic:='0'; 
signal clk_921600Hz 		  : std_logic:='0';
signal clk_10Hz			  	  : std_logic:='0';
signal clk_10kHz					: std_logic:='0';
signal clk_1Hz				   	: std_logic:='0';

signal TX_DONE				  	: std_logic:='0';
signal buzz_signal		  	: std_logic:='0';
signal display_value		  : std_logic_vector(31 downto 0):=(others => '0');--for 4 digit time multiplexer
signal char_byte			 		: std_logic_vector(7 downto 0):=(others => '0');
signal R_DATA				 		  : std_logic_vector(7 downto 0):=(others => '0');

--Message Output Data
constant MAX_MSG_LENGTH : integer := 55;
signal 	 MESSAGE 				: std_logic_vector((MAX_MSG_LENGTH*8)-1 downto 0):=(others => '0');

--Keypad Output	Data			
signal phone_num					   : std_logic_vector(55 downto 0):=(others => '0');
signal soil_tol_pos_display	 : std_logic_vector(15 downto 0):=(others => '0');
signal soil_tol_neg_display	 : std_logic_vector(15 downto 0):=(others => '0');
signal soil_tol_pos_value		 : std_logic_vector(7 downto 0):=(others => '0');
signal soil_tol_neg_value		 : std_logic_vector(7 downto 0):=(others => '0');
signal CONFIG_BITS		       : std_logic_vector(2 downto 0):=(others => '0');


--Irrigation Control
signal WARNING_SIGNAL			   : std_logic_vector(1 downto 0):=(others=>'0');


begin

cop1 : entity work.frequency_divider
  port map(clk => clk,
					reset => reset,
					clock1 => clk_1kHz,
					clock2 => ADC_CLK,
					clock3 => clk_115200Hz,
					clock4=>  clk_10kHz,
					clock5 => clk_921600Hz,
					clock6 => clk_1Hz);

cop2 : entity work.time_multiplexer_4digit
  port map(clk => clk_1kHz,      
					reset => reset, 
					display_value =>display_value,
					seg =>seg,
					anode => anode); 
			  
cop3 : entity work.message_generation
  port map(clk=> clk_921600Hz,
					reset => reset,
					switch => switch,
					phone_num => phone_num,
					soil_tol_pos=>soil_tol_pos_display,
					soil_tol_neg=>soil_tol_neg_display,
					CONFIG_BITS=>CONFIG_BITS,
					WARNING_SIGNAL=>WARNING_SIGNAL,
					MESSAGE=>MESSAGE);
			  
cop4 : entity work.uart_tx
  port map(tx_clk=> clk_115200Hz,
	        msg_clk=>clk_10kHz,
					reset => reset,
					switch => switch,
					WARNING_SIGNAL=>WARNING_SIGNAL,
					CONFIG_BITS=>CONFIG_BITS,
					MESSAGE =>MESSAGE,--R_DATA,
										TRANSMIT_EN=>TRANSMIT_EN,
					UART_TX_DONE=>UART_TX_DONE,
					tx_line=>tx_line);
			  	  
--cop5: entity work.uart_rx
--  port map(clk => clk_921600Hz,
--					TX_DONE=>TX_DONE,
--					reset => reset,
--					switch => switch,
--					rx_line=> rx_line,
--					R_DATA => R_DATA);
--				
cop5 : entity work.keypad_data
  port map(clk=> clk_1kHz,
					 reset => reset,
					 switch => switch,
					 
					 phone_num_en => phone_num_en,
					 soil_tol_en=> soil_tol_en,
					 positive_engage=>positive_engage,
					 negative_engage=>negative_engage,
					 
					 phone_num =>  phone_num,
					 soil_tol_pos_display=>soil_tol_pos_display,
					 soil_tol_neg_display=>soil_tol_neg_display,
					 
					 soil_tol_pos_value=>soil_tol_pos_value,
					 soil_tol_neg_value=>soil_tol_neg_value,
					 
					 CONFIG_DONE=>CONFIG_DONE,
					 CONFIGURE_EN=>CONFIGURE_EN,
					 CONFIG_BITS=>CONFIG_BITS,
					 DATA_AVL => DATA_AVL,
					 key_buzz =>buzz_signal,
					 keys=>keys);
			
cop6 : entity work.buzz_sequence
  port map(clk=> clk_1kHz,
					 reset => reset,
					 switch => switch,
					 buzz_event=>buzz_signal,
					 buzzer=> buzzer);
			  	  
					 
cop7: entity work.data_display
  port map(clk=> clk_1kHz,
					 reset => reset,
					 switch => switch,
					 display_cycle=>display_cycle,
					 shift_enable=>clk_1Hz,
					 CONFIG_DONE=>CONFIG_DONE,
					 phone_num_IN=>phone_num,
					 ADC_Val_In=>ADC_VAL_DISP,
					 ADC_PER_IN=>ADC_PER_DISP,
					 soil_tol_pos_In=>soil_tol_pos_display,
					 soil_tol_neg_In=>soil_tol_neg_display,
					 display_out=>display_value);
					 
					 
cop8: entity work.Administrative_Correction
  port map(clk=> clk_1kHz,
					 reset => reset,
					 switch => switch,
           ADC_VAL_PER_IN=>ADC_PER,
					 UPPER_THRESH=>soil_tol_pos_value,
					 LOWER_THRESH=>soil_tol_neg_value,
					 CONFIG_BITS=>CONFIG_BITS,
						IRRI_ACTIVATE =>IRRI_ACTIVATE,
						IRRI_DONE => IRRI_DONE,
					 EXT_ACTUATE=>EXT_ACTUATE,
					 WARNING_SIGNAL=>WARNING_SIGNAL);

cop9 : entity work.Sys_Status_LEDs
  port map(clk=> clk_1kHz,
					reset => reset,
					switch => switch,
					CONFIG_BITS=>CONFIG_BITS,
					
					WARNING_SIGNAL=>WARNING_SIGNAL,
					led=>led);


end Behavioral;

