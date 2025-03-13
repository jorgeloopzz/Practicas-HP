-------------------------------------------------------
-- Práctica : PR3
-- Fichero : graphics.vhd
-- Autor : Jorge López Viera
-- Fecha : 06-03-2025
-- Versión : 0.1
-- Histórico: 0.1 versión inicial
------------------------------------------------------
-- Descripción : Este módulo implementa la función ...
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.all;

entity graphics is
  port (
    clk100        : in std_logic;
    video_on      : in std_logic;
    px_x          : in std_logic_vector (10 downto 0);
    px_y          : in std_logic_vector (10 downto 0);
    ship_x        : in std_logic_vector (10 downto 0);
    ship_y        : in std_logic_vector (10 downto 0);
    missile_x     : in std_logic_vector (10 downto 0);
    missile_y     : in std_logic_vector (10 downto 0);
    aliens_x      : in std_logic_vector (10 downto 0);
    aliens_y      : in std_logic_vector (10 downto 0);
    aliens0_alive : in std_logic_vector (9 downto 0);
    aliens1_alive : in std_logic_vector (9 downto 0);
    aliens2_alive : in std_logic_vector (9 downto 0);
    r             : out std_logic_vector (3 downto 0);
    g             : out std_logic_vector (3 downto 0);
    b             : out std_logic_vector (3 downto 0)
  );
end graphics;
