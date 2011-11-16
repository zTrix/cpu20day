VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL Debug1(15:0)
        SIGNAL Debug2(15:0)
        SIGNAL Debug3(15:0)
        SIGNAL id_o2(15:0)
        SIGNAL XLXN_457(2:0)
        SIGNAL XLXN_458(15:0)
        SIGNAL XLXN_598
        SIGNAL XLXN_610(2:0)
        SIGNAL id_o1(15:0)
        SIGNAL clk
        SIGNAL XLXN_664(15:0)
        SIGNAL XLXN_665(15:0)
        SIGNAL rst
        SIGNAL if_instr(15:0)
        SIGNAL XLXN_692(2:0)
        SIGNAL oExData(15:0)
        SIGNAL oData(15:0)
        SIGNAL oExAddr(12:0)
        SIGNAL oAddr(15:0)
        SIGNAL oEXWE
        SIGNAL oEXOE
        SIGNAL oWE
        SIGNAL oREQ
        SIGNAL oMIO
        SIGNAL XLXN_703
        SIGNAL XLXN_704
        SIGNAL XLXN_705(15:0)
        SIGNAL XLXN_706(15:0)
        SIGNAL XLXN_708(15:0)
        SIGNAL XLXN_709
        SIGNAL XLXN_710
        SIGNAL XLXN_711(15:0)
        SIGNAL XLXN_712(15:0)
        SIGNAL XLXN_713(15:0)
        SIGNAL cur_pc(15:0)
        SIGNAL id_instr(15:0)
        SIGNAL XLXN_716
        SIGNAL XLXN_727(15:0)
        SIGNAL XLXN_728(15:0)
        SIGNAL XLXN_729(15:0)
        SIGNAL XLXN_731(15:0)
        SIGNAL XLXN_732(15:0)
        SIGNAL XLXN_743(15:0)
        SIGNAL int1
        SIGNAL int2
        PORT Output Debug1(15:0)
        PORT Output Debug2(15:0)
        PORT Output Debug3(15:0)
        PORT Input clk
        PORT Input rst
        PORT BiDirectional oExData(15:0)
        PORT BiDirectional oData(15:0)
        PORT Output oExAddr(12:0)
        PORT Output oAddr(15:0)
        PORT Output oEXWE
        PORT Output oEXOE
        PORT Output oWE
        PORT Output oREQ
        PORT Output oMIO
        PORT Input int1
        BEGIN BLOCKDEF MemController
            TIMESTAMP 2010 11 26 13 35 17
            RECTANGLE N 64 -640 368 0 
            LINE N 64 -464 0 -464 
            LINE N 64 -320 0 -320 
            RECTANGLE N 0 -188 64 -164 
            LINE N 64 -176 0 -176 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 368 -608 432 -608 
            LINE N 368 -544 432 -544 
            LINE N 368 -480 432 -480 
            LINE N 368 -416 432 -416 
            LINE N 368 -352 432 -352 
            RECTANGLE N 368 -300 432 -276 
            LINE N 368 -288 432 -288 
            RECTANGLE N 368 -236 432 -212 
            LINE N 368 -224 432 -224 
            RECTANGLE N 368 -172 432 -148 
            LINE N 368 -160 432 -160 
            RECTANGLE N 368 -108 432 -84 
            LINE N 368 -96 432 -96 
            RECTANGLE N 368 -44 432 -20 
            LINE N 368 -32 432 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF DebugOutput
            TIMESTAMP 2010 11 26 13 35 17
            RECTANGLE N 64 -192 320 0 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 320 -172 384 -148 
            LINE N 320 -160 384 -160 
            RECTANGLE N 320 -108 384 -84 
            LINE N 320 -96 384 -96 
            RECTANGLE N 320 -44 384 -20 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF F
            TIMESTAMP 2010 11 26 13 35 17
            RECTANGLE N 0 84 64 108 
            LINE N 64 96 0 96 
            RECTANGLE N 416 84 480 108 
            LINE N 416 96 480 96 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 64 -320 416 128 
        END BLOCKDEF
        BEGIN BLOCKDEF D
            TIMESTAMP 2010 12 2 19 10 58
            LINE N 64 224 0 224 
            LINE N 64 288 0 288 
            LINE N 64 96 0 96 
            RECTANGLE N 464 20 528 44 
            LINE N 464 32 528 32 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 464 -364 528 -340 
            LINE N 464 -352 528 -352 
            RECTANGLE N 464 -284 528 -260 
            LINE N 464 -272 528 -272 
            RECTANGLE N 464 -204 528 -180 
            LINE N 464 -192 528 -192 
            RECTANGLE N 464 -124 528 -100 
            LINE N 464 -112 528 -112 
            RECTANGLE N 464 -44 528 -20 
            LINE N 464 -32 528 -32 
            RECTANGLE N 64 -384 464 448 
        END BLOCKDEF
        BEGIN BLOCKDEF RegFile
            TIMESTAMP 2010 11 26 13 35 17
            RECTANGLE N 64 -448 384 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 384 -428 448 -404 
            LINE N 384 -416 448 -416 
            RECTANGLE N 384 -44 448 -20 
            LINE N 384 -32 448 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF W
            TIMESTAMP 2010 11 26 14 11 1
            RECTANGLE N 0 84 64 108 
            LINE N 64 96 0 96 
            LINE N 416 32 480 32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 416 -172 480 -148 
            LINE N 416 -160 480 -160 
            RECTANGLE N 416 -44 480 -20 
            LINE N 416 -32 480 -32 
            RECTANGLE N 64 -192 416 128 
        END BLOCKDEF
        BEGIN BLOCKDEF M
            TIMESTAMP 2010 11 30 16 17 18
            RECTANGLE N 0 212 64 236 
            LINE N 64 224 0 224 
            RECTANGLE N 0 276 64 300 
            LINE N 64 288 0 288 
            RECTANGLE N 464 212 528 236 
            LINE N 464 224 528 224 
            LINE N 464 32 528 32 
            LINE N 464 96 528 96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 464 -108 528 -84 
            LINE N 464 -96 528 -96 
            RECTANGLE N 464 -44 528 -20 
            LINE N 464 -32 528 -32 
            RECTANGLE N 64 -192 464 320 
        END BLOCKDEF
        BEGIN BLOCKDEF E
            TIMESTAMP 2010 12 10 14 53 57
            RECTANGLE N 64 -256 464 0 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 464 -236 528 -212 
            LINE N 464 -224 528 -224 
            RECTANGLE N 464 -44 528 -20 
            LINE N 464 -32 528 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF MemResolver
            TIMESTAMP 2010 11 26 13 35 17
            RECTANGLE N 64 -512 448 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 448 -480 512 -480 
            LINE N 448 -416 512 -416 
            LINE N 448 -352 512 -352 
            RECTANGLE N 448 -300 512 -276 
            LINE N 448 -288 512 -288 
            RECTANGLE N 448 -236 512 -212 
            LINE N 448 -224 512 -224 
            RECTANGLE N 448 -172 512 -148 
            LINE N 448 -160 512 -160 
            RECTANGLE N 448 -108 512 -84 
            LINE N 448 -96 512 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF DataMux
            TIMESTAMP 2010 11 26 14 10 5
            RECTANGLE N 64 -192 464 0 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 464 -172 528 -148 
            LINE N 464 -160 528 -160 
            RECTANGLE N 464 -44 528 -20 
            LINE N 464 -32 528 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ClkIntProducer
            TIMESTAMP 2010 12 2 19 16 57
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCK XLXI_2 DebugOutput
            PIN input1(15:0) id_instr(15:0)
            PIN input2(15:0) id_o1(15:0)
            PIN input3(15:0) id_o2(15:0)
            PIN output1(15:0) Debug1(15:0)
            PIN output2(15:0) Debug2(15:0)
            PIN output3(15:0) Debug3(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_17 W
            PIN i_instruction(15:0) XLXN_728(15:0)
            PIN i1(15:0) XLXN_732(15:0)
            PIN reg_w XLXN_598
            PIN reg_addr(2:0) XLXN_457(2:0)
            PIN reg_data(15:0) XLXN_458(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_13 RegFile
            PIN clk clk
            PIN rst rst
            PIN w XLXN_598
            PIN r_addr1(2:0) XLXN_610(2:0)
            PIN r_addr2(2:0) XLXN_692(2:0)
            PIN w_addr(2:0) XLXN_457(2:0)
            PIN data_in(15:0) XLXN_458(15:0)
            PIN data_out1(15:0) XLXN_664(15:0)
            PIN data_out2(15:0) XLXN_665(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_23 MemResolver
            PIN clk clk
            PIN rst rst
            PIN data2_we XLXN_709
            PIN data2_use XLXN_710
            PIN addr1(15:0) cur_pc(15:0)
            PIN addr2(15:0) XLXN_711(15:0)
            PIN data2_write(15:0) XLXN_712(15:0)
            PIN ram_read(15:0) XLXN_713(15:0)
            PIN data1_stall XLXN_716
            PIN ram_enable XLXN_703
            PIN ram_we XLXN_704
            PIN data1_read(15:0) XLXN_743(15:0)
            PIN data2_read(15:0) XLXN_708(15:0)
            PIN ram_addr(15:0) XLXN_705(15:0)
            PIN ram_write(15:0) XLXN_706(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_1 MemController
            PIN Enable XLXN_703
            PIN We XLXN_704
            PIN Addr(15:0) XLXN_705(15:0)
            PIN DataIn(15:0) XLXN_706(15:0)
            PIN oData(15:0) oData(15:0)
            PIN oExData(15:0) oExData(15:0)
            PIN oMIO oMIO
            PIN oREQ oREQ
            PIN oWE oWE
            PIN oExOE oEXOE
            PIN oExWE oEXWE
            PIN DataOut(15:0) XLXN_713(15:0)
            PIN oAddr(15:0) oAddr(15:0)
            PIN oExAddr(12:0) oExAddr(12:0)
        END BLOCK
        BEGIN BLOCK XLXI_22 E
            PIN i_instruction(15:0) id_instr(15:0)
            PIN i1(15:0) id_o1(15:0)
            PIN i2(15:0) id_o2(15:0)
            PIN o_instruction(15:0) XLXN_727(15:0)
            PIN oData(15:0) XLXN_729(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_20 M
            PIN i_instruction(15:0) id_instr(15:0)
            PIN addr_in(15:0) id_o1(15:0)
            PIN data_in(15:0) id_o2(15:0)
            PIN data_read(15:0) XLXN_708(15:0)
            PIN ram_we XLXN_709
            PIN ram_enable XLXN_710
            PIN data_out(15:0) XLXN_731(15:0)
            PIN addr(15:0) XLXN_711(15:0)
            PIN data_write(15:0) XLXN_712(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_26 DataMux
            PIN i_instruction(15:0) XLXN_727(15:0)
            PIN exe_data(15:0) XLXN_729(15:0)
            PIN mem_data(15:0) XLXN_731(15:0)
            PIN o_instruction(15:0) XLXN_728(15:0)
            PIN data_out(15:0) XLXN_732(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_9 D
            PIN clk clk
            PIN rst rst
            PIN pc_stall XLXN_716
            PIN i_instruction(15:0) if_instr(15:0)
            PIN regfile_data1(15:0) XLXN_664(15:0)
            PIN regfile_data2(15:0) XLXN_665(15:0)
            PIN o_instruction(15:0) id_instr(15:0)
            PIN regfile_addr1(2:0) XLXN_610(2:0)
            PIN regfile_addr2(2:0) XLXN_692(2:0)
            PIN o1(15:0) id_o1(15:0)
            PIN o2(15:0) id_o2(15:0)
            PIN pc_out(15:0) cur_pc(15:0)
            PIN int1 int1
            PIN int2 int2
        END BLOCK
        BEGIN BLOCK XLXI_6 F
            PIN clk clk
            PIN rst rst
            PIN stall XLXN_716
            PIN i_instruction(15:0) XLXN_743(15:0)
            PIN o_instruction(15:0) if_instr(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_27 ClkIntProducer
            PIN rst rst
            PIN clk clk
            PIN oclk int2
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 5440 3520
        BEGIN BRANCH Debug1(15:0)
            WIRE 5136 112 5200 112
        END BRANCH
        BEGIN BRANCH Debug2(15:0)
            WIRE 5136 176 5200 176
        END BRANCH
        BEGIN BRANCH Debug3(15:0)
            WIRE 5136 240 5200 240
        END BRANCH
        BEGIN INSTANCE XLXI_2 4752 272 R0
        END INSTANCE
        IOMARKER 5200 112 Debug1(15:0) R0 28
        IOMARKER 5200 176 Debug2(15:0) R0 28
        IOMARKER 5200 240 Debug3(15:0) R0 28
        BEGIN BRANCH XLXN_598
            WIRE 1776 1888 4928 1888
            WIRE 4880 976 4928 976
            WIRE 4928 976 4928 1888
        END BRANCH
        BEGIN BRANCH clk
            WIRE 1776 1760 1808 1760
            BEGIN DISPLAY 1808 1760 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_665(15:0)
            WIRE 1280 1184 1312 1184
            WIRE 1280 1184 1280 2144
            WIRE 1280 2144 1328 2144
        END BRANCH
        BEGIN INSTANCE XLXI_13 1776 2176 M0
        END INSTANCE
        BEGIN BRANCH XLXN_610(2:0)
            WIRE 1776 1952 1856 1952
            WIRE 1840 944 1856 944
            WIRE 1856 944 1856 1952
        END BRANCH
        BEGIN BRANCH XLXN_457(2:0)
            WIRE 1776 2080 4960 2080
            WIRE 4880 784 4960 784
            WIRE 4960 784 4960 2080
        END BRANCH
        BEGIN BRANCH XLXN_458(15:0)
            WIRE 1776 2144 4944 2144
            WIRE 4880 912 4944 912
            WIRE 4944 912 4944 2144
        END BRANCH
        BEGIN BRANCH rst
            WIRE 1776 1824 1808 1824
            BEGIN DISPLAY 1808 1824 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH id_instr(15:0)
            WIRE 4656 112 4752 112
            BEGIN DISPLAY 4656 112 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH id_o1(15:0)
            WIRE 4656 176 4752 176
            BEGIN DISPLAY 4656 176 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_692(2:0)
            WIRE 1776 2016 1872 2016
            WIRE 1840 1024 1872 1024
            WIRE 1872 1024 1872 2016
        END BRANCH
        BEGIN BRANCH oExData(15:0)
            WIRE 5088 3216 5136 3216
        END BRANCH
        BEGIN BRANCH oData(15:0)
            WIRE 5088 3152 5136 3152
        END BRANCH
        BEGIN BRANCH oExAddr(12:0)
            WIRE 5088 3088 5136 3088
        END BRANCH
        BEGIN BRANCH oAddr(15:0)
            WIRE 5088 3024 5136 3024
        END BRANCH
        BEGIN BRANCH oEXWE
            WIRE 5088 2896 5136 2896
        END BRANCH
        BEGIN BRANCH oEXOE
            WIRE 5088 2832 5136 2832
        END BRANCH
        BEGIN BRANCH oWE
            WIRE 5088 2768 5136 2768
        END BRANCH
        BEGIN BRANCH oREQ
            WIRE 5088 2704 5136 2704
        END BRANCH
        BEGIN BRANCH oMIO
            WIRE 5088 2640 5136 2640
        END BRANCH
        BEGIN INSTANCE XLXI_1 4656 3248 R0
        END INSTANCE
        IOMARKER 5136 2640 oMIO R0 28
        IOMARKER 5136 2704 oREQ R0 28
        IOMARKER 5136 2768 oWE R0 28
        IOMARKER 5136 2832 oEXOE R0 28
        IOMARKER 5136 2896 oEXWE R0 28
        IOMARKER 5136 3024 oAddr(15:0) R0 28
        IOMARKER 5136 3088 oExAddr(12:0) R0 28
        IOMARKER 5136 3152 oData(15:0) R0 28
        IOMARKER 5136 3216 oExData(15:0) R0 28
        BEGIN INSTANCE XLXI_23 3536 3264 R0
        END INSTANCE
        BEGIN BRANCH XLXN_703
            WIRE 4048 2848 4352 2848
            WIRE 4352 2784 4352 2848
            WIRE 4352 2784 4656 2784
        END BRANCH
        BEGIN BRANCH XLXN_704
            WIRE 4048 2912 4352 2912
            WIRE 4352 2912 4352 2928
            WIRE 4352 2928 4656 2928
        END BRANCH
        BEGIN BRANCH XLXN_705(15:0)
            WIRE 4048 3104 4352 3104
            WIRE 4352 3072 4352 3104
            WIRE 4352 3072 4656 3072
        END BRANCH
        BEGIN BRANCH XLXN_706(15:0)
            WIRE 4048 3168 4352 3168
            WIRE 4352 3168 4352 3216
            WIRE 4352 3216 4656 3216
        END BRANCH
        BEGIN BRANCH XLXN_708(15:0)
            WIRE 2512 1200 2592 1200
            WIRE 2512 1200 2512 3328
            WIRE 2512 3328 4064 3328
            WIRE 4048 3040 4064 3040
            WIRE 4064 3040 4064 3328
        END BRANCH
        BEGIN BRANCH XLXN_709
            WIRE 3120 1264 3520 1264
            WIRE 3520 1264 3520 2912
            WIRE 3520 2912 3536 2912
        END BRANCH
        BEGIN BRANCH XLXN_711(15:0)
            WIRE 3120 1136 3296 1136
            WIRE 3296 1136 3296 3104
            WIRE 3296 3104 3536 3104
        END BRANCH
        BEGIN BRANCH XLXN_712(15:0)
            WIRE 3120 1200 3280 1200
            WIRE 3280 1200 3280 3168
            WIRE 3280 3168 3536 3168
        END BRANCH
        BEGIN BRANCH XLXN_713(15:0)
            WIRE 3456 3232 3536 3232
            WIRE 3456 3232 3456 3360
            WIRE 3456 3360 5120 3360
            WIRE 5088 2960 5120 2960
            WIRE 5120 2960 5120 3360
        END BRANCH
        BEGIN BRANCH id_o2(15:0)
            WIRE 4656 240 4752 240
            BEGIN DISPLAY 4656 240 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_22 2592 768 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_20 2592 1232 R0
        END INSTANCE
        BEGIN BRANCH XLXN_710
            WIRE 3120 1328 3312 1328
            WIRE 3312 1328 3312 2976
            WIRE 3312 2976 3536 2976
        END BRANCH
        BEGIN INSTANCE XLXI_26 3456 1072 R0
        END INSTANCE
        BEGIN BRANCH XLXN_727(15:0)
            WIRE 3120 544 3280 544
            WIRE 3280 544 3280 912
            WIRE 3280 912 3456 912
        END BRANCH
        BEGIN BRANCH XLXN_728(15:0)
            WIRE 3984 912 4400 912
        END BRANCH
        BEGIN BRANCH XLXN_729(15:0)
            WIRE 3120 736 3264 736
            WIRE 3264 736 3264 976
            WIRE 3264 976 3456 976
        END BRANCH
        BEGIN BRANCH XLXN_731(15:0)
            WIRE 3120 1456 3264 1456
            WIRE 3264 1040 3264 1456
            WIRE 3264 1040 3456 1040
        END BRANCH
        BEGIN BRANCH XLXN_732(15:0)
            WIRE 3984 1040 4400 1040
        END BRANCH
        BEGIN INSTANCE XLXI_17 4400 944 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 224 928 336 928
        END BRANCH
        BEGIN BRANCH rst
            WIRE 224 992 336 992
        END BRANCH
        BEGIN INSTANCE XLXI_6 336 1216 R0
        END INSTANCE
        IOMARKER 224 992 rst R180 28
        BEGIN BRANCH XLXN_743(15:0)
            WIRE 272 1312 336 1312
            WIRE 272 1312 272 1568
            WIRE 272 1568 4176 1568
            WIRE 4176 1568 4176 2976
            WIRE 4048 2976 4176 2976
        END BRANCH
        BEGIN BRANCH clk
            WIRE 1280 864 1312 864
            BEGIN DISPLAY 1280 864 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rst
            WIRE 1280 928 1312 928
            BEGIN DISPLAY 1280 928 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH int1
            WIRE 240 736 1296 736
            WIRE 1296 736 1296 1440
            WIRE 1296 1440 1312 1440
        END BRANCH
        IOMARKER 224 928 clk R180 28
        BEGIN BRANCH cur_pc(15:0)
            WIRE 1840 1248 2576 1248
            WIRE 2576 1248 2576 3040
            WIRE 2576 3040 3536 3040
        END BRANCH
        BEGIN BRANCH id_o2(15:0)
            WIRE 1840 1184 2016 1184
            WIRE 2016 1184 2016 1280
            WIRE 2016 1280 2240 1280
            WIRE 2240 1280 2240 1520
            WIRE 2240 1520 2592 1520
            WIRE 2240 736 2592 736
            WIRE 2240 736 2240 1280
        END BRANCH
        BEGIN BRANCH id_o1(15:0)
            WIRE 1840 1104 2032 1104
            WIRE 2032 1104 2032 1200
            WIRE 2032 1200 2224 1200
            WIRE 2224 1200 2224 1456
            WIRE 2224 1456 2592 1456
            WIRE 2224 672 2592 672
            WIRE 2224 672 2224 1200
        END BRANCH
        BEGIN BRANCH id_instr(15:0)
            WIRE 1840 864 2016 864
            WIRE 2016 864 2016 960
            WIRE 2016 960 2208 960
            WIRE 2208 960 2576 960
            WIRE 2576 960 2576 1136
            WIRE 2576 1136 2592 1136
            WIRE 2208 608 2208 960
            WIRE 2208 608 2592 608
        END BRANCH
        BEGIN BRANCH XLXN_716
            WIRE 304 1056 336 1056
            WIRE 304 1056 304 1632
            WIRE 304 1632 1104 1632
            WIRE 1104 1632 4064 1632
            WIRE 4064 1632 4064 2784
            WIRE 1104 1312 1104 1632
            WIRE 1104 1312 1312 1312
            WIRE 4048 2784 4064 2784
        END BRANCH
        BEGIN BRANCH XLXN_664(15:0)
            WIRE 1264 1120 1264 1760
            WIRE 1264 1760 1328 1760
            WIRE 1264 1120 1312 1120
        END BRANCH
        BEGIN BRANCH if_instr(15:0)
            WIRE 816 1312 1056 1312
            WIRE 1056 1056 1056 1312
            WIRE 1056 1056 1312 1056
        END BRANCH
        BEGIN INSTANCE XLXI_9 1312 1216 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 3456 2784 3536 2784
            BEGIN DISPLAY 3456 2784 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rst
            WIRE 3456 2848 3536 2848
            BEGIN DISPLAY 3456 2848 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH int2
            WIRE 720 576 1120 576
            WIRE 1120 576 1120 1504
            WIRE 1120 1504 1312 1504
        END BRANCH
        BEGIN INSTANCE XLXI_27 336 672 R0
        END INSTANCE
        BEGIN BRANCH rst
            WIRE 272 576 336 576
            BEGIN DISPLAY 272 576 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 272 640 336 640
            BEGIN DISPLAY 272 640 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        IOMARKER 240 736 int1 R180 28
    END SHEET
END SCHEMATIC
