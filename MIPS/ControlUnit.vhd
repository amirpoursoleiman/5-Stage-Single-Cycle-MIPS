library ieee;
use ieee.std_logic_1164.all;

entity MyControlUnit is
  Port ( 
    Opcode : in std_logic_vector (5 downto 0);
    RegDst : out std_logic;
    MemRead : out std_logic;
    MemtoReg : out std_logic;
    ALUOp : out std_logic;
    MemWrite : out std_logic;
    ALUSrc : out std_logic;
    RegWrite : out std_logic);
end entity MyControlUnit;

architecture Behavioral of MyControlUnit is
begin

        process (Opcode)
	begin
		case Opcode is
			when "000000" => -- add
				RegDst    <= '1';
				MemRead   <= '0';
				MemtoReg  <= '0';
				ALUOp     <= '1';
				MemWrite  <= '0';
				ALUSrc    <= '0';
				RegWrite  <= '1';
			when "100011" => -- lw
				RegDst    <= '0';
				MemRead   <= '1';
				MemtoReg  <= '1';
				ALUOp     <= '1';
				MemWrite  <= '0';
				ALUSrc    <= '1';
				RegWrite  <= '1';
			when "101011" => -- sw
				RegDst    <= '0';
				MemRead   <= '0';
				MemtoReg  <= '0';
				ALUOp     <= '1';
				MemWrite  <= '1';
				ALUSrc    <= '1';
				RegWrite	 <= '0';
			when others => NULL;
				RegDst    <= '0';
				MemRead   <= '0';
				MemtoReg  <= '0';
				ALUOp     <= '0';
				MemWrite  <= '0';
				ALUSrc    <= '0';
				RegWrite  <= '0';
		end case;
        end process;

end architecture Behavioral;