-------------------------------------------------------------------------------
--
-- The testbench for t8048.
--
-- $Id: tb_t8048.vhd,v 1.4 2004-04-18 19:00:58 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--      http://www.opencores.org/cvsweb.shtml/t48/
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_t8048 is

end tb_t8048;

use work.t48_core_comp_pack.syn_ram;

use work.t48_tb_pack.all;

architecture behav of tb_t8048 is

  -- clock period, 11 MHz
  constant period_c : time := 90 ns;

  component t8048
    port (
      xtal_i    : in    std_logic;
      reset_n_i : in    std_logic;
      t0_b      : inout std_logic;
      int_n_i   : in    std_logic;
      ea_i      : in    std_logic;
      rd_n_o    : out   std_logic;
      psen_n_o  : out   std_logic;
      wr_n_o    : out   std_logic;
      ale_o     : out   std_logic;
      db_b      : inout std_logic_vector( 7 downto 0);
      t1_i      : in    std_logic;
      p2_b      : inout std_logic_vector( 7 downto 0);
      p1_b      : inout std_logic_vector( 7 downto 0);
      prog_n_o  : out   std_logic
    );
  end component;

  signal xtal_s          : std_logic;
  signal res_n_s         : std_logic;
  signal int_n_s         : std_logic;
  signal ale_s           : std_logic;
  signal psen_n_s        : std_logic;
  signal prog_n_s        : std_logic;
  signal rom_addr_s      : std_logic_vector(11 downto 0);
  signal rom_data_s      : std_logic_vector( 7 downto 0);
  signal ram_data_to_s   : std_logic_vector( 7 downto 0);
  signal ram_data_from_s : std_logic_vector( 7 downto 0);
  signal ram_addr_s      : std_logic_vector( 7 downto 0);
  signal ram_we_s        : std_logic;

  signal p1_b : std_logic_vector( 7 downto 0);
  signal p2_b : std_logic_vector( 7 downto 0);

  signal db_b                : std_logic_vector( 7 downto 0);
  signal ext_ram_addr_s      : std_logic_vector( 7 downto 0);
  signal ext_ram_data_from_s : std_logic_vector( 7 downto 0);
  signal ext_ram_we_s        : std_logic;
  signal rd_n_s              : std_logic;
  signal wr_n_s              : std_logic;

  signal zero_s          : std_logic;
  signal one_s           : std_logic;

begin

  zero_s <= '0';
  one_s  <= '1';

  p2_b   <= (others => 'H');
  p1_b   <= (others => 'H');

  ext_ram_b : syn_ram
    generic map (
      address_width_g => 8
    )
    port map (
      clk_i      => zero_s,
      res_i      => res_n_s,
      ram_addr_i => ext_ram_addr_s,
      ram_data_i => db_b,
      ram_we_i   => ext_ram_we_s,
      ram_data_o => ext_ram_data_from_s
    );

  t8048_b : t8048
    port map (
      xtal_i    => xtal_s,
      reset_n_i => res_n_s,
      t0_b      => p1_b(0),
      int_n_i   => int_n_s,
      ea_i      => zero_s,
      rd_n_o    => rd_n_s,
      psen_n_o  => psen_n_s,
      wr_n_o    => wr_n_s,
      ale_o     => ale_s,
      db_b      => db_b,
      t1_i      => p1_b(1),
      p2_b      => p2_b,
      p1_b      => p1_b,
      prog_n_o  => prog_n_s
    );



  -----------------------------------------------------------------------------
  -- External RAM access signals
  --
  ext_ram: process (wr_n_s,
                    ale_s,
                    db_b)
  begin
    if ale_s'event and ale_s = '0' then
      if not is_X(db_b) then
        ext_ram_addr_s <= db_b;
      else
        ext_ram_addr_s <= (others => '0');
      end if;
    end if;

    if wr_n_s'event and wr_n_s = '1' then
      ext_ram_we_s <= '1';
    end if;

--    if clk_s'event then
--      ext_ram_we_s <= '0';
--    end if;

  end process ext_ram;
  --
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- The clock generator
  --
  clk_gen: process
  begin
    xtal_s <= '0';
    wait for period_c/2;
    xtal_s <= '1';
    wait for period_c/2;
  end process clk_gen;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- The reset generator
  --
  res_gen: process
  begin
    res_n_s <= '0';
    wait for 5 * period_c;
    res_n_s <= '1';
    wait;
  end process res_gen;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- The interrupt generator
  --
  int_gen: process
  begin
    int_n_s <= '1';
    wait for 750 * period_c;
    int_n_s <= '0';
    wait for  45 * period_c;
  end process int_gen;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- End of simulation detection
  --
  eos: process
  begin

    outer: loop
      wait on tb_accu_s;
      if tb_accu_s = "10101010" then
        wait on tb_accu_s;
        if tb_accu_s = "01010101" then
          wait on tb_accu_s;
          if tb_accu_s = "00000001" then
            -- wait for instruction strobe of this move
            wait until tb_istrobe_s'event and tb_istrobe_s = '1';
            -- wait for next strobe
            wait until tb_istrobe_s'event and tb_istrobe_s = '1';
            assert false
              report "Simulation Result: PASS."
              severity note;
          else
            assert false
              report "Simulation Result: FAIL."
              severity note;
          end if;

          assert false
            report "End of simulation reached."
            severity failure;

        end if;
      end if;
    end loop;

  end process eos;
  --
  -----------------------------------------------------------------------------

end behav;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.3  2004/04/14 20:57:44  arniml
-- wait for instruction strobe after final end-of-simulation detection
-- this ensures that the last mov instruction is part of the dump and
-- enables 100% matching with i8039 simulator
--
-- Revision 1.2  2004/03/26 22:39:28  arniml
-- enhance simulation result string
--
-- Revision 1.1  2004/03/24 21:42:10  arniml
-- initial check-in
--
-------------------------------------------------------------------------------
