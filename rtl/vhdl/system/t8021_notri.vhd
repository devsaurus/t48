-------------------------------------------------------------------------------
--
-- T8021 Microcontroller System
-- 8021 toplevel without tri-states
--
-- Copyright (c) 2004-2023, Arnim Laeuger (arniml@opencores.org)
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
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity t8021_notri is

  generic (
    gate_port_input_g : integer := 1
  );

  port (
    xtal_i    : in  std_logic;
    xtal_en_i : in  std_logic;
    reset_i   : in  std_logic;
    ale_o     : out std_logic;
    t1_i      : in  std_logic;
    p2_i      : in  std_logic_vector( 3 downto 0);
    p2_o      : out std_logic_vector( 3 downto 0);
    p1_i      : in  std_logic_vector( 7 downto 0);
    p1_o      : out std_logic_vector( 7 downto 0);
    p0_i      : in  std_logic_vector( 7 downto 0);
    p0_o      : out std_logic_vector( 7 downto 0);
    prog_n_o  : out std_logic
  );

end t8021_notri;


library ieee;
use ieee.numeric_std.all;

use work.t48_core_comp_pack.t21_core;
use work.t48_core_comp_pack.t48_rom;
use work.t48_core_comp_pack.generic_ram_ena;

architecture struct of t8021_notri is

  -- Address width of internal ROM
  constant rom_addr_width_c : natural := 10;

  signal reset_s          : std_logic;

  signal xtal3_s          : std_logic;
  signal dmem_addr_s      : std_logic_vector( 7 downto 0);
  signal dmem_we_s        : std_logic;
  signal dmem_data_from_s : std_logic_vector( 7 downto 0);
  signal dmem_data_to_s   : std_logic_vector( 7 downto 0);
  signal pmem_addr_s      : std_logic_vector(11 downto 0);
  signal pmem_data_s      : std_logic_vector( 7 downto 0);

  signal p0_in_s,
         p0_out_s         : std_logic_vector( 7 downto 0);
  signal p1_in_s,
         p1_out_s         : std_logic_vector( 7 downto 0);
  signal p2_in_s,
         p2_out_s         : std_logic_vector( 3 downto 0);

  signal vdd_s            : std_logic;

begin

  vdd_s <= '1';

  reset_s <= not reset_i;

  -----------------------------------------------------------------------------
  -- Check generics for valid values.
  -----------------------------------------------------------------------------
  -- pragma translate_off
  assert gate_port_input_g = 0 or gate_port_input_g = 1
    report "gate_port_input_g must be either 1 or 0!"
    severity failure;
  -- pragma translate_on


  t21_core_b : t21_core
    generic map (
      xtal_div_3_g        => 1,
      register_mnemonic_g => 1,
      sample_t1_state_g   => 4
    )
    port map (
      xtal_i        => xtal_i,
      xtal_en_i     => xtal_en_i,
      reset_i       => reset_s,
      ale_o         => ale_o,
      t1_i          => t1_i,
      p2_i          => p2_in_s,
      p2_o          => p2_out_s,
      p1_i          => p1_in_s,
      p1_o          => p1_out_s,
      p0_i          => p0_in_s,
      p0_o          => p0_out_s,
      prog_n_o      => prog_n_o,
      clk_i         => xtal_i,
      en_clk_i      => xtal3_s,
      xtal3_o       => xtal3_s,
      dmem_addr_o   => dmem_addr_s,
      dmem_we_o     => dmem_we_s,
      dmem_data_i   => dmem_data_from_s,
      dmem_data_o   => dmem_data_to_s,
      pmem_addr_o   => pmem_addr_s,
      pmem_data_i   => pmem_data_s
    );


  -----------------------------------------------------------------------------
  -- Gate port 0, 1 and 2 input bus with respetive output value
  -----------------------------------------------------------------------------
  gate_ports: if gate_port_input_g = 1 generate
    p0_in_s <= p0_i and p0_out_s;
    p1_in_s <= p1_i and p1_out_s;
    p2_in_s <= p2_i and p2_out_s;
  end generate;

  pass_ports: if gate_port_input_g = 0 generate
    p0_in_s <= p0_i;
    p1_in_s <= p1_i;
    p2_in_s <= p2_i;
  end generate;  

  p0_o <= p0_out_s;
  p1_o <= p1_out_s;
  p2_o <= p2_out_s;


  rom_1k_b : t48_rom
    port map (
      clk_i      => xtal_i,
      rom_addr_i => pmem_addr_s(rom_addr_width_c-1 downto 0),
      rom_data_o => pmem_data_s
    );

  ram_64_b : generic_ram_ena
    generic map (
      addr_width_g => 6,
      data_width_g => 8
    )
    port map (
      clk_i => xtal_i,
      a_i   => dmem_addr_s(5 downto 0),
      we_i  => dmem_we_s,
      ena_i => vdd_s,
      d_i   => dmem_data_to_s,
      d_o   => dmem_data_from_s
    );

end struct;
