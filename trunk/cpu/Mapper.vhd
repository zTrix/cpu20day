library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mapper is port(--combinational logic unit
	instruction:in std_logic_vector(15 downto 0);
	op:out integer range 0 to 50
);
end Mapper;

architecture b of Mapper is 
begin
process(instruction)
begin
case instruction(15 downto 11) is  -- 0 NOP | 1~18 two Regs | 19~20 has 3 Regs | 21~34 only Rx | 36 only Ry | 37~43 no regs
	when "00000" => op<=22;				--	ADDSP3
	when "00001" => op<=0;				--	NOP
	when "00010" => op<=43;				--	B
	when "00100" => op<=23;				--	BEQZ
	when "00101" => op<=24;				--	BNEZ
	when "00110" =>
		case instruction (1 downto 0) is
			when "00" => op <= 9;		--	SLL
			when "10" => op <= 15;		--	SRL
			when "11" => op <= 13;		--	SRA
			when others => op <= 0;  -- NOP
		end case;
	when "01000" => op <= 1;			--	ADDIU3
	when "01001" => op <= 21;			--	ADDIU
	when "01010" => op <= 33;			--	SLTI
	when "01011" => op <= 34;			--	SLTUI
	when "01100" =>
		case instruction(10 downto 8) is
			when "000" => op <= 39;		--	BTEQZ
			when "001" => op <= 40;		--	BTNEZ
			when "010" => op <= 38;		--	SW_RS
			when "011" => op <= 37;		--	ADDSP
			when "100" => op <= 36;		--	MTSP
			when others => op <= 0;  -- NOP
		end case;
	when "01101" => op <= 28;			--	LI
	when "01110" => op <= 25;			--	CMPI
	when "01111" => op <= 5;			--	MOVE
	when "10010" => op <= 29;			--	LW_SP
	when "10011" => op <= 4;			--	LW
	when "11010" => op <= 35;			--	SW_SP
	when "11011" => op <= 17;			--	SW
	when "11100" => 
		case instruction(1 downto 0) is
			when "01" => op <= 19;		--	ADDU
			when "11" => op <= 20;		--	SUBU
		when others => op <= 0;  -- NOP
		end case;
	when "11101" => 
		case instruction(4 downto 0) is
			when "00000" =>
				case instruction(7 downto 5) is
					when "001" => op <= 42;	--	JRRA
					when "000" => op <= 27;	--	JR
					when "010" => op <= 31;	--	MFPC
					when "110" => op <= 26;	--	JALR
					when others => op <= 0;  -- NOP
				end case;
			when "00100" => op <= 10;		--	SLLV
			when "00110" => op <= 16;		--	SRLV
			when "00111" => op <= 14;		--	SRAV
			when "00010" => op <= 11;		--	SLT
			when "00011" => op <= 12;		--	SLTU
			when "01010" => op <= 3;		--	CMP
			when "01011" => op <= 6;		--	NEG
			when "01100" => op <= 2;		--	AND
			when "01101" => op <= 8;		--	OR
			when "01110" => op <= 18;		--	XOR
			when "01111" => op <= 7;		--	NOT
			when others => op <= 0;  -- NOP
		end case;
	when "11110" =>
		case instruction(1 downto 0) is
			when "00" => op <= 30;		--	MFIH
			when "01" => op <= 32;		--	MTIH
			when others => op <= 0;  -- NOP
		end case;
	when "11111" =>
		case instruction(10 downto 8) is
			when "000"=> op <= 41;	--	INT
			when "111"=> op <= 44;	-- 44 HALT
			when others=> op <= 0;  -- NOP
		end case;
	when others => 
		op <= 0;	-- NOP
end case;
end process;
end b;
