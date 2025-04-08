library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port (
        clk         : in  std_logic;
        write_en    : in  std_logic;
        write_addr  : in  unsigned(4 downto 0); 
        write_data  : in  std_logic_vector(31 downto 0);
        read_addr1  : in  unsigned(4 downto 0);
        read_data1  : out std_logic_vector(31 downto 0);
        read_addr2  : in  unsigned(4 downto 0);
        read_data2  : out std_logic_vector(31 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if write_en = '1' and write_addr /= "00000" then
                registers(to_integer(write_addr)) <= write_data;
            end if;
        end if;
    end process;

    read_data1 <= (others => '0') when read_addr1 = "00000"
                  else registers(to_integer(read_addr1));

    read_data2 <= (others => '0') when read_addr2 = "00000"
                  else registers(to_integer(read_addr2));

end Behavioral;
