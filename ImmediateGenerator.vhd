----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2025 05:12:00 PM
-- Design Name: 
-- Module Name: ImmediateGenerator - Behavioral
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

entity ImmediateGenerator is
port (
instruction : in std_logic_vector(31 downto 0);
immediate : out std_logic_vector(31 downto 0)
);
end entity ImmediateGenerator;

architecture Behavioral of ImmediateGenerator is
begin
    immediate <=    
        -- I type, just take 31:20 and extend
        std_logic_vector(resize(signed(instruction(31 downto 20)),32)) 
            when (instruction(6 downto 0) = "0000011") or 
                 (instruction(6 downto 0) = "0010011") or 
                 (instruction(6 downto 0) = "1100111") else
        -- S type, merge 31-25 and 11-7
        std_logic_vector(resize(signed(instruction(31 downto 25) & instruction(11 downto 7)),32)) 
            when instruction(6 downto 0) = "0100011" else
        -- B-type, take first bit from 31, second bit from 7, 30-25, then 11-8m THEN ADD 0 AT THE END
        std_logic_vector(resize(signed(instruction(31) & instruction(7) & instruction(30 downto 25) & instruction(11 downto 8) & '0'),32)) 
            when instruction(6 downto 0) = "1100011" else
        -- U-type, like I-type but a bit trickier, need to append exactly 12 zeroes after 31:12
        std_logic_vector(signed(instruction(31 downto 12) & "000000000000")) 
            when (instruction(6 downto 0) = "0110111") or 
                 (instruction(6 downto 0) = "0010111") else
        -- J-type, take 31, then 19-12, then 20, then 30 to 21, then a '0', then extend
        std_logic_vector(resize(signed(instruction(31) & instruction (19 downto 12) & instruction(20) & instruction(30 downto 21) & '0'),32))
            when instruction(6 downto 0) = "1101111" else
        -- otherwise
        x"00000000";
end Behavioral;
