--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:42:20 01/14/2021
-- Design Name:   
-- Module Name:   C:/Users/Mohamed/FinalProject/Testcompression.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Compression_Chip
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
 
ENTITY Testcompression IS
END Testcompression;
 
ARCHITECTURE behavior OF Testcompression IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Compression_Chip
    PORT(
         inputs : IN  std_logic_vector(511 downto 0);
         outputf : OUT  std_logic_vector(511 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inputs : std_logic_vector(511 downto 0) := (others => '0');

 	--Outputs
   signal outputf : std_logic_vector(511 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Compression_Chip PORT MAP (
          inputs => inputs,
          outputf => outputf
        );

   -- Clock process definitions
   


   -- Stimulus process
   stim_proc: process
   begin		
	--please input the bits you want to compress Here
	inputs <="01110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111011010010110111001110111";
      wait;
   end process;

END;
