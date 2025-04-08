----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2025 05:37:42 PM
-- Design Name: 
-- Module Name: ImmediateGenerator_tb - Behavioral
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

entity ImmediateGenerator_tb is
--  Port ( );
end ImmediateGenerator_tb;

architecture Behavioral of ImmediateGenerator_tb is

component ImmediateGenerator is
    Port (
        instruction : in std_logic_vector(31 downto 0);
        immediate: out std_logic_vector(31 downto 0)
        );
end component;

signal instruction_in : std_logic_vector(31 downto 0);
signal immediate_out : std_logic_vector(31 downto 0);

begin

DUT : ImmediateGenerator port map (instruction => instruction_in,
                    immediate => immediate_out);

tb_proc: process

begin

-- I-type tests

instruction_in <= "000100010001" & "0000000000000" & "0000011";
wait for 3ns;
assert (immediate_out = "00000000000000000000" & "000100010001") report "I-type immediate test1 failed" severity error;

wait for 10ns;

instruction_in <= "000100010011" & "0000000000000" & "0010011";
wait for 3ns;
assert (immediate_out = "00000000000000000000" & "000100010011") report "I-type immediate test2 failed" severity error;

wait for 10ns;

-- also test for correct sign extension
instruction_in <= "100100010011" & "0000000000000" & "1100111";
wait for 3ns;
assert (immediate_out = "11111111111111111111" & "100100010011") report "I-type immediate test3 failed" severity error;

wait for 10ns;

-- S-type test

-- sign extension when 1 is leading
instruction_in <= "1111111" & "0000000000000" & "11111" & "0100011";
wait for 3ns;
assert (immediate_out = "11111111111111111111" & "111111111111") report "S-type immediate test1 failed" severity error;

wait for 10ns;

-- sign extension when 0 is leading
instruction_in <= "0111111" & "0000000000000" & "11111" & "0100011";
wait for 3ns;
assert (immediate_out = "00000000000000000000" & "011111111111") report "S-type immediate test1 failed" severity error;


-- B-type test

instruction_in <= "0111111" & "0000000000000" & "11110" & "1100011"; -- bit 12 and 11 are zero, bits 10-5 and 4-1 are 1, rest zero
wait for 3ns;
assert (immediate_out = "0000000000000000000" & "0" & "0" & "111111" & "1111" & "0") report "B-type immediate test failed" severity error;

wait for 10ns;

-- U-type tests

instruction_in <= "01010100000000000000" & "00000" & "0110111";
wait for 3ns;
assert (immediate_out = "01010100000000000000" & "000000000000") report "U-type immediate test1 failed" severity error;

wait for 10ns;

instruction_in <= "01010100000000000000" & "00000" & "0010111";
wait for 3ns;
assert (immediate_out = "01010100000000000000" & "000000000000") report "U-type immediate test2 failed" severity error;

wait for 10ns;

-- J-type test

instruction_in <= "01111111111011111111" & "00000" & "1101111"; 
-- bit 20 is 0, 10:1 are 1, bit 11 is 0, then 19:12 are 1, output should be 00000000000 0 11111111 0 1111111111 0
wait for 3ns;
assert (immediate_out = "00000000000" & "0" & "11111111" & "0" & "1111111111" & "0") report "J-type immediate test1 failed" severity error;

wait;
end process tb_proc;


end Behavioral;
