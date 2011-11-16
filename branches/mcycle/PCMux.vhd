library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCMux is
    Port ( 
			  rst : in std_logic;
			  IF_PC : in  STD_LOGIC_VECTOR (15 downto 0);
           WB_PC : in  STD_LOGIC_VECTOR (15 downto 0);
           PC : out  STD_LOGIC_VECTOR (15 downto 0);
           switch : in  STD_LOGIC);
end PCMux;

architecture Behavioral of PCMux is
begin

-- PC <= IF_PC when switch = '0' else WB_PC;
PC <= (others => '0') when rst='1' else IF_PC;

end Behavioral;

