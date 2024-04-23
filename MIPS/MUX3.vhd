library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MyMUX3 is
  port (
    readdata : in std_logic_vector(31 downto 0);
    aluresult : in std_logic_vector(31 downto 0);
    selector3 : in std_logic; -- selection, 0 means output 1, 1 means output 2
    MUX3_out : out std_logic_vector(31 downto 0));
end entity MyMUX3;

architecture Behavioral of MyMUX3 is
begin

  process(readdata,aluresult,selector3)
   begin
      if selector3 = '1' then
        MUX3_out <= readdata;
      elsif selector3 = '0' then
        MUX3_out <= aluresult;
      end if;
   end process;

end architecture Behavioral;
