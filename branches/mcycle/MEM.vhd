
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity M is
    Port ( 
	        clk : in  STD_LOGIC;
           
			  i_instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           o_instruction : out  STD_LOGIC_VECTOR (15 downto 0);
			  
			  -- from EXE
			  addr_in : in std_logic_vector(15 downto 0);
			  data_in : in std_logic_vector(15 downto 0);
			  
			  -- to WB
			  data_out : out std_logic_vector(15 downto 0);
           
			  -- ram side
			  addr : out  STD_LOGIC_VECTOR (15 downto 0);
           data_read : in STD_LOGIC_VECTOR (15 downto 0);
           data_write : out  STD_LOGIC_VECTOR (15 downto 0);
			  ram_we : out std_logic;
			  ram_enable : out std_logic
			  );
end M;

architecture Behavioral of M is

constant NOP:std_logic_vector(15 downto 0):=x"0800";
signal op_link:integer range 0 to 50;
signal mem_use:std_logic;

component Mapper is port(
	instruction:in std_logic_vector(15 downto 0);
	op:out integer range 0 to 50
);
end component;
begin

mapper_inst:Mapper port map(i_instruction,op_link);
mem_use <= '1' when op_link=4 or op_link=17 or op_link=29 or op_link=35 or op_link=38 else -- LW|SW|LW_SP|SW_SP|SW_RS
			  '0';

process(addr_in, data_in, mem_use)
begin
	ram_enable <= mem_use;
	addr <= addr_in;
	data_write <= data_in;

	case op_link is
	when 4 | 29 =>	-- read
		ram_we <= '1';
	when 17 | 35 | 38 =>
		ram_we <= '0';
	when others =>
		ram_we <= 'Z';
	end case;

end process;

process(clk, mem_use, addr_in, data_in)
begin
	if rising_edge(clk) then
		o_instruction <= i_instruction;
		if mem_use='1' then
			data_out <= data_read;	-- data from memory
			-- notice that mem_use also contains memory write conditions, but it shouldn't matter
		else
			data_out <= data_in;    -- data from EXE ( just pass through )
		end if;
	end if;
end process;

end Behavioral;

