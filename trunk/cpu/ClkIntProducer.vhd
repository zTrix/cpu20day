library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClkIntProducer is
    Port ( 
			  rst : in std_logic;
			  clk : in  STD_LOGIC;
           oclk : out  STD_LOGIC);
end ClkIntProducer;

architecture Behavioral of ClkIntProducer is
signal count : integer;
begin

process(rst, clk, count)
begin
	if rst='1' then
		count <= 0;
		oclk <= '0';
	elsif rising_edge(clk) then
		if count=10000 then
			count <= 0;
			oclk <= '1';
		else
			count <= count + 1;
			oclk <= '0';
		end if;
	end if;
end process;

end Behavioral;

