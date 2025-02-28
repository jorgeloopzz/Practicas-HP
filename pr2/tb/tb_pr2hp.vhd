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

entity tb_pr2hp is
end;

architecture behavioral of tb_pr2hp is
  signal t_clk100	: std_logic;
  signal t_rst_n	: std_logic;
  signal N          : integer;
  signal t_f        : std_logic_vector(N - 1 downto 0);
  signal s_out      : std_logic;
	
  constant Tclk100 : time := 10ns;
  constant Td : integer := 100000;

begin

  pr2hp:
      entity work.pr2hp(top)
      generic map (N => N)
      port map(
         clk100	=> t_clk100, 
         rst_n	=> t_rst_n,
         f => t_f,
         sout => s_out
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
    variable TestF : std_logic_vector(N-1 downto 0);
    variable s_TIME : time := 0 ns;
    variable e_TIME : integer := 0;
    variable L : LINE;
  begin
    t_rst_n <= '0';
    t_f <= (others => '0');
    wait until rising_edge(t_clk100);
    t_rst_n <= '1';
    wait until rising_edge(t_clk100);

	status := '0';
	-- Pruebo valor 2
	TestF := std_logic_vector(to_unsigned(2, N));
        write(L, 2, LEFT, 15);
        t_f <= TestF;
        wait until rising_edge(s_out);
        s_TIME := now;
        wait until rising_edge(s_out);
        e_TIME := (now - s_TIME)/(Tclk100);
        write(L, e_TIME, LEFT, 15);
        if 2 /= e_TIME then
            write(L, STRING'("X"), LEFT, 6);
            status := '1';
        end if;
    writeline(OUTPUT,L);
    write(L, STRING'("--------------------"));
    writeline(OUTPUT,L);
    
    wait until rising_edge(t_clk100);
	-- Pruebo valor 100
    TestF := std_logic_vector(to_unsigned(100, N));
        write(L, 2, LEFT, 15);
        t_f <= TestF;
        wait until rising_edge(s_out);
        s_TIME := now;
        wait until rising_edge(s_out);
        e_TIME := (now - s_TIME)/(Tclk100);
        write(L, e_TIME, LEFT, 15);
        if 2 /= e_TIME then
            write(L, STRING'("X"), LEFT, 6);
            status := '1';
        end if;
    writeline(OUTPUT,L);
    write(L, STRING'("--------------------"));
    writeline(OUTPUT,L);

    wait until rising_edge(t_clk100);
    -- Pruebo valor 250
    TestF := std_logic_vector(to_unsigned(250, N));
        write(L, 2, LEFT, 15);
        t_f <= TestF;
        wait until rising_edge(s_out);
        s_TIME := now;
        wait until rising_edge(s_out);
        e_TIME := (now - s_TIME)/(Tclk100);
        write(L, e_TIME, LEFT, 15);
        if 2 /= e_TIME then
            write(L, STRING'("X"), LEFT, 6);
            status := '1';
        end if;
    writeline(OUTPUT,L);
    write(L, STRING'("--------------------"));
    writeline(OUTPUT,L);

    if (status = '0') then
        write(L, STRING'("*** TEST PASSED"), LEFT, 15);
    else 
        write(L, STRING'("*** TEST FAILED"), LEFT, 15);
	end if;
    writeline(OUTPUT,L);
    finish;
  end process;


end architecture;