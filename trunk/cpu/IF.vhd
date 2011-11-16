library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity F is port(
	clk:in std_logic;
	rst:in std_logic;
	stall:in std_logic;
	i_instruction:in std_logic_vector(15 downto 0);
	o_instruction:out std_logic_vector(15 downto 0));
end F;

architecture b of F is
constant NOP:std_logic_vector(15 downto 0):=x"0800";
begin

process(rst, clk, stall)
begin
if rst='1' then
	o_instruction <= NOP;
else
	if rising_edge(clk) then
		if stall='0' then
			o_instruction <= i_instruction;
		else
			o_instruction <= NOP;
		end if;
	end if;
end if;

end process;

end b;

