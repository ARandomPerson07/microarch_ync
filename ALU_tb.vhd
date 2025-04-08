----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2025 06:36:15 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is
    component ALU is 
        Port (
            clk : in std_logic;
            rst :in std_logic;
            ALUOp : in std_logic_vector(2 downto 0);
            operator1 : in std_logic_vector(31 downto 0);
            operator2 : in std_logic_vector(31 downto 0);
            result : out std_logic_vector(31 downto 0)
            );
     end component;
     
    signal tb_clk       : std_logic := '0';
    signal tb_rst       : std_logic := '1';
    signal tb_ALUOp     : std_logic_vector(2 downto 0) := "000";
    signal tb_operator1 : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal tb_operator2 : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal tb_result    : std_logic_vector(31 downto 0);

    constant CLK_PERIOD : time := 10ns;
begin

DUT : ALU port map (
                    clk => tb_clk,
                    rst => tb_rst,
                    ALUOp => tb_ALUOp,
                    operator1 => tb_operator1,
                    operator2 => tb_operator2,
                    result => tb_result
                    );

clk_proc: process
begin
    tb_clk <= '0';
    wait for CLK_PERIOD/2;
    tb_clk <= '1';
    wait for CLK_PERIOD/2;
end process;

tb_proc: process

begin
    tb_rst <= '1';
    wait for 20 ns;
    tb_rst <= '0';
    wait until rising_edge(tb_clk);
-- Addition Test
    tb_ALUOp <= "000"; 
    tb_operator1 <= "00000000000000000000000000010100";  -- 20
    tb_operator2 <= "00000000000000000000000000001010";  -- 10
    wait until rising_edge(tb_clk);
    assert(signed(tb_result) = 30) report "Addition test failed" severity error;
    
   -- Subtraction Test
    tb_ALUOp <= "001"; 
    tb_operator1 <= "00000000000000000000000000010100";  -- 20 
    tb_operator2 <= "00000000000000000000000000001010";  -- 10
    wait until rising_edge(tb_clk);
    assert(signed(tb_result) = 10) report "Subtraction test failed" severity error;
    
    -- Multiplication Test
    tb_ALUOp <= "010"; 
    tb_operator1 <= "00000000000000000000000000010100";  -- 20 
    tb_operator2 <= "00000000000000000000000000001010";  -- 10
    wait until rising_edge(tb_clk);
    assert(signed(tb_result) = 200) report "Multiplication test failed" severity error;
    
    -- Division Test
    tb_ALUOp <= "011"; 
    tb_operator1 <= "00000000000000000000000000010100";  -- 20 
    tb_operator2 <= "00000000000000000000000000001010";  -- 10
    wait until rising_edge(tb_clk);
    assert(signed(tb_result) = 2) report "Division test failed" severity error;
            
    wait;
end process tb_proc;
end Behavioral;
