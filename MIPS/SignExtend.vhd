library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity MySignExtend is 
  port ( 	
    offset : in std_logic_vector(15 downto 0);
    extended : out std_logic_vector(31 downto 0));
end entity MySignExtend;

architecture Behavioral of MySignExtend is
  signal signbit : std_logic;
begin
 extended <= std_logic_vector(resize(signed(offset), 32));
end architecture Behavioral;


