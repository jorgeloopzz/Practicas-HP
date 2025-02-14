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
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;
  USE WORK.ALL;

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
  signal result                                   : std_logic_vector(11 downto 0) := ((others => '0'));
  signal bcd_u_signal, bcd_d_signal, bcd_c_signal : std_logic_vector(3 downto 0);
  signal boost                                    : std_logic_vector(3 downto 0) := "0011";

  bcd_u_signal <= result(3 downto 0);
  bcd_d_signal <= result(7 downto 4);
  bcd_c_signal <= result(11 downto 8);

  process (result)
  begin
    for index in 7 downto 0 loop
      result(7 - index) <= bin(index);
    end loop;

    if bcd_u_signal > 4 then
      result(3 downto 0) <= bcd_u_signal + boost;
    end if;
    if bcd_d_signal > 4 then
      result(7 downto 4) <= bcd_d_signal + boost;
    end if;
    if bcd_c_signal > 4 then
      result(11 downto 8) <= bcd_c_signal + boost;
    end if;
  end process;

  bcd_u <= bcd_u_signal;
  bcd_d <= bcd_d_signal;
  bcd_c <= bcd_c_signal;

end architecture;
