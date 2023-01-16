----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:19:56 01/14/2021 
-- Design Name: 
-- Module Name:    Satallite - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Satallite is
port (Input: in std_logic_vector(511 downto 0);
Output : out std_logic_vector(511 downto 0)
);
end Satallite;

architecture Behavioral of Satallite is
component Compression_Chip is 
port (  inputs:in std_logic_vector(511 downto 0);
			outputf:out std_logic_vector(511 downto 0)
			);
end component;
component DecompressionLoop is
port(pause: in std_logic;
Input : in STD_LOGIC_VECTOR(511 downto 0);
Output : out STD_LOGIC_VECTOR(511 downto 0)
);
end component;
shared Variable ComptoDecomp :std_logic_vector(511 downto 0 );

 

begin
 Com : Compression_Chip port map(Input,ComptoDecomp);
 DCom: DecompressionLoop port map('0',ComptoDecomp,Output);


end Behavioral;

