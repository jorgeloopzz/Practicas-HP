-------------------------------------------------------
-- Práctica : PR1
-- Fichero : bin2bcd.vhd
-- Autor : Jorge López Viera
-- Fecha : 13-02-2025
-- Versión : 0.2
-- Histórico: 0.1 versión inicial
------------------------------------------------------
-- Descripción : Este módulo implementa la función ...
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.all;

entity bin2bcd is
  port (
    bin   : in std_logic_vector(7 downto 0);
    bcd_u : out std_logic_vector(3 downto 0);
    bcd_d : out std_logic_vector(3 downto 0);
    bcd_c : out std_logic_vector(3 downto 0)
  );
end bin2bcd;

architecture funcional of bin2bcd is
begin

  process (bin)
    variable result                                   : unsigned(11 downto 0);
    variable t_bin                                    : std_logic_vector(7 downto 0);

  begin
    t_bin := bin;
    result := (OTHERS => '0');
    for index in 0 to 7 loop
      if result(3 downto 0) > 4 then
        result(3 downto 0) := result(3 downto 0) + "0011";
      end if;
      if result(7 downto 4) > 4 then
        result(7 downto 4) := result(7 downto 4) + "0011";
      end if;
      if result(11 downto 8) > 4 then
        result(11 downto 8) := result(11 downto 8) + "0011";
      end if;
      result := result(10 downto 0) & t_bin(7);
      t_bin := t_bin(6 downto 0) & '0';
    end loop;

    bcd_u <= std_logic_vector(result(3 downto 0));
    bcd_d <= std_logic_vector(result(7 downto 4));
    bcd_c <= std_logic_vector(result(11 downto 8));
  end process;

end architecture;
