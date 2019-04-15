--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:31:52 03/28/2019
-- Design Name:   
-- Module Name:   C:/Users/fudge/Documents/Xilinx Projects/Spartan 3 Projects/Agri_Station24.03.2019/Agri_Station/Control_Path_Agri_Station_TB.vhd
-- Project Name:  Agri_Station
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control_Path_Agri_Station
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Control_Path_Agri_Station_TB IS
END Control_Path_Agri_Station_TB;
 
ARCHITECTURE behavior OF Control_Path_Agri_Station_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control_Path_Agri_Station
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
				 switch : IN  std_logic;
         ADC_DONE : IN  std_logic;
         IRRI_DONE : IN  std_logic;
         UART_TX_DONE : IN  std_logic;
         CONFIG_DONE : IN  std_logic;
         CONFIGURE_EN : OUT  std_logic;
         ADC_EN : OUT  std_logic;
         IRRI_ACTIVATE : OUT  std_logic;
         TRANSMIT_EN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	 signal switch : std_logic := '0';
   signal reset : std_logic := '0';
   signal ADC_DONE : std_logic := '0';
   signal IRRI_DONE : std_logic := '0';
   signal UART_TX_DONE : std_logic := '0';
   signal CONFIG_DONE : std_logic := '0';

 	--Outputs
   signal CONFIGURE_EN : std_logic;
   signal ADC_EN : std_logic;
   signal IRRI_ACTIVATE : std_logic;
   signal TRANSMIT_EN : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control_Path_Agri_Station PORT MAP (
          clk => clk,
          reset => reset,
					switch => switch,
          ADC_DONE => ADC_DONE,
          IRRI_DONE => IRRI_DONE,
          UART_TX_DONE => UART_TX_DONE,
          CONFIG_DONE => CONFIG_DONE,
          CONFIGURE_EN => CONFIGURE_EN,
          ADC_EN => ADC_EN,
          IRRI_ACTIVATE => IRRI_ACTIVATE,
          TRANSMIT_EN => TRANSMIT_EN
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
				reset <= '1';
				switch <= '0';
				ADC_DONE <=  '0';
				IRRI_DONE <= '0';
				UART_TX_DONE<=  '0';
				CONFIG_DONE <= '0';
      wait for 20 ns;	
				reset <= '0';
				switch <= '1';
				ADC_DONE <=  '0';
				IRRI_DONE <= '0';
				UART_TX_DONE<=  '0';
				CONFIG_DONE <= '1';
      wait for clk_period;
       ADC_DONE <=  '0';
			wait for clk_period;
       ADC_DONE <=  '1';
      wait for clk_period;
       IRRI_DONE <=  '0';
			wait for clk_period;
       IRRI_DONE <=  '1';
		 wait for clk_period;
       UART_TX_DONE <=  '0';
			wait for clk_period;
       UART_TX_DONE <=  '1';

      wait;
   end process;

END;
