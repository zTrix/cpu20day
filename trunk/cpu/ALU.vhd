library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is Port (
	op:in STD_LOGIC_VECTOR(3 downto 0);
	A :in STD_LOGIC_VECTOR(15 downto 0);
	B :in STD_LOGIC_VECTOR(15 downto 0);
	cin:in STD_LOGIC;
	Y :out STD_LOGIC_VECTOR(15 downto 0);
	C :out STD_LOGIC;
	Z :out STD_LOGIC
);
end ALU;

architecture b of ALU is
constant full: std_logic_vector(15 downto 0) := "1111111111111111";
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
constant ALU_NOP :std_logic_vector(3 downto 0):="1111";

signal tmp: std_logic_vector(16 downto 0);

begin

y <= tmp(15 downto 0);
c <= tmp(16);
z <= '1' when tmp(15 downto 0)=x"00" else '0';

process(op,cin,A,B)
begin

case op is 
	when ALU_ADD =>  -- 0 add
		tmp <= ("0"&A) + ("0"&B) + cin;
		
	when ALU_SUB =>   -- 1 sub
		tmp(15 downto 0) <= A-B-cin;
		if a<b then
			tmp(16) <= '1';
		else
			tmp(16) <= '0';
		end if;
		
	when ALU_AND =>  -- 2 and
		tmp(15 downto 0) <= a and b;
		tmp(16) <= '0';
	
	when ALU_OR=>  -- 3 or
		tmp(15 downto 0) <= a or b;
		tmp(16) <= '0';
		
	when ALU_XOR=>  -- 4 xor
		tmp(15 downto 0) <= a xor b;
		tmp(16) <= '0';
		
	when ALU_NOT=>  -- 5 not
		tmp(15 downto 0) <= not a;
		tmp(16) <= '0';
		
	when ALU_SLL=>  -- 6 sll
		if b=0 then
			tmp <= "0" & a;
		else
			tmp <= to_stdlogicvector(to_bitvector("0" & a) sll conv_integer(b));
		end if;
		
	when ALU_SLA=>  -- 7 sla
		if b=0 then
			tmp <= "0" & a;
		else
			tmp <= to_stdlogicvector(to_bitvector("0" & a) sll conv_integer(b));
		end if;
		
	when ALU_ROL=>  -- 8 rol
		if b=0 then
			tmp <= "0" & a;
		else
			tmp(15 downto 0) <= to_stdlogicvector(to_bitvector(a) rol conv_integer(b));
			tmp(16) <= '0';
		end if;
	when ALU_EQ=>
		if A=B then
			tmp <= "0" & x"0001";
		else
			tmp <= (others=>'0');
		end if;
	when ALU_LT=>
		if A<B then
			tmp <= "0" & x"0001";
		else
			tmp <= (others=>'0');
		end if;
	when ALU_LTU=>
		if A<B then
			tmp <= "0" & x"0001";
		else
			tmp <= (others=>'0');
		end if;
	when ALU_SRA=>
		tmp <= "0" & to_stdlogicvector(to_bitvector(a) sra conv_integer(b));
	when ALU_SRL=>
		tmp <= "0" & to_stdlogicvector(to_bitvector(a) srl conv_integer(b));
	when others=> 
		tmp <= (others => '0');	
end case;
end process;
end b;
