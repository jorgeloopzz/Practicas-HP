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

architecture top of pr1hp is

  component sseg2disp is
    port (
      clk100 : in std_logic;
      rst_n  : in std_logic;
      sseg0  : in std_logic_vector(7 downto 0);
      sseg1  : in std_logic_vector(7 downto 0);
      sseg2  : in std_logic_vector(7 downto 0);
      sseg3  : in std_logic_vector(7 downto 0);
      sseg4  : in std_logic_vector(7 downto 0);
      sseg5  : in std_logic_vector(7 downto 0);
      sseg6  : in std_logic_vector(7 downto 0);
      sseg7  : in std_logic_vector(7 downto 0);
      an     : out std_logic_vector(7 downto 0);
      sseg   : out std_logic_vector(7 downto 0)
    );
  end component;

  component bcd2sseg is
    port (
      bcd  : in std_logic_vector(3 downto 0);
      sseg : out std_logic_vector(7 downto 0)
    );
  end component;

  component bin2bcd is
    port (
      bin   : in std_logic_vector(7 downto 0);
      bcd_u : out std_logic_vector(3 downto 0);
      bcd_d : out std_logic_vector(3 downto 0);
      bcd_c : out std_logic_vector(3 downto 0)
    );
  end component;

begin
  signal signal_bcd_u, signal_bcd_d, signal_bcd_c : std_logic_vector(3 downto 0);
  signal bcd_u_conv, bcd_d_conv, bcd_c_conv       : std_logic_vector(7 downto 0);

  conv_bin2bcd : bin2bcd
  port map
  (
    bin   => bin;
    bcd_u => signal_bcd_u;
    bcd_d => signal_bcd_d;
    bcd_c => signal_bcd_u;
  );

  conv_bcd2sseg_u : bcd2sseg
  port map
  (
    bcd  => signal_bcd_u;
    sseg => bcd_u_conv;
  );

  conv_bcd2sseg_d : bcd2sseg
  port map
  (
    bcd  => signal_bcd_d;
    sseg => bcd_d_conv;
  );

  conv_bcd2sseg_c : bcd2sseg
  port map
  (
    bcd  => signal_bcd_c;
    sseg => bcd_c_conv;
  );

  sseg2display_comp : sseg2display
  port map
  (
    clk100 => clk100;
    rst_n  => rst_n;
    sseg0  => bcd_u_conv;
    sseg1  => bcd_d_conv;
    sseg2  => bcd_c_conv;
    an     => an;
    sseg   => sseg;
  );

end architecture;