
library ieee;
use ieee.std_logic_1164.all;

entity upi_stim is

  port (
    cs_n_o : out   std_logic;
    rd_n_o : out   std_logic;
    wr_n_o : out   std_logic;
    a0_o   : out   std_logic;
    db_b   : inout std_logic_vector(7 downto 0);
    p1_b   : inout std_logic_vector(7 downto 0);
    p2_b   : inout std_logic_vector(7 downto 0);
    fail_o : out   boolean
  );

end upi_stim;


architecture behav of upi_stim is

begin

  stim: process

    constant del_seq_c  : time :=   5 us;
    constant del_dat_c  : time :=  10 us;
    constant del_step_c : time :=  20 us;

    variable rdata : std_logic_vector(db_b'range);

    procedure write_dbbin(data : in std_logic_vector(7 downto 0);
                          a0   : in std_logic) is
    begin
      cs_n_o <= '0';
      wait for del_seq_c;
      wr_n_o <= '0';
      wait for del_seq_c;
      a0_o <= a0;
      db_b <= data;
      wait for del_dat_c;
      wr_n_o <= '1';
      wait for del_seq_c;
      cs_n_o <= '1';
      wait for del_seq_c;
      db_b <= (others => 'Z');
      wait for del_step_c;
    end;

    procedure read_dbbout(a0 : in std_logic) is
    begin
      cs_n_o <= '0';
      wait for del_seq_c;
      rd_n_o <= '0';
      wait for del_seq_c;
      a0_o <= a0;
      wait for del_dat_c;
      rdata := db_b;
      rd_n_o <= '1';
      wait for del_seq_c;
      cs_n_o <= '1';
      wait for del_seq_c;
      wait for del_step_c;
    end;

    procedure poll_obf is
    begin
      -- poll for OBF
      rdata := (others => '0');
      while rdata(0) = '0' loop
        read_dbbout(a0 => '1');
      end loop;
    end;

    procedure echo_test is
    begin
      -- write data
      write_dbbin(data => "01010101", a0 => '0');

      poll_obf;

      read_dbbout(a0 => '0');
      if rdata /= "10101010" then
        -- error
        fail_o <= true;
      end if;

      -- send ok to dut
      write_dbbin(data => "00000001", a0 => '1');
    end;

    procedure flags_test is
    begin
    end;

  begin

    fail_o <= false;
    cs_n_o <= '1';
    rd_n_o <= '1';
    wr_n_o <= '1';
    a0_o   <= '0';
    db_b   <= (others => 'Z');

    wait until falling_edge(p1_b(2));
    wait for 100 us;

    while true loop
      poll_obf;

      -- read and interpret request
      read_dbbout(a0 => '0');
      case rdata is
        when "00000001" =>
          echo_test;
        when others =>
          null;
      end case;

    end loop;


    wait;

  end process stim;

end;
