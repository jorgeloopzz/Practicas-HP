--------------------------------------------------------------------------
-- Práctica  : PR2 
-- Fichero   : tb_pr2hp.vhd
-- Autor/a   : Jorge López Viera
-- Fecha     : 22-02-2025
-- Versión   : 0.1
-- Histórico : 0.1 versión inicial
--------------------------------------------------------------------------
-- Descripción : Entorno de verificación funcional del módulo pr2hp
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;
use STD.textio.all;
use IEEE.std_logic_textio.all;

entity tb_pr1hp is
end;

architecture behavioral of tb_pr1hp is
  signal t_clk100	: std_logic;
  signal t_rst_n	: std_logic;
  signal t_bin		: std_logic_vector(7 downto 0);
  signal t_an		: std_logic_vector(7 downto 0);
  signal t_sseg		: std_logic_vector(7 downto 0);
	
  constant Tclk100 : time := 10ns;
  constant Td : integer := 100000;

  type TESTvalues is array (natural range <>) of std_logic_vector(7 downto 0);
  constant AN   : TESTvalues := (x"FE", x"FD", x"FB", x"F7", x"EF", x"DF", x"BF", x"7F");
  constant SSEG : TESTvalues := (x"03", x"9F", x"25", x"0D", x"99", x"49", x"41", x"1F", x"01", x"19");
  constant SSEG_NULL : std_logic_vector(7 downto 0) := X"FF";
  
  -- type to allow a table of test values
  type BINvalues is array (natural range <>) of integer;
  -- test values
  constant BIN : BINvalues := (5, 25, 150, 250);

begin

  pr1hp:
      entity work.pr1hp(rtl)
      port map(
         clk100	=> t_clk100, 
         rst_n	=> t_rst_n,
         bin	=> t_bin, 
         an		=> t_an,
         sseg	=> t_sseg 
      );

	  
  -- clock generator
  clk_gen: process
  begin
     t_clk100 <= '0';
     wait for Tclk100/2;
     t_clk100 <= '1';
     wait for Tclk100/2;
  end process;

  -- stimulus generator
  stim_gen: process
    variable status : std_logic;
    variable TestBIN : std_logic_vector(7 downto 0);
	variable DIGIT : BINvalues(7 downto 0);
    variable s_TIME : time := 0 ns;
    variable e_TIME : integer := 0;
    variable L : LINE;
  begin
    t_rst_n <= '0';
    t_bin <= std_logic_vector(to_unsigned(BIN(0), 8));
    wait until rising_edge(t_clk100);
    t_rst_n <= '1';
    wait until rising_edge(t_clk100);
	status := '0';
    for I in BIN'RANGE loop
      TestBIN := std_logic_vector(to_unsigned(BIN(I), 8));
	  DIGIT(0) := ((BIN(I)) mod 10);
	  DIGIT(1) := ((BIN(I)/10) mod 10);
	  DIGIT(2) := ((BIN(I)/100) mod 10);
	  write(L, STRING'("***********************************"), LEFT);
      writeline(OUTPUT,L);
	  write(L, STRING'("*** "), LEFT); 
	  write(L, DIGIT(2), LEFT); 
	  write(L, DIGIT(1), LEFT); 
	  write(L, DIGIT(0), LEFT); 
      writeline(OUTPUT,L);
	  write(L, STRING'("***********************************"), LEFT);
      writeline(OUTPUT,L);	  
      write(L, STRING'("expected:"), LEFT, 15);
      write(L, STRING'("measured:"), LEFT, 15);
      writeline(OUTPUT,L);
      s_TIME := now;
      t_bin <= TestBIN;
	  for J in 0 to 7 loop 
	      wait until (t_an = AN(J));
		  write(L, STRING'("an: "), LEFT, 6);
		  hwrite(L, AN(J), LEFT, 9);
		  hwrite(L, t_an, LEFT, 9);	
		  if (AN(J) /= t_an) then
		      write(L, STRING'("X"), LEFT, 9);
			  status := '1';
		  end if;
          writeline(OUTPUT,L);
		  write(L, STRING'("sseg: "), LEFT, 6);
		  if (J < 3) then
		      hwrite(L, SSEG(DIGIT(J)), LEFT, 9);
		      hwrite(L, t_sseg, LEFT, 9);	
		      if (SSEG(DIGIT(J)) /= t_sseg) then
		          write(L, STRING'("X"), LEFT, 6);
			      status := '1';
		      end if;
		  else
		      hwrite(L, SSEG_NULL, LEFT, 9);		  
		      hwrite(L, t_sseg, LEFT, 9);	
		      if (SSEG_NULL /= t_sseg) then
		          write(L, STRING'("X"), LEFT, 6);
			      status := '1';
		      end if;
		  end if;
          writeline(OUTPUT,L);

		  write(L, STRING'("Td: "), LEFT, 6);
		  if ((I = 0) and (J = 0)) then
		      e_TIME := 0;		
		      write(L, STRING'("0"), LEFT, 9);
		      write(L, e_TIME, LEFT, 9);
		      if (0 /= e_TIME) then
		          write(L, STRING'("X"), LEFT, 6);
			      status := '1';
		      end if;
		  else
		      e_TIME := (now - s_TIME)/(Tclk100);		
		      write(L, Td, LEFT, 9);
		      write(L, e_TIME, LEFT, 9);
		      if (Td /= e_TIME) then
		          write(L, STRING'("X"), LEFT, 6);
			      status := '1';
		      end if;
		  end if;		  
		  writeline(OUTPUT,L);
	      write(L, STRING'("-----------------------------------"), LEFT);
          writeline(OUTPUT,L);		  
          s_TIME := now;
	  end loop;		  
    end loop;
    if (status = '0') then
        write(L, STRING'("*** TEST PASSED"), LEFT, 15);
    else 
        write(L, STRING'("*** TEST FAILED"), LEFT, 15);
	end if;
    writeline(OUTPUT,L);
    finish;
  end process;


end architecture;