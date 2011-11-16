library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D is port(
	clk:in std_logic;
	rst:in std_logic;
	pc_stall: in std_logic;
	int1: in std_logic;
	int2: in std_logic;
	
	i_instruction:in std_logic_vector(15 downto 0);
	o_instruction:out std_logic_vector(15 downto 0);
	regfile_addr1:out std_logic_vector(2 downto 0);
	regfile_addr2:out std_logic_vector(2 downto 0);
	regfile_data1:in std_logic_vector(15 downto 0);
	regfile_data2:in std_logic_vector(15 downto 0);
	o1:out std_logic_vector(15 downto 0);
	o2:out std_logic_vector(15 downto 0);
	
	pc_out:out std_logic_vector(15 downto 0)
	
);
end D;

architecture b of D is

constant NOP:std_logic_vector(15 downto 0):=x"0800";
constant NOVALUE:std_logic_vector(15 downto 0):="1001011010100101";

signal op_link:integer range 0 to 50;
component Mapper is port(
	instruction:in std_logic_vector(15 downto 0);
	op:out integer range 0 to 50
);
end component;

-- instruction to be processed
signal instruction: std_logic_vector(15 downto 0);
-- record last instruction when pc_stalled and instruction is about modifying PC
signal last_instruction: std_logic_vector(15 downto 0);

-- special registers
signal cur_pc: std_logic_vector(15 downto 0);	-- pc of current instruction
signal next_pc: std_logic_vector(15 downto 0);  -- pc sent to mem controller
signal sp: std_logic_vector(15 downto 0);
signal ra: std_logic_vector(15 downto 0);
signal ih: std_logic_vector(15 downto 0);
signal t: std_logic_vector(15 downto 0);

-- for interrupt
signal int_stage: integer range 0 to 7;
signal reopen_int_countdown: integer range 0 to 7;
signal int_num: std_logic_vector(7 downto 0);
signal has_hard_int : std_logic;
signal int_enabled: std_logic;

signal last_int1: std_logic;
signal last_int2: std_logic;

-- shortcuts for immediates in intruction
signal imm8: std_logic_vector(15 downto 0);
signal imm8u: std_logic_vector(15 downto 0);
signal imm11: std_logic_vector(15 downto 0);
signal imm5u: std_logic_vector(15 downto 0);

-- others
signal in_delay_slot: boolean;

begin
mapper_inst:Mapper port map(instruction,op_link);

pc_out <= next_pc;

instruction <= x"F810" when int1='1' and last_int1='0' and int_enabled='1' and not in_delay_slot else		-- hardware int 1
					x"F820" when int2='1' and last_int2='0' and int_enabled='1' and not in_delay_slot else		-- hardware int 2
					x"F8"&int_num when has_hard_int='1' else
					last_instruction when last_instruction /= NOP else
				   i_instruction when int_stage=0 else
					x"F8"&int_num;
					
int_enabled <= '1' when ih(15)='1' and reopen_int_countdown=0 else
					'0';

imm8 <= x"ff" & instruction(7 downto 0) when instruction(7)='1' else
		  x"00" & instruction(7 downto 0);
imm8u  <= x"00" & instruction(7 downto 0);
imm11 <= "11111" & instruction(10 downto 0) when instruction(10)='1' else
		   "00000" & instruction(10 downto 0);
imm5u <= x"00" & "000" & instruction(4 downto 0);

regfile_addr1<=instruction(10 downto 8);
regfile_addr2<=instruction(7 downto 5);

process(clk, rst, op_link, instruction, regfile_data1, regfile_data2) 
begin
if rst='1' then
	o_instruction <= NOP;
	o1<=(others=>'0');
	o2<=(others=>'0');	
elsif rising_edge(clk) then
	
	if int_enabled='0' and op_link=41 and int_stage=0 then	-- invalid int
		o_instruction <= NOP;
	else
		o_instruction <= instruction;
	end if;
	
	case op_link is
	when 2| 3 |8 | 10 |11 | 12 | 14 |16  |18 |19  |20=>
	-- AND|CMP|OR|SLLV|SLT|SLTU|SRAV|SRLV|XOR|ADDU|SUBU
		o1<=regfile_data1;	-- rx
		o2<=regfile_data2;	-- ty
	
	when 17 =>
	--   SW
		o1 <= regfile_data1 + imm5u;
		o2 <= regfile_data2;
		
	when 1   |21   |25  |27| 32 | 33 |34   =>
	-- ADDIU3|ADDIU|CMPI|JR|MTIH|SLTI|SLTUI
		o1<=regfile_data1;	-- rx
		o2<=NOVALUE;
		
	when 4 =>
	--  LW
		o1 <= regfile_data1 + imm5u;	-- rx + imm5u
		o2 <= NOVALUE;
	
	when 5 | 6 | 7 | 9 |13 |15 |36=>
	-- MOVE|NEG|NOT|SLL|SRA|SRL|MTSP
		o2<=regfile_data2;	-- ry
		o1<=NOVALUE;
		
	-- read SP
	when 22 |37=>
	--ADDSP3|ADDSP
		o1 <= SP;
		o2 <= NOVALUE;
		
	when 29 =>
	-- LW_SP
		o1 <= SP+imm8u;
		o2 <= NOVALUE;
	
	when 35=>
	-- SW_SP
		o1<=SP+imm8u;
		o2<=regfile_data1;
	
	when 23 | 24  | 26=>
	-- BEQZ | BNEZ|JALR
		o1<=regfile_data1;	-- rx
		o2<=cur_PC;
		
	when 30=>
	-- MFIH
		o1<=IH;
		o2<=NOVALUE;
	
	when 31=>
	-- MFPC 
		o1<=cur_PC+x"0001";
		o2<=NOVALUE;
	
	when 38=>
	-- SW_RS
		o1<=SP+imm8u;
		o2<=RA;
		
	when 39 |40=>
	-- BTEQZ|BTNEZ
		o1<=cur_PC;
		o2<=T;
		
	when 41 => 	
	-- INT
		if int_enabled='1' then	-- save pc
		
			o1 <= SP - 1;
			if instruction(7 downto 0) < x"10" then	-- soft
				o2 <= cur_pc + 1;
			else 	-- hard
				o2 <= cur_pc;
			end if;

		elsif int_stage=1 then	-- save int num
			o1 <= SP - 1;
			o2 <= x"00" & int_num;
		end if;
		
	when 42=>		--read RA
	--JRRA
		o1<=RA;
		o2<=NOVALUE;
		
	when others=>
		o1<=NOVALUE;
		o2<=NOVALUE;			
	end case;
end if;
end process;


-- controller process
process(clk, rst, op_link)
begin
if rst='1' then
	sp<=(others=>'0');
	ra<=(others=>'0');
	ih<=(others=>'0');
	t<=(others=>'0');
	
	cur_pc<=(others=>'0');
	next_pc<=(others=>'0');
	
	int_num <= (others => '0');
	reopen_int_countdown <= 0;
	
	last_int1 <= '0';
	last_int2 <= '0';
elsif rising_edge(clk) then
	case op_link is 
	-- T
	when 3 => -- cmp
		if regfile_data1=regfile_data2 then
			t <= x"0000";
		else
			t <= x"0001";
		end if;
	when 25 => -- cmpi
		if regfile_data1=imm8u then
			t <= x"0000";
		else
			t <= x"0001";
		end if;
	when 11 => -- slt
		if regfile_data1<regfile_data2 then
			t <= x"0001";
		else
			t <= x"0000";
		end if;
	when 12 => -- sltu
		if regfile_data1<regfile_data2 then
			t <= x"0001";
		else
			t <= x"0000";
		end if;
	when 33 => -- slti
		if regfile_data1<imm8 then
			t <= x"0001";
		else
			t <= x"0000";
		end if;
	when 34 => -- sltui
		if regfile_data1<imm8u then
			t <= x"0001";
		else
			t <= x"0000";
		end if;
	
	-- SP
	when 37 => -- addsp
		sp <= sp+imm8;
	when 36 => -- mtsp
		sp <= regfile_data2;
	
	-- RA
	when 26 => --jalr
		ra <= cur_pc+x"0001";
	
	-- IH
	when 32 => -- mtih
		ih <= regfile_data1;
		
	-- IH SP
	when 41 => -- int
		if int_enabled='1' or int_stage=1 then
			ih(15) <= '0';
			sp <= sp - 1;
		end if;
	when others => null;
	end case;
	
	-- pc
	if op_link=41 then	-- int
		if int_enabled='1' and int_stage=0 then
			next_pc <= '0' & ih(14 downto 0);
		end if;
		last_instruction <= NOP;
	elsif pc_stall='0' then
		case op_link is
		when 43 => -- b
			next_pc <= next_pc + imm11;
		when 23 => -- beqz
			if regfile_data1=x"0000" then
				next_pc <= next_pc + imm8;
			else
				next_pc <= next_pc + x"0001";
			end if;
		when 24 => -- bnez
			if regfile_data1 /= x"0000" then
				next_pc <= next_pc + imm8;
			else
				next_pc <= next_pc + x"0001";
			end if;
		when 39 => -- bteqz
			if t=x"0000" then
				next_pc <= next_pc + imm8;
			else
				next_pc <= next_pc + x"0001";
			end if;
		when 40 => -- btnez
			if t /= x"0000" then
				next_pc <= next_pc + imm8;
			else
				next_pc <= next_pc + x"0001";
			end if;
		when 27 | 26 => -- jr | jalr
			next_pc <= regfile_data1;
		when 42 => -- jrra
			next_pc <= ra;
		when 41 => -- int
			if int_enabled='1' then
				next_pc <= '0' & ih(14 downto 0);
			end if;
		when others =>
			next_pc <= next_pc + x"0001";
		end case;
		last_instruction <= NOP;
	else
		case op_link is 
		when 43 | 23 | 24 | 39 | 40 | 27 | 26 | 42 =>
			last_instruction <= instruction;
		when others =>
			last_instruction <= NOP;
		end case;
	end if;
	
	-- int stage
	if op_link=41 then
		case int_stage is
		when 0 =>
			if int_enabled='1' then
				int_stage <= 1;
			end if;
		when others =>
			int_stage <= 0;
		end case;
	else
		int_stage <= 0;
	end if;
	
	case op_link is 
	when 43 | 23 | 24 | 39 | 40 | 27 | 26 | 42 =>
		in_delay_slot <= true;
	when others =>
		in_delay_slot <= false;
	end case;
	
	-- hard int && int num
	if int_enabled='1' then
		if int1='1' and last_int1='0' and in_delay_slot then
			has_hard_int <= '1';
			int_num <= x"10";
		elsif int2='1' and last_int2='0' and in_delay_slot then
			has_hard_int <= '1';
			int_num <= x"20";
		else
			has_hard_int <= '0';
			int_num <= instruction(7 downto 0);
		end if;
	else
		has_hard_int <= '0';
		int_num <= (others => '0');
	end if;
	
	-- re-enable int
	if op_link=32 then	-- mtih
		if regfile_data1(15)='1' and ih(15)='0' then	-- re-enable int
			reopen_int_countdown <= 2;
		end if;
	end if;
	if reopen_int_countdown > 0 then
		reopen_int_countdown <= reopen_int_countdown - 1;
	end if;
	
	cur_pc <= next_pc;
	
	last_int1 <= int1;
	last_int2 <= int2;
	
end if;
end process;
end b;
