library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity E is Port ( 
	clk : in std_logic;
	i_instruction : in  STD_LOGIC_VECTOR (15 downto 0);
	o_instruction : out  STD_LOGIC_VECTOR (15 downto 0);
	i1 : in  STD_LOGIC_VECTOR (15 downto 0);
	i2 : in  STD_LOGIC_VECTOR (15 downto 0);
	oAddr : out  STD_LOGIC_VECTOR (15 downto 0);
	oData : out  STD_LOGIC_VECTOR (15 downto 0));
end E;

architecture Behavioral of E is
constant NOP:std_logic_vector(15 downto 0):=x"0800";
constant NOVALUE:std_logic_vector(15 downto 0):="1001011010100101";

constant ALU_ADD :std_logic_vector(3 downto 0):="0000";
constant ALU_SUB :std_logic_vector(3 downto 0):="0001";
constant ALU_AND :std_logic_vector(3 downto 0):="0010";
constant ALU_OR  :std_logic_vector(3 downto 0):="0011";
constant ALU_XOR :std_logic_vector(3 downto 0):="0100";
constant ALU_NOT :std_logic_vector(3 downto 0):="0101";
constant ALU_SLL :std_logic_vector(3 downto 0):="0110";
constant ALU_SLA :std_logic_vector(3 downto 0):="0111";
constant ALU_ROL :std_logic_vector(3 downto 0):="1000";
constant ALU_EQ  :std_logic_vector(3 downto 0):="1001";
constant ALU_LT  :std_logic_vector(3 downto 0):="1010";
constant ALU_LTU :std_logic_vector(3 downto 0):="1011";
constant ALU_SRA :std_logic_vector(3 downto 0):="1100";
constant ALU_SRL :std_logic_vector(3 downto 0):="1101";

signal op_link:integer range 0 to 50;
signal alu_y:std_logic_vector(15 downto 0);
signal alu_op:std_logic_vector(3 downto 0);
signal alu_in1,alu_in2:std_logic_vector(15 downto 0);
signal alu_cin,alu_c,alu_z:std_logic;

component Mapper is port(
	instruction:in std_logic_vector(15 downto 0);
	op:out integer range 0 to 50
);
end component;

component ALU is port(
	op:in STD_LOGIC_VECTOR(3 downto 0);
	A :in STD_LOGIC_VECTOR(15 downto 0);
	B :in STD_LOGIC_VECTOR(15 downto 0);
	cin:in STD_LOGIC;
	Y :out STD_LOGIC_VECTOR(15 downto 0);
	C :out STD_LOGIC;
	Z :out STD_LOGIC
);
end component;

begin
mapper_inst: Mapper port map(i_instruction,op_link);
alu_inst:ALU port map(alu_op,alu_in1,alu_in2,alu_cin,alu_y,alu_c,alu_z);

alu_cin<='0';

process(i1,i2,i_instruction)
begin
case op_link is
	when 2| 3 |8 |11 |12  |18 |19  |20=>
	-- AND|CMP|OR|SLT|SLTU|XOR|ADDU|SUBU
		alu_in1<=i1;
		alu_in2<=i2;
		case op_link is
			when 2=>		--AND
				alu_op<=ALU_AND;
			when 3=>		--CMP
				alu_op<=ALU_EQ;
			when 8=>		--OR
				alu_op<=ALU_OR;
			when 11=>	--SLT
				alu_op<=ALU_LT;
			when 12=>	--SLTU
				alu_op<=ALU_LTU;
			when 18=>
				alu_op<=ALU_XOR;
			when 19=>
				alu_op<=ALU_ADD;
			when 20=>
				alu_op<=ALU_SUB;
			when others=>NULL;
		end case;

	when 1=>		--ADDIU3
		alu_op<=ALU_ADD;
		alu_in1<=i1;
		if i_instruction(3)='1' then
			alu_in2<=x"fff"&i_instruction(3 downto 0);
		else 
			alu_in2<=x"000"&i_instruction(3 downto 0);
		end if;
	when 4=>		--LW
		alu_op<=ALU_ADD;
		alu_in1<=i1;
		alu_in2<=x"00"&"000"&i_instruction(4 downto 0);
	when 6=>		--NEG
		alu_op<=ALU_SUB;
		alu_in1<=(others=>'0');
		alu_in2<=i2;
	when 7=>		--NOT
		alu_op<=ALU_NOT;
		alu_in1<=i2;
	when 9=>	--SLL
		alu_op<=ALU_SLL;
		alu_in1<=i2;
		if i_instruction(4 downto 2)="000" then
			alu_in2<=x"0008";
		else 
			alu_in2<=x"000"&'0'&i_instruction(4 downto 2);
		end if;
	when 13=>	--SRA
		alu_op<=ALU_SRA;
		alu_in1<=i2;
		if i_instruction(4 downto 2)="000" then
			alu_in2<=x"0008";
		else 
			alu_in2<=x"000"&'0'&i_instruction(4 downto 2);
		end if;
	when 10=>	--SLLV
		alu_op<=ALU_SLL;
		alu_in1<=i2;
		alu_in2<=i1;
	when 14=>	--SRAV
		alu_op<=ALU_SRA;
		alu_in1<=i2;
		alu_in2<=i1;
	when 15=>	--SRL
		alu_op<=ALU_SRL;
		alu_in1<=i2;
		if i_instruction(4 downto 2)="000" then
			alu_in2<=x"0008";
		else 
			alu_in2<=x"000"&'0'&i_instruction(4 downto 2);
		end if;
	when 16=>	--SRLV
		alu_op<=ALU_SRL;
		alu_in1<=i2;
		alu_in2<=i1;
	when 17=>	--SW
		alu_op<=ALU_ADD;
		alu_in1<=i1;
		alu_in2<=x"00"&"000"&i_instruction(4 downto 0);
	when 21|22|37|39|40=>	--ADDIU|ADDSP3|ADDSP|BTEQZ|BTNEZ
		alu_op<=ALU_ADD;
		alu_in1<=i1;
		if (i_instruction(7)='1') then
			alu_in2<=x"ff"&i_instruction(7 downto 0);
		else 
			alu_in2<=x"00"&i_instruction(7 downto 0);
		end if;
	when 23|24=>		--BEQZ|BNEZ
		alu_op<=ALU_ADD;
		alu_in1<=i2;
		if i_instruction(7)='1' then
			alu_in2<=x"11"&i_instruction(7 downto 0);
		else
			alu_in2<=x"00"&i_instruction(7 downto 0);
		end if;
	when 35=>		--SW_SP
		alu_op<=ALU_ADD;
		alu_in1<=i2;
		alu_in2<=x"00"&i_instruction(7 downto 0);
	when 25=>
		alu_op<=ALU_EQ;
		alu_in1<=i1;
		alu_in2<=x"00"&i_instruction(7 downto 0);
	when 28=>	-- LI
		alu_op<=ALU_OR;
		alu_in1<=x"00" & i_instruction(7 downto 0);
		alu_in2<=x"0000";
	when 29|38=>		--LW_SP|SW_RS
		alu_op<=ALU_ADD;
		alu_in1<=i1;
		alu_in2<=x"00"&i_instruction(7 downto 0);
	when 33=>			--SLTI
		alu_op<=ALU_LT;
		alu_in1<=i1;
		if i_instruction(7)='1' then
			alu_in2<=x"ff"&i_instruction(7 downto 0);
		else 
			alu_in2<=x"00"&i_instruction(7 downto 0);
		end if;
	when 34=>			--SLTUI
		alu_op<=ALU_LT;
		alu_in1<=i1;
		alu_in2<=x"00"&i_instruction(7 downto 0);
	when others=>NULL;
end case;

end process;

process(clk, i_instruction)
begin
if rising_edge(clk) then
	o_instruction <= i_instruction;
	case op_link is
		when 0=>		-- no data or addr
		-- NOP
			oData<=NOVALUE;
			oAddr<=NOVALUE;
		when 1   | 2 | 3 | 6 | 7 |8 | 9 |10  |11 |12  |13 |14  |
		-- ADDIU3|AND|CMP|NEG|NOT|OR|SLL|SLLV|SLT|SLTU|SRA|SRAV
		  	 15 |16  |18 |19  |20  |21   |22    |25  |33  |34   |37=>
		--	|SRL|SRLV|XOR|ADDU|SUBU|ADDIU|ADDSP3|CMPI|SLTI|SLTUI|ADDSP
			oData<=alu_y;
			oAddr<=NOVALUE;
		when 4=>						-- addr wihout data
		--  LW|
			oData<=NOVALUE;
			oAddr<=alu_y;
		when 5=>						-- no data or addr, from i2
		-- MOVE
			oData<=i2;
			oAddr<=NOVALUE;
		when 17|38=>					-- data and addr
		--   SW|SW_RS
			oData<=i2;
			oAddr<=alu_y;
		when 23|24=>
		--	BEQZ|BNEZ
			oData<=alu_y;
			oAddr<=i1;
		when 26=>
		--  JALR
			oData<=i1;
			oAddr<=i2;
		when 27| 30 | 31 |32=>
		--   JR|MFIH|MFPC|MTIH
			oData<=i1;
			oAddr<=NOVALUE;
		when 28 =>
		--   LI
			oData<=alu_y;
			oAddr<=NOVALUE;
		when 29=>
		--  LW_SP
			oData<=NOVALUE;
			oAddr<=alu_y;
		when 35=>
		--  SW_SP
			oData<=i1;
			oAddr<=alu_y;
		when 36| 42 |43=>
		-- MTSP|JRRA|B
			oData<=i1;
			oAddr<=NOVALUE;
		when 39  |40=>
		--  BTEQZ|BTNEZ
			oData<=alu_y;
			oAddr<=i2;
		when others=>NULL;
	end case;
end if;
end process;

end Behavioral;

