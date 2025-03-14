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
use WORK.p_galaxian.all;

entity vgacontroller is
  port (
    clk100   : in std_logic;
    rst_n    : in std_logic;
    hsync    : out std_logic;
    vsync    : out std_logic;
    video_on : out std_logic;
    px_x     : out std_logic_vector(10 downto 0);
    px_y     : out std_logic_vector(10 downto 0)
  );
end entity vgacontroller;

architecture funcional of vgacontroller is
  signal counter     : unsigned(1 downto 0);
  signal hor_counter : unsigned(10 downto 0); -- Contador horizontal
  signal ver_counter : unsigned(10 downto 0); -- Contador vertical
  signal enable      : std_logic;

begin

  ------------------------------------------------------
  -- Generador de pulsos de validación cada 50 MHz
  -------------------------------------------------------
  process (clk100)
  begin
    if rising_edge(clk100) then
      if (rst_n = '0') then
        counter <= (others => '0');
      else
        if counter < (CP - 1) then
          counter <= counter + 1;
        else
          counter <= (others => '0');
        end if;
      end if;
    end if;
  end process;

  enable <= '1' when (counter = 1) else
    '0';

  ------------------------------------------------------
  -- Generador de señal de sincronismo horizontal
  -------------------------------------------------------
  process (clk100)
  begin
    if rising_edge(clk100) then
      if (rst_n = '0') then
        hor_counter <= (others => '0');
      else
        if enable = '1' then
          if hor_counter < (HD + HF + HR + HB - 1) then
            hor_counter <= hor_counter + 1;
          else
            hor_counter <= (others => '0');
          end if;
        end if;
      end if;
    end if;
  end process;

  hsync <= HP when ((hor_counter >= HD + HF) and (hor_counter <= HD + HF + HR - 1)) else
    (not HP); -- HP = '0'

  ------------------------------------------------------
  -- Generador de señal de sincronismo vertical
  -------------------------------------------------------
  process (clk100)
  begin
    if rising_edge(clk100) then
      if (rst_n = '0') then
        ver_counter <= (others => '0');
      else
        if enable = '1' then
          if hor_counter = (HD + HF + HR + HB - 1) then
            if ver_counter < (VD + VF + VR + VB - 1) then
              ver_counter <= ver_counter + 1;
            else
              ver_counter <= (others => '0');
            end if;
          end if;
        end if;
      end if;
    end if;
  end process;

  vsync <= (not VP) when ((ver_counter >= VD + VF) and (ver_counter <= VD + VF + VR - 1)) else
    VP; -- VP = '1'

  video_on <= '1' when (hor_counter < HD) and (ver_counter < VD) else
    '0';
    
  px_x <= std_logic_vector(hor_counter);
  px_y <= std_logic_vector(ver_counter);

end architecture;
