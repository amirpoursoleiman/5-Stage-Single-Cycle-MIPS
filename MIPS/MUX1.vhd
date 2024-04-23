library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MyMUX1 is
  port (
    rt : in std_logic_vector(20 downto 16);
    rd : in std_logic_vector(15 downto 11);
    selector1 : in std_logic; -- selection, 0 means output 1, 1 means output 2
    MUX1_out : out std_logic_vector(20 downto 16));
end entity MyMUX1;

architecture Behavioral of MyMUX1 is
begin

  process(rt,rd,selector1)
   begin
      if selector1 = '0' then
        MUX1_out <= rt;
      elsif selector1 = '1' then
        MUX1_out <= rd;
      end if;
   end process;

end architecture Behavioral;
