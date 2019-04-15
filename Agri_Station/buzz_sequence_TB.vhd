--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:52:55 04/03/2019
-- Design Name:   
-- Module Name:   C:/Users/fudge/Documents/Xilinx Projects/Spartan 3 Projects/Agri_Station24.03.2019/Agri_Station/buzz_sequence_TB.vhd
-- Project Name:  Agri_Station
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: buzz_sequence
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
 
ENTITY buzz_sequence_TB IS
END buzz_sequence_TB;
 
ARCHITECTURE behavior OF buzz_sequence_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT buzz_sequence
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switch : IN  std_logic;
         buzz_event : IN  std_logic;
         buzzer : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switch : std_logic := '0';
   signal buzz_event : std_logic := '0';

 	--Outputs
   signal buzzer : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: buzz_sequence PORT MAP (
          clk => clk,
          reset => reset,
          switch => switch,
          buzz_event => buzz_event,
          buzzer => buzzer
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
				buzz_event<='0';
      wait for 10 ns;	
				reset<='0';
				switch<='1';
				buzz_event<='1';
      wait for clk_period;
				buzz_event<='0';
			wait for clk_period;
				buzz_event<='1';
		
      -- insert stimulus here 

      wait;
   end process;

END;
