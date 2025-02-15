-------------------------------------------------------
-- Práctica : PR1
-- Fichero : bcd2sseg.vhd
-- Autor : Jorge López Viera
-- Fecha : 13-02-2025
-- Versión : 0.1
-- Histórico: 0.1 versión inicial
------------------------------------------------------
-- Descripción : Este módulo implementa la función ...
-------------------------------------------------------
library ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;
  USE WORK.ALL;

entity bcd2sseg is
  port (
    bcd  : in std_logic_vector(3 downto 0);
    sseg : out std_logic_vector(7 downto 0)
  );
end bcd2sseg;

architecture funcional of bcd2sseg is

begin
  process (bcd)
  begin
    case bcd is
      when "0000" => sseg <= "00000011";
      when "0001" => sseg <= "10011111";
      when "0010" => sseg <= "00100101";
      when "0011" => sseg <= "00001101";
      when "0100" => sseg <= "10011001";
      when "0101" => sseg <= "01001001";
      when "0110" => sseg <= "01000001";
      when "0111" => sseg <= "00011111";
      when "1000" => sseg <= "00000001";
      when "1001" => sseg <= "00011001";
      when others => sseg <= "11111111";
    end case;
  end process;

end architecture;
