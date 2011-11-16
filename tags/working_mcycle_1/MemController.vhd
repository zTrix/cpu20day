library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MemController is Port(
	-- inside
	Enable: in std_logic;
	Addr:in std_logic_vector(15 downto 0);
	We:in std_logic;
	DataIn:in std_logic_vector(15 downto 0);
	DataOut:out std_logic_vector(15 downto 0);

	-- outside
	oAddr:out std_logic_vector(15 downto 0);
	oData:inout std_logic_vector(15 downto 0);
	oExAddr:out std_logic_vector(12 downto 0);
	oExData:inout std_logic_vector(15 downto 0);
	oMIO:out std_logic;
	oREQ:out std_logic;
	oWE:out std_logic;
	oExOE:out std_logic;
	oExWE:out std_logic
	);
end MemController;

architecture bhv of MemController is
begin

	oData <= DataIn when (WE = '0' and Enable='0') else (others => 'Z');
	oExData <= DataIn when (WE = '0' and Enable='0') else (others => 'Z');
	DataOut <= 
--					x"0800" when Addr=x"0000" else	-- NOP
--	           "01101"&"000"&"00000101" when Addr=x"0001" else	-- LI R0 05
--				  "01101"&"001"&"00011001" when Addr=x"0002" else	-- LI R1 19
--				  "11100"&"000"&"001"&"010"&"01" when Addr=x"0003" else -- ADDU R0 R1 R2
--				  "11100"&"010"&"001"&"011"&"01" when Addr=x"0004" else -- ADDU R2 R1 R3
--				  "11011"&"101"&"000"&"00000" when Addr=x"0005" else -- SW R5 R0 0
--				  "10011"&"101"&"110"&"00000" when Addr=x"0006" else -- LW R5 R6 0
--				  "11100"&"101"&"110"&"111"&"01" when Addr=x"0007" else -- ADDU R5 R6 R7
--				  "11101"&"000"&"00000000" when Addr=x"0008" else -- JR R0
--				  --"00010"&"00000000011" when Addr=x"0008" else -- B 03
--				  "11100"&"000"&"110"&"111"&"01" when Addr=x"0009" else -- ADDU R0 R6 R7				  
--				  "11100"&"001"&"110"&"111"&"01" when Addr=x"000a" else -- ADDU R1 R6 R7				  
--				  --x"0800";
				  oExData when (Addr(15 downto 13)="010") else 
				  oData;
	
	oMIO <= '1' when (addr(15 downto 13) = "010" or enable='1') else '0';
	oEXWE <= WE when enable='0' else '1';
	oWE <= WE when enable='0' else '1';
	oEXOE <= not WE when enable='0' else '1';
	oREQ <= '1' when addr(15 downto 13) = "011" and enable='0' else '0';
	oEXAddr <= addr(12 downto 0);
	oAddr <= x"0080" when addr = x"6000" else
				x"0081" when addr = x"6001" else
				x"0090" when addr = x"6002" else
				x"0091" when addr = x"6003" else
				addr;
				
end bhv;
