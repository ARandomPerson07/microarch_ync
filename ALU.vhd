-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2025 11:36:41
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
Port (
clk : in std_logic;
rst :in std_logic;
ALUOp : in std_logic_vector(2 downto 0);
operator1 : in std_logic_vector(31 downto 0);
operator2 : in std_logic_vector(31 downto 0);
result : out std_logic_vector(31 downto 0)
);
end entity ALU;

architecture Behavioral of ALU is
    signal tmp_result : std_logic_vector(31 downto 0);
    begin
        process(clk, rst)
        begin
            if rst = '1' then
                tmp_result <= (others => '0');
            elsif rising_edge(clk) then
                case ALUOp is
                    when "000" =>
                        tmp_result <= std_logic_vector(signed(operator1) + signed(operator2));
                    when "001" =>
                        tmp_result <= std_logic_vector(signed(operator1) - signed(operator2));
                    when "010" =>
                        tmp_result <= std_logic_vector(to_unsigned((to_integer(signed(operator1)) * to_integer(signed(operator2))),32)) ;
                    when "011" =>
                        tmp_result <= std_logic_vector(signed(operator1) / signed(operator2));
                    when others =>
                        tmp_result <= (others => '0');
                end case;
            end if;
    end process;
    result <= tmp_result;
end Behavioral;