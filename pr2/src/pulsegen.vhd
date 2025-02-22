-------------------------------------------------------
-- Práctica : práctica2
-- Fichero : pulsegen.vhd
-- Autor : Jorge López Viera
-- Fecha : 22-02-2025
-- Versión : 0.2
-- Histórico: 0.1 versión inicial
------------------------------------------------------
-- Descripción : Este módulo implementa la función ...
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.all;

entity pulsegen is
  generic (
    N : integer
  );
  port (
    clk100 : in std_logic;
    rst_n  : in std_logic;
    f      : in std_logic_vector(N - 1 downto 0);
    sout   : out std_logic
  );
end pulsegen;

architecture funcional of pulsegen is

  signal counter : unsigned(N - 1 downto 0);

begin

  process (clk100)
  begin
    if rising_edge(clk100) then
      if (rst_n = '0' or counter = f) then
        counter <= ((others => '0'));
      elsif (rst_n = '1' and counter /= f) then
        counter <= counter + 1;
      end if;
    end process;

    sout <= '1' when counter = f else '0';

  end architecture;
