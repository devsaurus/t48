-------------------------------------------------------------------------------
--
-- T8039 Microcontroller System
--
-- $Id: t8039.vhd,v 1.1 2004-04-18 18:51:10 arniml Exp $
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

entity t8039 is

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

end t8039;


use work.t48_core_comp_pack.t48_core;
use work.t48_core_comp_pack.syn_rom;
use work.t48_core_comp_pack.syn_ram;

architecture struct of t8039 is

  signal t0_s             : std_logic;
  signal t0_dir_s         : std_logic;
  signal db_s             : std_logic_vector( 7 downto 0);
  signal db_dir_s         : std_logic;
  signal p2_s             : std_logic_vector( 7 downto 0);
  signal p2_low_imp_s     : std_logic;
  signal p1_s             : std_logic_vector( 7 downto 0);
  signal p1_low_imp_s     : std_logic;
  signal xtal3_s          : std_logic;
  signal dmem_addr_s      : std_logic_vector( 7 downto 0);
  signal dmem_we_s        : std_logic;
  signal dmem_data_from_s : std_logic_vector( 7 downto 0);
  signal dmem_data_to_s   : std_logic_vector( 7 downto 0);
  signal pmem_data_s      : std_logic_vector( 7 downto 0);

begin

  -- no Program memory available
  pmem_data_s <= (others => '0');

  t48_core_b : t48_core
    generic map (
      xtal_div_3_g        => 1,
      register_mnemonic_g => 1,
      include_port1_g     => 1,
      include_port2_g     => 1,
      include_bus_g       => 1,
      include_timer_g     => 1,
      sample_t1_state_g   => 4
    )
    port map (
      xtal_i       => xtal_i,
      reset_i      => reset_n_i,
      t0_i         => t0_b,
      t0_o         => t0_s,
      t0_dir_o     => t0_dir_s,
      int_n_i      => int_n_i,
      ea_i         => ea_i,
      rd_n_o       => rd_n_o,
      psen_n_o     => psen_n_o,
      wr_n_o       => wr_n_o,
      ale_o        => ale_o,
      db_i         => db_b,
      db_o         => db_s,
      db_dir_o     => db_dir_s,
      t1_i         => t1_i,
      p2_i         => p2_b,
      p2_o         => p2_s,
      p2_low_imp_o => p2_low_imp_s,
      p1_i         => p1_b,
      p1_o         => p1_s,
      p1_low_imp_o => p1_low_imp_s,
      prog_n_o     => prog_n_o,
      clk_i        => xtal_i,
      en_clk_i     => xtal3_s,
      xtal3_o      => xtal3_s,
      dmem_addr_o  => dmem_addr_s,
      dmem_we_o    => dmem_we_s,
      dmem_data_i  => dmem_data_from_s,
      dmem_data_o  => dmem_data_to_s,
      pmem_addr_o  => open,
      pmem_data_i  => pmem_data_s
    );

  -----------------------------------------------------------------------------
  -- Process bidirs
  --
  -- Purpose:
  --   Assign bidirectional signals.
  --
  bidirs: process (t0_b, t0_s, t0_dir_s,
                   db_b, db_s, db_dir_s,
                   p1_b, p1_s, p1_low_imp_s,
                   p2_b, p2_s, p2_low_imp_s)

    function open_collector_f(sig : std_logic) return std_logic is
      variable sig_v : std_logic;
    begin
      sig_v   := 'Z';

      if sig = '0' then
        sig_v := '0';
      end if;

      return sig_v;
    end;

  begin
    -- Test 0 -----------------------------------------------------------------
    if t0_dir_s = '1' then
      t0_b <= t0_s;
    else
      t0_b <= 'Z';
    end if;

    -- Data Bus ---------------------------------------------------------------
    if db_dir_s = '1' then
      db_b <= db_s;
    else
      db_b <= (others => 'Z');
    end if;

    -- Port 1 -----------------------------------------------------------------
    for i in p1_b'range loop
      p1_b(i) <= open_collector_f(p1_s(i));
    end loop;
--     if p1_low_imp_s = '1' then
--       p1_b <= p1_s;
--     else
--       p1_b <= (others => 'Z');
--     end if;

    -- Port 2 -----------------------------------------------------------------
    for i in p2_b'range loop
      p2_b(i) <= open_collector_f(p2_s(i));
    end loop;
--     if p2_low_imp_s = '1' then
--       p2_b <= p2_b_s;
--     else
--       p2_b <= (others => 'Z');
--     end if;

  end process bidirs;
  --
  -----------------------------------------------------------------------------

  ram_128_b : syn_ram
    generic map (
      address_width_g => 7
    )
    port map (
      clk_i      => xtal_i,
      res_i      => reset_n_i,
      ram_addr_i => dmem_addr_s(6 downto 0),
      ram_data_i => dmem_data_to_s,
      ram_we_i   => dmem_we_s,
      ram_data_o => dmem_data_from_s
    );

end struct;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
