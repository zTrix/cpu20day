----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:11:18 11/23/2010 
-- Design Name: 
-- Module Name:    DebugOutput - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DebugOutput is
    Port ( input1 : in  STD_LOGIC_VECTOR (15 downto 0);
           input2 : in  STD_LOGIC_VECTOR (15 downto 0);
           input3 : in  STD_LOGIC_VECTOR (15 downto 0);
           output1 : out  STD_LOGIC_VECTOR (15 downto 0);
           output2 : out  STD_LOGIC_VECTOR (15 downto 0);
           output3 : out  STD_LOGIC_VECTOR (15 downto 0));
end DebugOutput;

architecture Behavioral of DebugOutput is

begin

output1 <= input1;
output2 <= input2;
output3 <= input3;

end Behavioral;

