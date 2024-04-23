library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MySingleCycleMips is
port (
  CLK : in std_logic);
end MySingleCycleMips;

architecture Behavioral of MySingleCycleMips is
 
component MyPC is
    port (
      CLK : in  std_logic;
      PCin : in  std_logic_vector(31 downto 0);
      PCout : out std_logic_vector(31 downto 0));
end component;

component MyPCAdder is
  port (
    PCAin : in  std_logic_vector(31 downto 0);
    PC4 : out std_logic_vector(31 downto 0));
end component;

component MyInstructionMemory is
  port (
    Address : in std_logic_vector(31 downto 0);
    Instruction : out std_logic_vector(31 downto 0));
end component;

component MyControlUnit is
  Port ( 
    Opcode : in std_logic_vector (5 downto 0);
    RegDst : out std_logic;
    MemRead : out std_logic;
    MemtoReg : out std_logic;
    ALUOp : out std_logic;
    MemWrite : out std_logic;
    ALUSrc : out std_logic;
    RegWrite : out std_logic);
end component;

component MyMUX1 is
  port (
    rt : in std_logic_vector(20 downto 16);
    rd : in std_logic_vector(15 downto 11);
    selector1 : in std_logic; -- selection, 0 means output 1, 1 means output 2
    MUX1_out : out std_logic_vector(20 downto 16));
end component;

component MyMUX2 is
  port (
    readdata2 : in std_logic_vector(31 downto 0);
    signextend : in std_logic_vector(31 downto 0);
    selector2 : in std_logic; -- selection, 0 means output 1, 1 means output 2
    MUX2_out : out std_logic_vector(31 downto 0));
end component;

component MyMUX3 is
  port (
    readdata : in std_logic_vector(31 downto 0);
    aluresult : in std_logic_vector(31 downto 0);
    selector3 : in std_logic; -- selection, 0 means output 1, 1 means output 2
    MUX3_out : out std_logic_vector(31 downto 0));
end component;

component MyRegisterFile is
  port (
    CLK : in std_logic;
    RegWrite : in std_logic;
    ReadRegister1 : in std_logic_vector(25 downto 21);  
    ReadRegister2 : in std_logic_vector(20 downto 16);
    WriteRegister : in std_logic_vector(15 downto 11);
    WriteData : in std_logic_vector(31 downto 0);
    ReadData1 : out std_logic_vector(31 downto 0);
    ReadData2 : out std_logic_vector(31 downto 0));
end component;

component MyALU is
    Port ( 
      ALUInput1 : in std_logic_vector (31 downto 0);
      ALUInput2 : in std_logic_vector (31 downto 0);
      ALUOpperation : in std_logic;
      ALUResult : out std_logic_vector (31 downto 0));
end component;

component MySignExtend is
  port ( 	
    offset : in std_logic_vector(15 downto 0);
    extended : out std_logic_vector(31 downto 0));
end component;

component MyDataMemory is
  port (
    CLK : in std_logic;
    Address : in std_logic_vector(31 downto 0);
    WriteData : in std_logic_vector(31 downto 0);
    MemRead : in std_logic;
    MemWrite : in std_logic;
    ReadData : out std_logic_vector(31 downto 0));
end component;

signal pc_in, pc_out : std_logic_vector(31 downto 0);

signal instruction : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal r_s, r_d, r_t : std_logic_vector(4 downto 0);
signal oppcode : std_logic_vector(5 downto 0);
signal offs : std_logic_vector(15 downto 0);
signal funct : std_logic_vector(5 downto 0);

signal reg_dst, mem_read, mem_to_reg, mem_write, alu_src, reg_write, alu_op : std_logic;

signal muxout1 : std_logic_vector(4 downto 0);
signal muxout2 : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal muxout3 : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

signal read_data1, read_data2, dm_read_data : std_logic_vector(31 downto 0) := (others => '0');

signal extendedoffset : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

signal alu_result : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

begin

oppcode <= instruction(31 downto 26);
r_s <= instruction(25 downto 21);
r_t <= instruction(20 downto 16);
r_d <= instruction(15 downto 11);
funct <= instruction(5 downto 0);
offs <= instruction(15 downto 0);

MPC : MyPC port map (CLK, PCin => pc_in, PCout => pc_out);
MPCA : MyPCAdder port map (PCAin => pc_out, PC4 => pc_in);
MIM : MyInstructionMemory port map (Address => pc_out, Instruction => instruction);
MCU : MyControlUnit port map (Opcode => oppcode, RegDst => reg_dst, MemRead => mem_read, MemtoReg => mem_to_reg, ALUOp => alu_op, MemWrite => mem_write, ALUSrc => alu_src, RegWrite => reg_write);
MUX1 : MyMUX1 port map (rt => r_t, rd => r_d, selector1 => reg_dst, MUX1_out => muxout1);
MUX2 : MyMUX2 port map (readdata2 => read_data2, signextend => extendedoffset, selector2 => alu_src, MUX2_out => muxout2);
MUX3 : MyMUX3 port map (readdata => dm_read_data, aluresult => alu_result, selector3 => mem_to_reg, MUX3_out => muxout3);
MRF : MyRegisterFile port map (CLK, RegWrite => reg_write, ReadRegister1 => r_s, ReadRegister2 => r_t, WriteRegister => muxout1, WriteData => muxout3, ReadData1 => read_data1, ReadData2 => read_data2);
MSE : MySignExtend port map (offset => offs, extended => extendedoffset);
MALU : MyALU port map (ALUInput1 => read_data1, ALUInput2 => muxout2, ALUOpperation => alu_op, ALUResult => alu_result);
MDM : MyDataMemory port map (CLK, Address => alu_result, WriteData => read_data2, MemRead => mem_read, MemWrite => mem_write, ReadData => dm_read_data);

end architecture Behavioral;