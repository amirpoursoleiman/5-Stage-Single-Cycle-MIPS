library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.ALL;

entity MyPCAdder is
  port (
    PCAin : in  std_logic_vector(31 downto 0);
    PC4 : out std_logic_vector(31 downto 0));
end entity MyPCAdder;

architecture Behavioral of MyPCAdder is
begin

  process(PCAin)
  begin
    PC4 <= PCAin + 4;
  end process;

end architecture Behavioral;

