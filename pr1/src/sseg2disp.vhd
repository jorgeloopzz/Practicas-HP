--------------------------------------------------------------------------
-- Práctica  : PR1 
-- Fichero   : sseg2disp.vhd
-- Autor/a   : FBTG
-- Fecha     : 01-10-2024
-- Versión   : 0.1
-- Histórico : 0.1 versión inicial
--------------------------------------------------------------------------
-- Descripción : Este bloque funcional proporcionará en el puerto de 
--               salida an, de 8 bits, las señales de control del ánodo 
--               de cada uno de los ocho displays de 7 segmentos 
--               disponibles en la placa de prototipado Nexys-4 DDR. 
--               Estas señales de control, activas a nivel bajo, 
--               determinarán en cada momento la selección del display 
--               en el que se representará el valor del dígito 
--               correspondiente (sseg7, sseg6, sseg5, sseg4, sseg3, 
--               sseg2, sseg1 o sseg0), proporcionado a través del puerto 
--               de salida sseg. 
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sseg2disp is
   generic(
      N_DIGITS   : integer := 8;      -- Number of digits
      N_RATE     : integer := 100000  -- Refresh rate in number of clk100 periods (1KHz)   
   );
   port(
      clk100     : in  std_logic;
      rst_n      : in  std_logic;        
      sseg0      : in  std_logic_vector(7 downto 0);
      sseg1      : in  std_logic_vector(7 downto 0);
      sseg2      : in  std_logic_vector(7 downto 0);
      sseg3      : in  std_logic_vector(7 downto 0);
      sseg4      : in  std_logic_vector(7 downto 0);
      sseg5      : in  std_logic_vector(7 downto 0);
      sseg6      : in  std_logic_vector(7 downto 0);
      sseg7      : in  std_logic_vector(7 downto 0);
      an         : out std_logic_vector(7 downto 0);
      sseg       : out std_logic_vector(7 downto 0)
   );
end entity sseg2disp;


architecture rtl of sseg2disp is
   type t_digits is array (0 to 7) of std_logic_vector(7 downto 0);
   signal digits : t_digits;
   signal refresh_count : integer range 0 to N_RATE := 0;
   signal an_count : integer range 0 to N_DIGITS - 1 := 0;

begin
   digits <= (sseg0, sseg1, sseg2, sseg3, sseg4, sseg5, sseg6, sseg7);
   
   process(clk100)
   begin
      if rising_edge(clk100) then
         if (rst_n = '0') then
            refresh_count <= 0;
            an_count <= 0;
         else
            if (refresh_count = (N_RATE - 1)) then
               refresh_count <= 0;
               if (an_count = N_DIGITS - 1) then
                  an_count <= 0;
               else
                  an_count <= an_count + 1;
               end if;
            else
               refresh_count <= refresh_count + 1;
            end if;
            an <= (others => '1');
            an(an_count) <= '0';
            sseg <= digits(an_count);		
         end if;
      end if;
   end process;

end architecture rtl;
