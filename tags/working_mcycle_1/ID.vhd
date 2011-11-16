library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D is port(
	clk:in std_logic;
	rst:in std_logic;
	stall:in std_logic;
	pc_stall: in std_logic;
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

-- special registers
signal cur_pc: std_logic_vector(15 downto 0);	-- pc of current i_instruction
signal next_pc: std_logic_vector(15 downto 0);  -- pc sent to mem controller
signal sp: std_logic_vector(15 downto 0);
signal ra: std_logic_vector(15 downto 0);
signal ih: std_logic_vector(15 downto 0);
signal t: std_logic_vector(15 downto 0);

-- short cuts for immediates in intruction
signal imm8: std_logic_vector(15 downto 0);
signal imm8u: std_logic_vector(15 downto 0);
signal imm4: std_logic_vector(15 downto 0);
signal imm11: std_logic_vector(15 downto 0);
signal imm5u: std_logic_vector(15 downto 0);


signal countdown: integer range 0 to 7;

begin
mapper_inst:Mapper port map(i_instruction,op_link);

pc_out <= next_pc;

imm8 <= x"ff" & i_instruction(7 downto 0) when i_instruction(7)='1' else
		  x"00" & i_instruction(7 downto 0);
imm8u  <= x"00" & i_instruction(7 downto 0);
imm4 <= x"fff" & i_instruction(3 downto 0) when i_instruction(3)='1' else
		  x"000" & i_instruction(3 downto 0);
imm11 <= "11111" & i_instruction(10 downto 0) when i_instruction(10)='1' else
		   "00000" & i_instruction(10 downto 0);
imm5u <= x"00" & "000" & i_instruction(4 downto 0);


-- prepare RegFile 
process(i_instruction) 
begin
	case op_link is
		when 2| 3 |8 | 10 |11 | 12 | 14 |16  |17|18 |19  |20=>
		-- AND|CMP|OR|SLLV|SLT|SLTU|SRAV|SRLV|SW|XOR|ADDU|SUBU
			regfile_addr1<=i_instruction(10 downto 8);
			regfile_addr2<=i_instruction(7 downto 5);
			
		when 1   |4 |21   |25  |27| 32 | 33 |34   |35   |  23 | 24  | 26=>
		-- ADDIU3|LW|ADDIU|CMPI|JR|MTIH|SLTI|SLTUI|SW_SP|BEQZ | BNEZ|JALR
			regfile_addr1<=i_instruction(10 downto 8);

		when 5 | 6 | 7 | 9 |13 |15 |36=>
		-- MOVE|NEG|NOT|SLL|SRA|SRL|MTSP
			regfile_addr2<=i_instruction(7 downto 5);
			
		when others => null;
	end case;
end process;


-- output logic
process(clk,rst)
begin
if rst='1' then
	o_instruction<=NOP;
	o1<=(others=>'0');
	o2<=(others=>'0');	
elsif rising_edge(clk) then
	if stall='0' and countdown=3 then
		o_instruction<=i_instruction;--instruction transfer should be temporal logic
		case op_link is
			-- read rx ry in instruction
			when 2| 3 |8 | 10 |11 | 12 | 14 |16  |17|18 |19  |20=>
			-- AND|CMP|OR|SLLV|SLT|SLTU|SRAV|SRLV|SW|XOR|ADDU|SUBU
				o1<=regfile_data1;
				o2<=regfile_data2;
				
			-- read rx in instruction
			when 1   |4 |21   |25  |27| 32 | 33 |34   =>
			-- ADDIU3|LW|ADDIU|CMPI|JR|MTIH|SLTI|SLTUI
				o1<=regfile_data1;
				o2<=NOVALUE;
			
			-- read ry in instruction
			when 5 | 6 | 7 | 9 |13 |15 |36=>
			-- MOVE|NEG|NOT|SLL|SRA|SRL|MTSP
				o2<=regfile_data2;
				o1<=NOVALUE;
				
			-- read SP
			when 22 |29   |37=>
			--ADDSP3|LW_SP|ADDSP
				o1<=SP;
			
			when 35=> -- read SP rx
			-- SW_SP
				o1<=regfile_data1;
				o2<=SP;
			
			when 23 | 24  | 26=>	-- read rx PC
			-- BEQZ | BNEZ|JALR
				o1<=regfile_data1;
				o2<=cur_PC+x"0001";
				
			when 30=> -- read IH
			-- MFIH
				o1<=IH;
			
			when 31 | 43=> -- read PC
			-- MFPC | B
				o1<=cur_PC+x"0001";
				o2<=NOVALUE;
			
			when 38=>		-- read SP RA
			-- SW_RS
				o1<=SP;
				o2<=RA;
				
			when 39 |40=>	-- read PC T
			-- BTEQZ|BTNEZ
				o1<=cur_PC+x"0001";
				o2<=T;
				
			when 42=>		--read RA
			--JRRA
				o1<=RA;
				o2<=NOVALUE;
				
			when others=>
				o1<=NOVALUE;
				o2<=NOVALUE;			
		end case;
		
	else
		o_instruction<=NOP;
		o1<=(others=>'0');
		o2<=(others=>'0');
	end if;
end if;
end process;

process(clk, stall)
begin
if rst='1' then
	sp<=(others=>'0');
	ra<=(others=>'0');
	ih<=(others=>'0');
	t<=(others=>'0');
	
	cur_pc<=(others=>'0');
	next_pc<=(others=>'0');
	
	countdown <= 0;
elsif rising_edge(clk) then
	if stall='0' and countdown=0 then
		-- T
		case op_link is 
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
		when others => null;
		end case;
		
		-- SP
		case op_link is
		when 37 => -- addsp
			sp <= regfile_data1+imm8;
		when 36 => -- mtsp
			sp <= regfile_data2;
		when others => null;
		end case;
		
		-- RA
		case op_link is
		when 26 => --jalr
			ra <= cur_pc+x"0001";
		when others => null;
		end case;
		
		-- IH
		case op_link is
		when 32 => -- mtih
			ih <= regfile_data1;
		when others => null;
		end case;
		
		-- pc
		countdown <= 4;
		if pc_stall='0' then
			case op_link is
			when 43 => -- b
				next_pc <= next_pc + x"0001" + imm11;
			when 23 => -- beqz
				if regfile_data1=x"0000" then
					next_pc <= next_pc + x"0001"+ imm8;
				else
					next_pc <= next_pc + x"0001";
				end if;
			when 24 => -- bnez
				if regfile_data1 /= x"0000" then
					next_pc <= next_pc + x"0001"+ imm8;
				else
					next_pc <= next_pc + x"0001";
				end if;
			when 39 => -- bteqz
				if t=x"0000" then
					next_pc <= next_pc + x"0001"+ imm8;
				else
					next_pc <= next_pc + x"0001";
				end if;
			when 40 => -- btnez
				if t /= x"0000" then
					next_pc <= next_pc + x"0001"+ imm8;
				else
					next_pc <= next_pc + x"0001";
				end if;
			when 27 | 26 => -- jr | jalr
				next_pc <= regfile_data1;
			when 42 => -- jrra
				next_pc <= ra;
			when others =>
				next_pc <= next_pc + x"0001";
			end case;
		else -- stall for a cycle
			next_pc <= next_pc;
		end if;
	else
		countdown <= countdown - 1;
	end if;
	cur_pc <= next_pc;
end if;
end process;
end b;
