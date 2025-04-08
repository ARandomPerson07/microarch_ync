----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2025 17:21:46
-- Design Name: 
-- Module Name: tb_control_unit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_control_unit is
--  Port ( );
end tb_control_unit;

architecture Behavioral of tb_control_unit is

component control_unit is
    port (
        opcode      :in std_logic_vector(6 downto 0);
        func3       :in std_logic_vector(2 downto 0);
        func7       :in std_logic_vector(6 downto 0);
        zero        :in std_logic;
        
        PC_Src      :out std_logic; -- whether to be sequential, always 0
        ResultSrc   :out std_logic; -- ALU or Data Memory
        MemWrite    :out std_logic; -- Whether to write to memory
        ALUSrc      :out std_logic; -- what goes into the ALU, register data or Immediate generator
        ALUControl  :out std_logic_vector(2 downto 0); --tells the ALU what to do
        RegWrite    :out std_logic -- whether to write to register
    );
end component;

signal opcode: std_logic_vector(6 downto 0);
signal func3: std_logic_vector(2 downto 0);
signal func7: std_logic_vector(6 downto 0);
signal zero: std_logic;

signal PC_Src: std_logic;
signal ResultSrc: std_logic;
signal MemWrite: std_logic;
signal ALUSrc: std_logic;
signal ALUControl: std_logic_vector(2 downto 0);
signal RegWrite: std_logic;

begin

DUT : control_unit port map (opcode => opcode, func3 => func3,
                             func7 => func7, PC_Src => PC_Src, zero => zero,
                             ResultSrc => ResultSrc, MemWrite => MemWrite,
                             ALUSrc => ALUSrc, ALUControl => ALUControl,
                             RegWrite => RegWrite);
                             
                          

tb_proc : process begin

-- Write Test - ADD
opcode <= "0110011";
func3 <= "000";
func7 <= "0000000";
zero <= '0';
wait for 1 ns;

-- Read Test
assert (PC_Src = '0') report "test 1 fails" severity error;
assert (ResultSrc = '0') report "test 1 fails" severity error;
assert (MemWrite = '0') report "test 1 fails" severity error;
assert (ALUSrc = '0') report "test 1 fails" severity error;
assert (ALUControl = "000") report "test 1 fails" severity error;
assert (RegWrite = '1') report "test 1 fails" severity error;

-- Write Test - MULT
opcode <= "0110011";
func3 <= "000";
func7 <= "0000001";
zero <= '0';
wait for 1 ns;

-- Read Test
assert (PC_Src = '0') report "test 2 fails" severity error;
assert (ResultSrc = '0') report "test 2 fails" severity error;
assert (MemWrite = '0') report "test 2 fails" severity error;
assert (ALUSrc = '0') report "test 2 fails" severity error;
assert (ALUControl = "010") report "test 2 fails" severity error;
assert (RegWrite = '1') report "test 2 fails" severity error;


-- Write Test - ADDI
opcode <= "0010011";
func3 <= "000";
func7 <= "0000000";
zero <= '0';
wait for 1 ns;

-- Read Test
assert (PC_Src = '0') report "test 3 fails" severity error;
assert (ResultSrc = '0') report "test 3 fails" severity error;
assert (MemWrite = '0') report "test 3 fails" severity error;
assert (ALUSrc = '1') report "test 3 fails" severity error;
assert (ALUControl = "000") report "test 3 fails" severity error;
assert (RegWrite = '1') report "test 3 fails" severity error;

-- Write Test - Load
opcode <= "0000011";
func3 <= "000";
func7 <= "0000000";
zero <= '0';
wait for 1 ns;

-- Read Test
assert (PC_Src = '0') report "test 4 fails" severity error;
assert (ResultSrc = '1') report "test 4 fails" severity error;
assert (MemWrite = '0') report "test 4 fails" severity error;
assert (ALUSrc = '1') report "test 4 fails" severity error;
assert (ALUControl = "000") report "test 4 fails" severity error;
assert (RegWrite = '1') report "test 4 fails" severity error;

-- Write Test - Store
opcode <= "0100011";
func3 <= "000";
func7 <= "0000000";
zero <= '0';
wait for 1 ns;

-- Read Test
assert (PC_Src = '0') report "test 5 fails" severity error;
assert (ResultSrc = '0') report "test 5 fails" severity error;
assert (MemWrite = '1') report "test 5 fails" severity error;
assert (ALUSrc = '0') report "test 5 fails" severity error;
assert (ALUControl = "000") report "test 5 fails" severity error;
assert (RegWrite = '0') report "test 5 fails" severity error;

-- Write Test - Jump
opcode <= "1100011";
func3 <= "000";
func7 <= "0000000";
zero <= '0';
wait for 1 ns;

-- Read Test
assert (PC_Src = '1') report "test 6 fails" severity error;
assert (ResultSrc = '0') report "test 6 fails" severity error;
assert (MemWrite = '0') report "test 6 fails" severity error;
assert (ALUSrc = '0') report "test 6 fails" severity error;
assert (ALUControl = "000") report "test 6 fails" severity error;
assert (RegWrite = '0') report "test 6 fails" severity error;

-- Write Test - Jump
opcode <= "1100011";
func3 <= "000";
func7 <= "0000000";
zero <= '1';
wait for 1 ns;

-- Read Test
assert (PC_Src = '0') report "test 7 fails" severity error;
assert (ResultSrc = '0') report "test 7 fails" severity error;
assert (MemWrite = '0') report "test 7 fails" severity error;
assert (ALUSrc = '0') report "test 7 fails" severity error;
assert (ALUControl = "000") report "test 7 fails" severity error;
assert (RegWrite = '0') report "test 7 fails" severity error;

wait;

end process;

end Behavioral;
