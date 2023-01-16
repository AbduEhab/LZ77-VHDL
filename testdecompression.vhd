--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:42:34 01/14/2021
-- Design Name:   
-- Module Name:   C:/Users/Mohamed/FinalProject/testdecompression.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DecompressionLoop
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
 
ENTITY testdecompression IS
END testdecompression;
 
ARCHITECTURE behavior OF testdecompression IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DecompressionLoop
    PORT(
         pause : IN  std_logic;
         Input : IN  std_logic_vector(511 downto 0);
         Output : OUT  std_logic_vector(511 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal pause : std_logic := '0';
   signal Input : std_logic_vector(511 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(511 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DecompressionLoop PORT MAP (
          pause => pause,
          Input => Input,
          Output => Output
        );

   -- Clock process definitions
  
 

   -- Stimulus process
   stim_proc: process
   begin		
     pause <= '0';
	  --please input the bits from the compression here 
	  Input <=  "00000011101110000001101001000000110111001111011101111101101101001110110110111011011011101111101101101001110110110111011011011101111101101101001110110110111011011011101111101101101001110110110111011011011101111101101101001110110110111011001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      -- insert stimulus here 

      wait;
   end process;

END;
