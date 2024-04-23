library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MyMUX2 is
  port (
    readdata2 : in std_logic_vector(31 downto 0);
    signextend : in std_logic_vector(31 downto 0);
    selector2 : in std_logic; -- selection, 0 means output 1, 1 means output 2
    MUX2_out : out std_logic_vector(31 downto 0));
end entity MyMUX2;

architecture Behavioral of MyMUX2 is
begin

  process(readdata2,signextend,selector2)
   begin
      if selector2 = '0' then
        MUX2_out <= readdata2;
      elsif selector2 = '1' then
        MUX2_out <= signextend;
      end if;
   end process;

end architecture Behavioral;


