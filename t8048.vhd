-------------------------------------------------------------------------------
--
-- $Id: t8048.vhd,v 1.1 2004-03-23 21:24:33 arniml Exp $
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity t8048 is

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

end t8048;


use work.t48_core_comp_pack.t48_core;
use work.t48_core_comp_pack.clk_gen;
use work.t48_core_comp_pack.syn_rom;
use work.t48_core_comp_pack.syn_ram;

architecture struct of t8048 is

  signal t0_s             : std_logic;
  signal t0_dir_s         : std_logic;
  signal db_s             : std_logic_vector( 7 downto 0);
  signal db_dir_s         : std_logic;
  signal p2_s             : std_logic_vector( 7 downto 0);
  signal p2_limp_s        : std_logic;
  signal p1_s             : std_logic_vector( 7 downto 0);
  signal p1_limp_s        : std_logic;
  signal xtal3_s          : std_logic;
  signal dmem_addr_s      : std_logic_vector( 7 downto 0);
  signal dmem_we_s        : std_logic;
  signal dmem_data_from_s : std_logic_vector( 7 downto 0);
  signal dmem_data_to_s   : std_logic_vector( 7 downto 0);
  signal pmem_addr_s      : std_logic_vector(11 downto 0);
  signal pmem_data_s      : std_logic_vector( 7 downto 0);

begin

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
      xtal_i      => xtal_i,
      reset_i     => reset_n_i,
      t0_i        => t0_b,
      t0_o        => t0_s,
      t0_dir_o    => t0_dir_s,
      int_n_i     => int_n_i,
      ea_i        => ea_i,
      rd_n_o      => rd_n_o,
      psen_n_o    => psen_n_o,
      wr_n_o      => wr_n_o,
      ale_o       => ale_o,
      db_i        => db_b,
      db_o        => db_s,
      db_dir_o    => db_dir_s,
      t1_i        => t1_i,
      p2_i        => p2_b,
      p2_o        => p2_s,
      p2_limp_o   => p2_limp_s,
      p1_i        => p1_b,
      p1_o        => p1_s,
      p1_limp_o   => p1_limp_s,
      prog_n_o    => prog_n_o,
      clk_i       => xtal_i,
      en_clk_i    => xtal3_s,
      xtal3_o     => xtal3_s,
      dmem_addr_o => dmem_addr_s,
      dmem_we_o   => dmem_we_s,
      dmem_data_i => dmem_data_from_s,
      dmem_data_o => dmem_data_to_s,
      pmem_addr_o => pmem_addr_s,
      pmem_data_i => pmem_data_s
    );

  -----------------------------------------------------------------------------
  -- Process bidirs
  --
  -- Purpose:
  --   Assign bidirectional signals.
  --
  bidirs: process (t0_b, t0_s, t0_dir_s,
                   db_b, db_s, db_dir_s,
                   p1_b, p1_s, p1_limp_s,
                   p2_b, p2_s, p2_limp_s)

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
--     if p1_limp_s = '1' then
--       p1_b <= p1_s;
--     else
--       p1_b <= (others => 'Z');
--     end if;

    -- Port 2 -----------------------------------------------------------------
    for i in p2_b'range loop
      p2_b(i) <= open_collector_f(p2_s(i));
    end loop;
--     if p2_limp_s = '1' then
--       p2_b <= p2_b_s;
--     else
--       p2_b <= (others => 'Z');
--     end if;

  end process bidirs;
  --
  -----------------------------------------------------------------------------

  rom_1k_b : syn_rom
    generic map (
      address_width_g => 10
    )
    port map (
      clk_i      => xtal_i,
      rom_addr_i => pmem_addr_s(9 downto 0),
      rom_data_o => pmem_data_s
    );

  ram_64_b : syn_ram
    generic map (
      address_width_g => 6
    )
    port map (
      clk_i      => xtal_i,
      res_i      => reset_n_i,
      ram_addr_i => dmem_addr_s(5 downto 0),
      ram_data_i => dmem_data_to_s,
      ram_we_i   => dmem_we_s,
      ram_data_o => dmem_data_from_s
    );

end struct;
