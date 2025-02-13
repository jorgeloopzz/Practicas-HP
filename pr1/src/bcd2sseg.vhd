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

entity bcd2sseg is
  port (
    bcd  : in std_logic_vector(3 downto 0);
    sseg : out std_logic_vector(7 downto 0)
  );
end bcd2sseg;