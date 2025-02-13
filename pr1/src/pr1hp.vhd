-------------------------------------------------------
-- Práctica : PR1
-- Fichero : pr1hp.vhd
-- Autor : Jorge López Viera
-- Fecha : 13-02-2025
-- Versión : 0.1
-- Histórico: 0.1 versión inicial
------------------------------------------------------
-- Descripción : Este módulo implementa la función ...
-------------------------------------------------------

entity pr1hp is
  port (
    clk100 : in std_logic;
    rst_n  : in std_logic;
    bin    : in std_logic_vector(7 downto 0);
    an     : out std_logic_vector(7 downto 0);
    sseg   : out std_logic_vector(7 downto 0)
  );
end pr1hp;
