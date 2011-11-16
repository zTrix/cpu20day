library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reg is port(
	clk:in std_logic;
	rst:in std_logic;
	stall:in std_logic;
	w:in std_logic;
	data_in:in std_logic_vector(15 downto 0);
	data_out:out std_logic_vector(15 downto 0);
	user:out std_logic_vector(2 downto 0) --current used by which process(1~5?)
);
end Reg;

architecture b of Reg is
signal data:std_logic_vector(15 downto 0);
begin

data_out<=data;
process(clk,rst)
begin
if rst='1' then
	data<=x"0000";
else
	if rising_edge(clk)then
		if stall='0' then
			if w='1' then
				data<=data_in;
			end if;
		end if;
	end if;
end if;
end process;

end b;
