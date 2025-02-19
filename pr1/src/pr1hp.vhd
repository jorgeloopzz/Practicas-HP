-------------------------------------------------------
-- Práctica : PR1
-- Fichero : pr1hp.vhd
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

entity pr1hp is
  port (
    clk100 : in std_logic;
    rst_n  : in std_logic;
    bin    : in std_logic_vector(7 downto 0);
    an     : out std_logic_vector(7 downto 0);
    sseg   : out std_logic_vector(7 downto 0)
  );
end pr1hp;

architecture rtl of pr1hp is

  signal signal_bcd_u, signal_bcd_d, signal_bcd_c : std_logic_vector(3 downto 0);
  signal bcd_u_conv, bcd_d_conv, bcd_c_conv       : std_logic_vector(7 downto 0);

begin

  -- Creo las instancias de cada entidad sin definir
  -- los componentes previamente.
  conv_bin2bcd : entity work.bin2bcd(funcional)
    port map
    (
      bin   => bin,
      bcd_u => signal_bcd_u,
      bcd_d => signal_bcd_d,
      bcd_c => signal_bcd_c
    );

  conv_bcd2sseg_u : entity work.bcd2sseg(funcional)
    port map
    (
      bcd  => signal_bcd_u,
      sseg => bcd_u_conv
    );

  conv_bcd2sseg_d : entity work.bcd2sseg(funcional)
    port map
    (
      bcd  => signal_bcd_d,
      sseg => bcd_d_conv
    );

  conv_bcd2sseg_c : entity work.bcd2sseg(funcional)
    port map
    (
      bcd  => signal_bcd_c,
      sseg => bcd_c_conv
    );

  sseg2display_comp : entity work.sseg2disp(rtl)
    port map
    (
      clk100 => clk100,
      rst_n  => rst_n,
      sseg0  => bcd_u_conv,
      sseg1  => bcd_d_conv,
      sseg2  => bcd_c_conv,

      -- En esta primera práctica solo se usarán los 3 primeros
      -- displays, por lo cual apagamos el resto que están
      -- activos a nivel bajo.
      sseg3 => "11111111",
      sseg4 => "11111111",
      sseg5 => "11111111",
      sseg6 => "11111111",
      sseg7 => "11111111",
      an    => an,
      sseg  => sseg
    );

end architecture;