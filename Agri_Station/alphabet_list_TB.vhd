--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:34:24 03/14/2019
-- Design Name:   
-- Module Name:   C:/Users/fudge/Documents/Xilinx Projects/Spartan 3 Projects/Agri_Station/alphabet_list_TB.vhd
-- Project Name:  Agri_Station
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alphabet_list
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
 
ENTITY alphabet_list_TB IS
END alphabet_list_TB;
 
ARCHITECTURE behavior OF alphabet_list_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alphabet_list
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switch : IN  std_logic;
         phone_num : IN  std_logic_vector(55 downto 0);
         soil_tol_pos : IN  std_logic_vector(15 downto 0);
         soil_tol_neg : IN  std_logic_vector(15 downto 0);
         disp_val : OUT  std_logic_vector(31 downto 0);
         disp : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal phone_num : std_logic_vector(55 downto 0) := (others => '0');
   signal soil_tol_pos : std_logic_vector(15 downto 0) := (others => '0');
   signal soil_tol_neg : std_logic_vector(15 downto 0) := (others => '0');

	--BiDirs
   signal switch : std_logic;

 	--Outputs
   signal disp_val : std_logic_vector(31 downto 0);
   signal disp : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alphabet_list PORT MAP (
          clk => clk,
          reset => reset,
          switch => switch,
          phone_num => phone_num,
          soil_tol_pos => soil_tol_pos,
          soil_tol_neg => soil_tol_neg,
          disp_val => disp_val,
          disp => disp
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
      wait for 10ns;
			
			reset <= '0';
			switch <= '1';
      wait for 10ns;

      -- insert stimulus here 

      wait;
   end process;

END;
