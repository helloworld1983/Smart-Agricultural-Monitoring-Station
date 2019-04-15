--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:21:30 04/01/2019
-- Design Name:   
-- Module Name:   C:/Users/fudge/Documents/Xilinx Projects/Spartan 3 Projects/Agri_Station24.03.2019/Agri_Station/ADC_Input_TB.vhd
-- Project Name:  Agri_Station
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ADC_Input
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ADC_Input_TB IS
END ADC_Input_TB;
 
ARCHITECTURE behavior OF ADC_Input_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADC_Input
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switch : IN  std_logic;
         ADC_EN : IN  std_logic;
         ADC : IN  std_logic_vector(7 downto 0);
         ADC_DONE : OUT  std_logic;
         ADC_PER : OUT  std_logic_vector(7 downto 0);
         ADC_VAL : OUT  std_logic_vector(31 downto 0);
         ADC_PER_DISP : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switch : std_logic := '0';
   signal ADC_EN : std_logic := '0';
   signal ADC : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal ADC_DONE : std_logic:= '0';
   signal ADC_PER : std_logic_vector(7 downto 0):= (others => '0');
   signal ADC_VAL : std_logic_vector(31 downto 0):= (others => '0');
   signal ADC_PER_DISP : std_logic_vector(31 downto 0):= (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADC_Input PORT MAP (
          clk => clk,
          reset => reset,
          switch => switch,
          ADC_EN => ADC_EN,
          ADC => ADC,
          ADC_DONE => ADC_DONE,
          ADC_PER => ADC_PER,
          ADC_VAL => ADC_VAL,
          ADC_PER_DISP => ADC_PER_DISP
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
				reset<='1';
				switch<='0';
				ADC<=(others=>'0');
				ADC_EN<='0';
      wait for 20 ns;	
				reset<='0';
				switch<='1';
				ADC_EN<='1';
				ADC<="00000001";
      wait for clk_period*2;
				ADC_EN<='0';
			wait for clk_period*2;
				ADC_EN<='1';
				ADC<="10101010";
      wait for clk_period*2;
				ADC_EN<='0';
			wait for clk_period*2;
				ADC_EN<='1';
				ADC<="01010101";
      wait for clk_period*2;
				ADC_EN<='0';
			wait for clk_period*2;
				ADC_EN<='1';
				ADC<="11111111";
      wait for clk_period*2;
				ADC_EN<='0';

      wait;
   end process;

END;
