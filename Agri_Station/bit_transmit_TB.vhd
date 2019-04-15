--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:02:50 03/22/2019
-- Design Name:   
-- Module Name:   C:/Users/fudge/Documents/Xilinx Projects/Spartan 3 Projects/Agri_Station/bit_transmit_TB.vhd
-- Project Name:  Agri_Station
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bit_transmit
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
 
ENTITY bit_transmit_TB IS
END bit_transmit_TB;
 
ARCHITECTURE behavior OF bit_transmit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bit_transmit
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switch : IN  std_logic;
         TX_READY : IN  std_logic;
         TX_MESSAGE : IN  std_logic_vector(9 downto 0);
         TX_DONE : OUT  std_logic;
         tx_line : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switch : std_logic := '0';
   signal TX_READY : std_logic := '0';
   signal TX_MESSAGE : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal TX_DONE : std_logic;
   signal tx_line : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bit_transmit PORT MAP (
          clk => clk,
          reset => reset,
          switch => switch,
          TX_READY => TX_READY,
          TX_MESSAGE => TX_MESSAGE,
          TX_DONE => TX_DONE,
          tx_line => tx_line
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
