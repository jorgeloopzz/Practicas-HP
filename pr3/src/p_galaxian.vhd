--------------------------------------------------------------------------
-- Práctica  : PR3 
-- Fichero   : p_galaxian.vhd
-- Autor/a   : FBTG
-- Fecha     : 01-10-2024
-- Versión   : 0.1
-- Histórico : 0.1 versión inicial
--------------------------------------------------------------------------
-- Descripción : Paquete VHDL en el que se define el valor de los 
--               parámetros utilizados en los bloques funcionales 
--               vgacontroller y graphics. 
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package p_galaxian is

--------------------------------------------------------------------------------------------------
-- package p_galaxian for PR3 
-------------------------------------------------------------------------------------------------- 
   -- vgacontroller parameters (1024x576 @64Hz) 
   -- pixel clock ~50MHz - hsync negative / vsync positive
   constant CP:                      positive  := 2;    -- division factor clk100/pixelclk		
   constant HD:                      integer   := 1024; -- horizontal display area
   constant HF:                      integer   := 40;  	-- horizontal front porch
   constant HR:                      integer   := 104;  -- horizontal retrace
   constant HB:                      integer   := 144;  -- horizontal back porch
   constant HP:                      std_logic := '0';  -- horizontal sync polarity
   constant VD:                      integer   := 576; 	-- vertical display area
   constant VF:                      integer   := 3;  	-- vertical front porch
   constant VR:                      integer   := 5;   	-- vertical retrace
   constant VB:                      integer   := 17;  	-- vertical back porch
   constant VP:                      std_logic := '1';  -- horizontal sync polarity 

   -- graphics parameters 
   constant SHIP_WIDTH:              integer   := 64; 
   constant SHIP_HEIGHT:             integer   := 64;    
   constant MISSILE_WIDTH:           integer   := 8; 
   constant MISSILE_HEIGHT:          integer   := 32;   	
   constant ALIENS_WIDTH:            integer   := 10*64; 
   constant ALIENS_HEIGHT:           integer   := 3*64; 
   
end p_galaxian;

package body p_galaxian is
end package body p_galaxian;
