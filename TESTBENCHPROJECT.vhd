--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:34:38 01/14/2021
-- Design Name:   
-- Module Name:   C:/Users/Mohamed/FinalProject/TESTBENCHPROJECT.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Satallite
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
 
ENTITY TESTBENCHPROJECT IS
END TESTBENCHPROJECT;
 
ARCHITECTURE behavior OF TESTBENCHPROJECT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Satallite
    PORT(
         Input : IN  std_logic_vector(511 downto 0);
         Output : OUT  std_logic_vector(511 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(511 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(511 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Satallite PORT MAP (
          Input => Input,
          Output => Output
        );

   -- Clock process definitions
  

   -- Stimulus process
   stim_proc: process
   begin		
      Input <= "01110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111";
     
      wait;
   end process;

END;
