-------------------------------------------------------
-- Práctica : PR2
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

entity pr2hp is
  generic (
    N : integer := 8
  );
  port (
    clk100 : in std_logic;
    rst_n  : in std_logic;
    f      : in std_logic_vector(N - 1 downto 0);
    sout   : out std_logic
  );
end pr2hp;

architecture top of pr2hp is

  assert (2 <= N <= 8) report "N is outside the range supported by pulsegen module (2 <= N <= 8)" severity failure;

begin

  pulsegen_comp : entity work.pulsegen(funcional)
    port map
    (
      clk100 => clk100,
      rst_n  => rst_n,
      f      => f,
      sout   => sout
    );

end architecture;
