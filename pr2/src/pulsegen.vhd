-------------------------------------------------------
-- Práctica : práctica2
-- Fichero : pulsegen.vhd
-- Autor : Jorge López Viera
-- Fecha : 22-02-2025
-- Versión : 0.1
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
