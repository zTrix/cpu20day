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

constant size: integer := 32;
constant high: integer := 5;

type CacheData is array (size-1 downto 0) of std_logic_vector(15 downto 0);
type CacheTag is array (size-1 downto 0) of std_logic_vector(16-high downto 0);

signal cache : CacheData;
signal tag : CacheTag;
signal cindex : integer range 0 to size-1;
signal cLastIndex : integer range 0 to size-1;
signal cacheHit : boolean;

signal lastAddr : std_logic_vector(15 downto 0);
signal lastRamWe : std_logic;	-- 1=last operation reads from memory ( cache not hit)
begin
ram_enable <= '0';	-- ram is ENABLED.
				  
data1_read <= ram_read;
data2_read <= cache(cindex) when cacheHit else
					ram_read;
data1_stall <= '0' when data2_we='1' and cacheHit else
				   data2_use;

ram_addr <= addr1 when data2_use='0' or cacheHit else
			   addr2;
ram_we <= '0' when data2_we='0' and data2_use='1' else '1';
ram_write <= data2_write;

cindex <= conv_integer(addr2(high-1 downto 0));
clastIndex <= conv_integer(lastAddr(high-1 downto 0));
cacheHit <= tag(cindex)(16-high)='1' and tag(cindex)(15-high downto 0)=addr2(15 downto high) and addr2(15 downto 13)/="011";
--cacheHit <= false;

process(rst, clk, lastAddr, lastRamWe, data2_write, ram_read)
begin
if rst='1' then
	cache <= (others => (others => '0'));
	lastRamWe <= '0';
elsif rising_edge(clk) then
--	-- last is read
--	if lastRamWe='1' then
--		cache(cLastIndex) <= ram_read;
--		tag(cLastIndex)(15-high downto 0) <= lastAddr(15 downto high);
--		tag(cLastIndex)(16-high) <= '1';
--	end if;
	
	-- write is immediate
	if data2_use='1' and addr2(15 downto 13)/="011" and data2_we='0' then
		cache(cindex) <= data2_write;
		tag(cindex)(15-high downto 0) <= addr2(15 downto high);
		tag(cindex)(16-high) <= '1';		
	end if;
	
	lastAddr <= addr2;
	if data2_we='1' and data2_use='1' and addr2(15 downto 13)/="011" and not cacheHit then
		lastRamWe <= '1';
	else
		lastRamWe <= '0';	
	end if;
end if;
end process;

end Behavioral;

