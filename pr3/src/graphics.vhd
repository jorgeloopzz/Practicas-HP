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

architecture funcional of graphics is

  ------------------------------------------------------
  -- Señales de la nave
  -------------------------------------------------------
  signal ship_rom_enable : std_logic;
  signal ship_relative_x : std_logic_vector(10 downto 0);
  signal ship_relative_y : std_logic_vector(10 downto 0);
  signal ship_addr       : std_logic_vector(10 downto 0);

  -- Señal que se conectará a la salida de la ROM de la nave que proporciona
  -- las componentes RGB de la misma
  signal ship_rom : std_logic_vector(11 downto 0);

  ------------------------------------------------------
  -- Señales del misil
  -------------------------------------------------------
  signal missile_rom_enable : std_logic;
  signal missile_relative_x : std_logic_vector(10 downto 0);
  signal missile_relative_y : std_logic_vector(10 downto 0);
  signal missile_addr       : std_logic_vector(10 downto 0);

  ------------------------------------------------------
  -- Señales del alien
  -------------------------------------------------------
  signal aliens_rom_enable : std_logic;
  signal aliens_relative_x : std_logic_vector(10 downto 0);
  signal aliens_relative_y : std_logic_vector(10 downto 0);
  signal aliens_addr       : std_logic_vector(10 downto 0);

  -- Señal que se conectará a la salida de la ROM de la nave que proporciona
  -- las componentes RGB de la misma
  signal aliens_rom : std_logic_vector(11 downto 0);

  -- Señal que almacena las componentes RGB de las ROMS dependiendo
  -- de la prioridad
  signal rgb : std_logic_vector(11 downto 0);

begin

  ------------------------------------------------------
  -- Generación de la nave
  -------------------------------------------------------
  ship_rom_enable <= '1' when
    ((unsigned(px_x) >= unsigned(ship_x)) and
    (unsigned(px_x) < unsigned(ship_x) + to_unsigned(SHIP_WIDTH, 11))) and
    ((unsigned(px_y) >= unsigned(ship_y)) and
    (unsigned(px_y) < unsigned(ship_y) + to_unsigned(SHIP_HEIGHT, 11)))
    else
    '0';

  ship_relative_x <= std_logic_vector(unsigned(px_x) - unsigned(ship_x)) when
    (ship_rom_enable = '1') else
    (others => '0');

  ship_relative_y <= std_logic_vector(unsigned(px_y) - unsigned(ship_y)) when
    (ship_rom_enable = '1') else
    (others => '0');

  ship_addr <= ship_relative_y(5 downto 0) & ship_relative_x(5 downto 0);

  -- Componente de la nave
  ship_object : ship_object_rom
  port map
  (
    clka  => clk100,
    ena   => ship_rom_enable,
    addra => ship_addr,
    douta => ship_rom
  );

  ------------------------------------------------------
  -- Prioridad de los objetos
  -------------------------------------------------------
  process (ship_x, ship_y, missile_x, missile_y, aliens_x, aliens_y)
  begin
    if (video_on = '1') then
      if (ship_rom_enable = '1') then
        --- rgb iguales a las componentes de la rom ship_object_rom
        rgb <= ship_rom;

      elsif (missile_rom_enable = '1') then
        --- rgb iguales a las componentes de la rom missile_object_rom
        rgb <= missile_rom;

      elsif (aliens_rom_enable = '1') then
        --- rgb iguales a las componentes de la rom alien_object_rom
        rgb <= aliens_rom;

      else
        rgb <= (others => '0');
      end if;
    else
      rgb <= (others => '0');
    end if;
  end process;

  r <= rgb(11 downto 8);
  g <= rgb(7 downto 4);
  b <= rgb(3 downto 0);

end architecture;
