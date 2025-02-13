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

entity bin2bcd is
  port (
    bin   : in std_logic_vector(7 downto 0);
    bcd_u : out std_logic_vector(3 downto 0);
    bcd_d : out std_logic_vector(3 downto 0);
    bcd_c : out std_logic_vector(3 downto 0)
  );
end bin2bcd;
