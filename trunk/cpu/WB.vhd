library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity W is
    Port ( 
			  i_instruction : in  STD_LOGIC_VECTOR (15 downto 0);
			  i1 : in std_logic_vector(15 downto 0);
			  
           reg_addr : out  STD_LOGIC_VECTOR (2 downto 0);
           reg_data : out  STD_LOGIC_VECTOR (15 downto 0);
			  reg_w : out std_logic
			  );
end W;

architecture Behavioral of W is

constant NOP:std_logic_vector(15 downto 0):=x"0800";
signal op_link:integer range 0 to 50;
signal write_reg:std_logic;
component Mapper is port(
	instruction:in std_logic_vector(15 downto 0);
	op:out integer range 0 to 50
);
end component;
begin
mapper_inst:Mapper port map(i_instruction,op_link);

process(op_link, i_instruction)
begin
case op_link is
when 21 | 22 | 2 | 28 | 29 | 30 | 31 | 5 | 32 | 6 | 7 | 8 | 9 | 13 | 15  | 18 =>
	reg_addr <= i_instruction(10 downto 8); -- Rx
	write_reg <= '1';
when 1 | 4 | 10 | 14 | 16 =>
	reg_addr <= i_instruction(7 downto 5); -- Ry
	write_reg <= '1';
when 19 | 20 =>
	reg_addr <= i_instruction(4 downto 2); -- Rz
	write_reg <= '1';
--when 36 | 37 =>
--	-- SP
--	write_reg <= '0';
--when 23 | 24 | 39 | 40 | 27 | 42 | 43 =>
--	-- PC
--	write_reg <= '0';
--when 3 | 25 | 11 | 12 | 34 =>
--	-- T
--	write_reg <= '0';
--when 26 =>
--	-- PC + RA
--	write_reg <= '0';
when others => 
	reg_addr <= "000";
	write_reg <= '0';
end case;
end process;

reg_w <= write_reg;
reg_data <= i1;

end Behavioral;

