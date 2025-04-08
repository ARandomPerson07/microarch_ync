----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2025 15:18:21
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    port (
        opcode      :in std_logic_vector(6 downto 0);
        func3       :in std_logic_vector(2 downto 0);
        func7       :in std_logic_vector(6 downto 0);
        zero        :in std_logic;
        
        PC_Src      :out std_logic; -- whether to be sequential, always 0
        ResultSrc  :out std_logic; -- ALU or Data Memory
        MemWrite    :out std_logic; -- Whether to write to memory
        ALUSrc      :out std_logic; -- what goes into the ALU, register data or Immediate generator
        ALUControl  :out std_logic_vector(2 downto 0); --tells the ALU what to do
        RegWrite    :out std_logic -- whether to write to register
    );
end control_unit;

architecture Behavioral of control_unit is
begin
    process(opcode, func3, func7, zero)
    begin
        -- Default values to prevent latches
        PC_Src     <= '0';
        ResultSrc <= '0';
        MemWrite   <= '0';
        ALUSrc     <= '0';
        ALUControl <= "000";
        RegWrite   <= '0';
        
        case opcode is
            when "0110011" =>  -- R
                RegWrite <= '1';
                if (func7 = "0000000" and func3 = "000") then -- ADD
                    ALUControl <= "000";
                elsif (func7 = "0100000" and func3 = "000") then -- SUB
                     ALUControl <= "001";
                elsif (func7 = "0000001" and func3 = "000") then --  MULT
                    ALUControl <= "010";
                elsif (func7 = "0000001" and func3 = "100") then -- DIV
                    ALUControl <= "100";
                end if;
            
            when "0010011" =>  -- I ALU ops
                RegWrite <= '1';
                ALUSrc   <= '1';
                if (func3 = "000") then -- ADDI
                    ALUControl <= "000";
                end if;        
                            
            when "0000011" =>  -- I loads
                RegWrite <= '1';
                ALUSrc   <= '1';
                ResultSrc <= '1';
                
            when "0100011" => -- S
                MemWrite <= '1'; -- read from data mem
                ALUSrc   <= '0'; -- read from register but let it through without adding
                ResultSrc <= '0'; -- take from ALU
                
                
            when "1100011" =>  -- B)
                if (zero = '0') then 
                    PC_Src <= '1';
                end if;
    
            when others =>  -- Default case
                PC_Src     <= '0';
                ResultSrc <= '0';
                MemWrite   <= '0';
                ALUSrc     <= '0';
                ALUControl <= "000";
                RegWrite   <= '0';
        end case;
    end process;
end Behavioral;
