-------------------------------------------------------
-- Práctica : PR1
-- Fichero : bin2bcd.vhd
-- Autor : Jorge López Viera
-- Fecha : 13-02-2025
-- Versión : 0.1
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

    variable result                                   : unsigned(11 downto 0) := (others => '0');
    variable bcd_u_signal, bcd_d_signal, bcd_c_signal : unsigned(3 downto 0);
    variable boost                                    : unsigned(3 downto 0) := "0011";

  begin
    for index in 7 downto 0 loop
      result(7 - index) := bin(index);

      if result(3 downto 0) > 4 then
        result(3 downto 0) := result(3 downto 0) + boost;
      end if;
      if result(7 downto 4) > 4 then
        result(7 downto 4) := result(7 downto 4) + boost;
      end if;
      if result(11 downto 8) > 4 then
        result(11 downto 8) := result(11 downto 8) + boost;
      end if;
    end loop;

    bcd_u_signal := result(3 downto 0);
    bcd_d_signal := result(7 downto 4);
    bcd_c_signal := result(11 downto 8);

    bcd_u <= std_logic_vector(bcd_u_signal);
    bcd_d <= std_logic_vector(bcd_d_signal);
    bcd_c <= std_logic_vector(bcd_c_signal);
  end process;

end architecture;
