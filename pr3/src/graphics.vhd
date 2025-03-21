-------------------------------------------------------
-- Práctica : PR3
-- Fichero : graphics.vhd
-- Autor : Jorge López Viera
-- Fecha : 06-03-2025
-- Versión : 0.3
-- Histórico: 0.1 versión inicial
------------------------------------------------------
-- Descripción : Este módulo implementa la función ...
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.p_galaxian.all;

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
  signal ship_addr       : std_logic_vector(11 downto 0);

  -- Señal que se conectará a la salida de la ROM de la nave que proporciona
  -- las componentes RGB de la misma
  signal ship_rom : std_logic_vector(11 downto 0);
  
  component ship_object_rom
    port (
        clka    : in std_logic;
        ena     : in std_logic;
        addra   : in std_logic_vector(11 downto 0);
        douta   : out std_logic_vector(11 downto 0)
    );
  end component;

  ------------------------------------------------------
  -- Señales del misil
  -------------------------------------------------------
  signal missile_rom_enable : std_logic;
  signal missile_relative_x : std_logic_vector(10 downto 0);
  signal missile_relative_y : std_logic_vector(10 downto 0);
  signal missile_addr       : std_logic_vector(7 downto 0);
  
  signal missile_rom       : std_logic_vector(11 downto 0);

  component missile_object_rom
    port (
        clka    : in std_logic;
        ena     : in std_logic;
        addra   : in std_logic_vector(7 downto 0);
        douta   : out std_logic_vector(11 downto 0)
    );
  end component;

  ------------------------------------------------------
  -- Señales del alien
  -------------------------------------------------------
  signal aliens_rom_enable : std_logic;
  signal aliens_relative_x : std_logic_vector(10 downto 0);
  signal aliens_relative_y : std_logic_vector(10 downto 0);
  signal aliens_addr       : std_logic_vector(11 downto 0);

  -- Señal que se conectará a la salida de la ROM de la nave que proporciona
  -- las componentes RGB de la misma
  signal aliens_rom : std_logic_vector(11 downto 0);
  
  signal aliens_pos, aliens_row : std_logic_vector(4 downto 0);

  -- Señal que almacena las componentes RGB de las ROMS dependiendo
  -- de la prioridad
  signal rgb : std_logic_vector(11 downto 0);

  component alien_object_rom
    port (
        clka    : in std_logic;
        ena     : in std_logic;
        addra   : in std_logic_vector(11 downto 0);
        douta   : out std_logic_vector(11 downto 0)
    );
  end component;

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
  -- Generación del misil
  -------------------------------------------------------
  missile_rom_enable <= '1' when
    ((unsigned(px_x) >= unsigned(missile_x)) and
    (unsigned(px_x) < unsigned(missile_x) + to_unsigned(MISSILE_WIDTH, 11))) and
    ((unsigned(px_y) >= unsigned(missile_y)) and
    (unsigned(px_y) < unsigned(missile_y) + to_unsigned(MISSILE_HEIGHT, 11)))
    else
    '0';

  missile_relative_x <= std_logic_vector(unsigned(px_x) - unsigned(missile_x)) when
    (missile_rom_enable = '1') else
    (others => '0');

  missile_relative_y <= std_logic_vector(unsigned(px_y) - unsigned(missile_y)) when
    (missile_rom_enable = '1') else
    (others => '0');

  missile_addr <= missile_relative_y(4 downto 0) & missile_relative_x(2 downto 0);

  -- Componente del misil
  missile_object : missile_object_rom
  port map
  (
    clka  => clk100,
    ena   => missile_rom_enable,
    addra => missile_addr,
    douta => missile_rom
  );

  ------------------------------------------------------
  -- Generación de los aliens
  -------------------------------------------------------
  aliens_rom_enable <= '1' when
    ((unsigned(px_x) >= unsigned(aliens_x)) and
    (unsigned(px_x) < unsigned(aliens_x) + to_unsigned(ALIENS_WIDTH, 11))) and
    ((unsigned(px_y) >= unsigned(aliens_y)) and
    (unsigned(px_y) < unsigned(aliens_y) + to_unsigned(ALIENS_HEIGHT, 11)))
    else
    '0';

  aliens_relative_x <= std_logic_vector(unsigned(px_x) - unsigned(aliens_x)) when
    (aliens_rom_enable = '1') else
    (others => '0');

  aliens_relative_y <= std_logic_vector(unsigned(px_y) - unsigned(aliens_y)) when
    (aliens_rom_enable = '1') else
    (others => '0');

  aliens_addr <= aliens_relative_y(5 downto 0) & aliens_relative_x(5 downto 0);
  
  aliens_pos <= aliens_relative_x(10 downto 6);
  aliens_row <= aliens_relative_y(10 downto 6);

  -- Componente de los alienígenas
  aliens_object : alien_object_rom
  port map
  (
    clka  => clk100,
    ena   => aliens_rom_enable,
    addra => aliens_addr,
    douta => aliens_rom
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
        
        --- Determino que aliens de cada fila est�n muertos, y por consiguiente, no se muestran
        if ((aliens_row = "00000") and (aliens0_alive(TO_INTEGER(unsigned(aliens_pos))) = '0')) then
            rgb <= (others => '0');
        elsif ((aliens_row = "00001") and (aliens1_alive(TO_INTEGER(unsigned(aliens_pos))) = '0')) then
            rgb <= (others => '0');
        elsif ((aliens_row = "00010") and (aliens2_alive(TO_INTEGER(unsigned(aliens_pos))) = '0')) then
            rgb <= (others => '0');
        end if;

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
