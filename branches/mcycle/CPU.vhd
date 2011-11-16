--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : sch2vhdl
--  /   /         Filename : CPU.vhf
-- /___/   /\     Timestamp : 11/23/2010 17:04:59
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: D:\Xilinx91i\bin\nt\sch2vhdl.exe -intstyle ise -family spartan2 -flat -suppress -w D:/Projects/xilinx/cpu20day/cpu/CPU.sch CPU.vhf
--Design Name: CPU
--Device: spartan2
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesis and simulted, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity CPU is
   port ( clk     : in    std_logic; 
          rst     : in    std_logic; 
          Debug1  : out   std_logic_vector (15 downto 0); 
          Debug2  : out   std_logic_vector (15 downto 0); 
          Debug3  : out   std_logic_vector (15 downto 0); 
          oAddr   : out   std_logic_vector (15 downto 0); 
          oExAddr : out   std_logic_vector (12 downto 0); 
          oEXOE   : out   std_logic; 
          oEXWE   : out   std_logic; 
          oMIO    : out   std_logic; 
          oREQ    : out   std_logic; 
          oWE     : out   std_logic; 
          oData   : inout std_logic_vector (15 downto 0); 
          oExData : inout std_logic_vector (15 downto 0));
end CPU;

architecture BEHAVIORAL of CPU is
   signal XLXN_59                  : std_logic_vector (15 downto 0);
   signal XLXN_94                  : std_logic_vector (15 downto 0);
   signal XLXN_95                  : std_logic_vector (15 downto 0);
   signal XLXN_100                 : std_logic_vector (15 downto 0);
   signal XLXN_101                 : std_logic_vector (15 downto 0);
   signal XLXN_102                 : std_logic;
   signal XLXN_103                 : std_logic;
   signal XLXI_1_DataIn_openSignal : std_logic_vector (15 downto 0);
   signal XLXI_2_input3_openSignal : std_logic_vector (15 downto 0);
   signal XLXI_6_stall_openSignal  : std_logic;
   signal XLXI_8_switch_openSignal : std_logic;
   signal XLXI_8_WB_PC_openSignal  : std_logic_vector (15 downto 0);
   component MemController
      port ( Enable  : in    std_logic; 
             We      : in    std_logic; 
             Addr    : in    std_logic_vector (15 downto 0); 
             DataIn  : in    std_logic_vector (15 downto 0); 
             oData   : inout std_logic_vector (15 downto 0); 
             oExData : inout std_logic_vector (15 downto 0); 
             oMIO    : out   std_logic; 
             oREQ    : out   std_logic; 
             oWE     : out   std_logic; 
             oExOE   : out   std_logic; 
             oExWE   : out   std_logic; 
             DataOut : out   std_logic_vector (15 downto 0); 
             oAddr   : out   std_logic_vector (15 downto 0); 
             oExAddr : out   std_logic_vector (12 downto 0));
   end component;
   
   component DebugOutput
      port ( input1  : in    std_logic_vector (15 downto 0); 
             input2  : in    std_logic_vector (15 downto 0); 
             input3  : in    std_logic_vector (15 downto 0); 
             output1 : out   std_logic_vector (15 downto 0); 
             output2 : out   std_logic_vector (15 downto 0); 
             output3 : out   std_logic_vector (15 downto 0));
   end component;
   
   component F
      port ( clk         : in    std_logic; 
             rst         : in    std_logic; 
             stall       : in    std_logic; 
             pc          : in    std_logic_vector (15 downto 0); 
             mem_data    : in    std_logic_vector (15 downto 0); 
             mem_w       : out   std_logic; 
             mem_enable  : out   std_logic; 
             pc_next     : out   std_logic_vector (15 downto 0); 
             mem_addr    : out   std_logic_vector (15 downto 0); 
             instruction : out   std_logic_vector (15 downto 0));
   end component;
   
   component PCMux
      port ( switch : in    std_logic; 
             IF_PC  : in    std_logic_vector (15 downto 0); 
             WB_PC  : in    std_logic_vector (15 downto 0); 
             PC     : out   std_logic_vector (15 downto 0); 
             rst    : in    std_logic);
   end component;
   
begin
   XLXI_1 : MemController
      port map (Addr(15 downto 0)=>XLXN_100(15 downto 0),
                DataIn(15 downto 0)=>XLXI_1_DataIn_openSignal(15 downto 0),
                Enable=>XLXN_103,
                We=>XLXN_102,
                DataOut(15 downto 0)=>XLXN_59(15 downto 0),
                oAddr(15 downto 0)=>oAddr(15 downto 0),
                oExAddr(12 downto 0)=>oExAddr(12 downto 0),
                oExOE=>oEXOE,
                oExWE=>oEXWE,
                oMIO=>oMIO,
                oREQ=>oREQ,
                oWE=>oWE,
                oData(15 downto 0)=>oData(15 downto 0),
                oExData(15 downto 0)=>oExData(15 downto 0));
   
   XLXI_2 : DebugOutput
      port map (input1(15 downto 0)=>XLXN_100(15 downto 0),
                input2(15 downto 0)=>XLXN_101(15 downto 0),
                input3(15 downto 0)=>XLXI_2_input3_openSignal(15 downto 0),
                output1(15 downto 0)=>Debug1(15 downto 0),
                output2(15 downto 0)=>Debug2(15 downto 0),
                output3(15 downto 0)=>Debug3(15 downto 0));
   
   XLXI_6 : F
      port map (clk=>clk,
                mem_data(15 downto 0)=>XLXN_59(15 downto 0),
                pc(15 downto 0)=>XLXN_94(15 downto 0),
                rst=>rst,
                stall=>XLXI_6_stall_openSignal,
                instruction(15 downto 0)=>XLXN_101(15 downto 0),
                mem_addr(15 downto 0)=>XLXN_100(15 downto 0),
                mem_enable=>XLXN_103,
                mem_w=>XLXN_102,
                pc_next(15 downto 0)=>XLXN_95(15 downto 0));
   
   XLXI_8 : PCMux
      port map (IF_PC(15 downto 0)=>XLXN_95(15 downto 0),
                rst=>rst,
                switch=>XLXI_8_switch_openSignal,
                WB_PC(15 downto 0)=>XLXI_8_WB_PC_openSignal(15 downto 0),
                PC(15 downto 0)=>XLXN_94(15 downto 0));
   
end BEHAVIORAL;


