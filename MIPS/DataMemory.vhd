library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use ieee.STD_LOGIC_UNSIGNED.ALL;

entity MyDataMemory is
  port (
    CLK : in std_logic;
    Address : in std_logic_vector(31 downto 0);
    WriteData : in std_logic_vector(31 downto 0);
    MemRead : in std_logic;
    MemWrite : in std_logic;
    ReadData : out std_logic_vector(31 downto 0));

end entity MyDataMemory;

architecture Behavioral of MyDataMemory is
  type memoryarray is array (0 to 31) of std_logic_vector(31 downto 0);
  signal dataMemory : memoryarray :=
    ("00000000000000000000000000000001", -- 0
     "00000000000000000000000000000001", -- 1
     "00000000000000000000000000000000", -- 2
     "00000000000000000000000000000000", -- 3
     "00000000000000000000000000000000", -- 4
     "00000000000000000000000000000000", -- 5
     "00000000000000000000000000000000", -- 6
     "00000000000000000000000000000000", -- 7
     "00000000000000000000000000000000", -- 8
     "00000000000000000000000000000000", -- 9
     "00000000000000000000000000000000", -- 10
     "00000000000000000000000000000000", -- 11
     "00000000000000000000000000000000", -- 12
     "00000000000000000000000000000000", -- 13
     "00000000000000000000000000000000", -- 14
     "00000000000000000000000000000000", -- 15
     "00000000000000000000000000000000", -- 16
     "00000000000000000000000000000000", -- 17
     "00000000000000000000000000000000", -- 18
     "00000000000000000000000000000000", -- 19
     "00000000000000000000000000000000", -- 20
     "00000000000000000000000000000000", -- 21
     "00000000000000000000000000000000", -- 22
     "00000000000000000000000000000000", -- 23
     "00000000000000000000000000000000", -- 24
     "00000000000000000000000000000000", -- 25
     "00000000000000000000000000000000", -- 26
     "00000000000000000000000000000000", -- 27
     "00000000000000000000000000000000", -- 28
     "00000000000000000000000000000000", -- 29
     "00000000000000000000000000000000", -- 30
     "00000000000000000000000000000000"); -- 31 

begin

 process(CLK)
 begin
   if(CLK'event) then --   if(falling_edge(CLK)) then
      if(MemWrite = '1') then
         dataMemory(to_integer(unsigned(Address))) <= WriteData;
      end if;
      if(MemRead = '1') then
         ReadData <= dataMemory(to_integer(unsigned(Address)));
      end if;
   end if; 

 end process;

end architecture Behavioral;
