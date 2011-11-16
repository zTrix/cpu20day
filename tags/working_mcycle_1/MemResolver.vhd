library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MemResolver is
port(
	clk:in std_logic;
	rst:in std_logic;
	
	addr1 : in std_logic_vector(15 downto 0);
	data1_read : out std_logic_vector(15 downto 0);
	data1_stall : out std_logic;
	
	addr2 : in std_logic_vector(15 downto 0);
	data2_write : in std_logic_vector(15 downto 0);
	data2_we : in std_logic;
	data2_use : in std_logic;
	data2_read : out std_logic_vector(15 downto 0);
	
	ram_enable : out std_logic;
	ram_we : out std_logic;
	ram_addr : out std_logic_vector(15 downto 0);
	ram_read : in std_logic_vector(15 downto 0);
	ram_write : out std_logic_vector(15 downto 0)
	
	);
end MemResolver;

architecture Behavioral of MemResolver is

begin

ram_enable <= '0';
				  
data1_read <= ram_read;
data2_read <= ram_read;
data1_stall <= data2_use;

ram_addr <= addr1 when data2_use='0' else
			   addr2 when data2_use='1' else
				(others => 'Z');
ram_we <= data2_we when data2_use='1' else '1';
ram_write <= data2_write;

end Behavioral;

