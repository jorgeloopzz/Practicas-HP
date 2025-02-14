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
  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;
  USE WORK.ALL;
  
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

end architecture;