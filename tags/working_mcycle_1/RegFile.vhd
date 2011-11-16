library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegFile is port(
	clk:in std_logic;
	rst:in std_logic;
	w:in std_logic;
	r_addr1:in std_logic_vector(2 downto 0);
	r_addr2:in std_logic_vector(2 downto 0);
	data_out1:out std_logic_vector(15 downto 0);
	data_out2:out std_logic_vector(15 downto 0);
	w_addr:in std_logic_vector(2 downto 0);
	data_in:in std_logic_vector(15 downto 0)
);
end RegFile;

architecture b of RegFile is
type regs is array (7 downto 0) of std_logic_vector(15 downto 0);
signal data:regs;
begin

data_out1<=data(conv_integer(r_addr1));
data_out2<=data(conv_integer(r_addr2));

process(clk,rst,w_addr,data_in)
begin
if rst='1' then
	data(0) <= x"0ff0";
	data(1) <= x"1001";
	data(2) <= x"2002";
	data(3) <= x"3003";
	data(4) <= x"4004";
	data(5) <= x"2005";
	data(6) <= x"6006";
	data(7) <= x"7007";
	-- data<=(others=>(others=>'0'));
elsif rising_edge(clk)then
	if w='1' then
		data(conv_integer(w_addr))<=data_in;
	end if;
end if;
end process;

end b;

