library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Controller is
    Port ( if_stall_in : in  STD_LOGIC;
           id_stall_in : in  STD_LOGIC;
           exe_stall_in : in  STD_LOGIC;
           mem_stall_in : in  STD_LOGIC;
           wb_stall_in : in  STD_LOGIC;
           if_stall_out : out  STD_LOGIC;
           id_stall_out : out  STD_LOGIC);
end Controller;

architecture Behavioral of Controller is
begin

if_stall_out <= '0';
id_stall_out <= '0';

end Behavioral;

