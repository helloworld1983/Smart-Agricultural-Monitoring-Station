--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:25:05 03/31/2019
-- Design Name:   
-- Module Name:   C:/Users/fudge/Documents/Xilinx Projects/Spartan 3 Projects/Agri_Station24.03.2019/Agri_Station/Administrative_Correction_TB.vhd
-- Project Name:  Agri_Station
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Administrative_Correction
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
 
ENTITY Administrative_Correction_TB IS
END Administrative_Correction_TB;
 
ARCHITECTURE behavior OF Administrative_Correction_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Administrative_Correction
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switch : IN  std_logic;
         UPPER_THRESH : IN  std_logic_vector(7 downto 0);
         LOWER_THRESH : IN  std_logic_vector(7 downto 0);
         ADC_VAL_PER_IN : IN  std_logic_vector(7 downto 0);
         CONFIG_BITS : IN  std_logic_vector(2 downto 0);
         WARNING_SIGNAL : OUT  std_logic_vector(1 downto 0);
         IRRI_ACTIVATE : IN  std_logic;
         IRRI_DONE : OUT  std_logic;
         EXT_ACTUATE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switch : std_logic := '0';
   signal UPPER_THRESH : std_logic_vector(7 downto 0) := (others => '0');
   signal LOWER_THRESH : std_logic_vector(7 downto 0) := (others => '0');
   signal ADC_VAL_PER_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal CONFIG_BITS : std_logic_vector(2 downto 0) := (others => '0');
   signal IRRI_ACTIVATE : std_logic := '0';

 	--Outputs
   signal WARNING_SIGNAL : std_logic_vector(1 downto 0);
   signal IRRI_DONE : std_logic;
   signal EXT_ACTUATE : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Administrative_Correction PORT MAP (
          clk => clk,
          reset => reset,
          switch => switch,
          UPPER_THRESH => UPPER_THRESH,
          LOWER_THRESH => LOWER_THRESH,
          ADC_VAL_PER_IN => ADC_VAL_PER_IN,
          CONFIG_BITS => CONFIG_BITS,
          WARNING_SIGNAL => WARNING_SIGNAL,
          IRRI_ACTIVATE => IRRI_ACTIVATE,
          IRRI_DONE => IRRI_DONE,
          EXT_ACTUATE => EXT_ACTUATE
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
					switch <=  '0';
					IRRI_ACTIVATE<='0';
					UPPER_THRESH <= "01010000"; --80%
					LOWER_THRESH <= "00101000"; --40%
					ADC_VAL_PER_IN <= "00000000";
					CONFIG_BITS <= "111";
				wait for 10 ns;	
					reset <= '0';
					switch <=  '1';
					
					ADC_VAL_PER_IN <= "00010100"; --20%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
				
      wait for clk_period*4;
					ADC_VAL_PER_IN <= "00011110"; --30%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
					
      wait for clk_period*4;
					ADC_VAL_PER_IN <= "00010100"; --50%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
					
			wait for clk_period*4;
					ADC_VAL_PER_IN <= "00111100";  --60%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
					
			wait for clk_period*4;
					ADC_VAL_PER_IN <= "01000110";  --70%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
					
			wait for clk_period*4;
					ADC_VAL_PER_IN <= "01011010";  --90%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
					
			wait for clk_period*4;
					ADC_VAL_PER_IN <= "01011111";  --95%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
					
					
		  wait for clk_period*4;
					ADC_VAL_PER_IN <= "00000000";  --0%
					IRRI_ACTIVATE<='1';
			wait for clk_period*4;
					IRRI_ACTIVATE<='0';
					
      -- insert stimulus here 

      wait;
   end process;

END;
