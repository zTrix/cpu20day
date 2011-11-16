library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMux is
    Port ( 
			  i_instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           o_instruction : out  STD_LOGIC_VECTOR (15 downto 0);

           exe_data : in  STD_LOGIC_VECTOR (15 downto 0);
           mem_data : in  STD_LOGIC_VECTOR (15 downto 0);
			  
			  data_out : out std_logic_vector(15 downto 0)
			  );
end DataMux;

architecture Behavioral of DataMux is

constant NOP:std_logic_vector(15 downto 0):=x"0800";
constant NOVALUE:std_logic_vector(15 downto 0):="1001011010100101";

signal op_link:integer range 0 to 50;
component Mapper is port(
	instruction:in std_logic_vector(15 downto 0);
	op:out integer range 0 to 50
);
end component;

signal use_mem:std_logic;
begin
mapper_inst:Mapper port map(i_instruction,op_link);
o_instruction <= i_instruction;

use_mem <= '1' when op_link=4 or op_link=29 else --LW LW_SP
			  '0';

data_out <= mem_data when use_mem='1' else
				exe_data;
end Behavioral;
