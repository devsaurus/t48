
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

  subtype word_t is std_logic_vector(7 downto 0);

begin

  stim: process

    constant test_echo_c      : word_t := "00000001";
    constant test_status41_c  : word_t := "00000010";
    constant test_status41a_c : word_t := "00000011";

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

    ---------------------------------------------------------------------------
    --
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
      write_dbbin(data => test_echo_c, a0 => '1');
    end;

    ---------------------------------------------------------------------------
    --
    procedure status41_test is
    begin
      -- test F1=0, F0=0, IBF=0, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "0000" then
        -- error
        fail_o <= true;
      end if;

      -- Step 1:
      -- set IBF and F1, DUT software doesn't read data
      write_dbbin(data => test_status41_c, a0 => '1');
      -- test F1=1, F0=0, IBF=1, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "1010" then
        -- error
        fail_o <= true;
      end if;

      -- Step 2:
      -- set IBF and clear F1, DUT software doesn't read data
      write_dbbin(data => test_status41_c, a0 => '0');
      -- test F1=0, F0=0, IBF=1, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "0010" then
        -- error
        fail_o <= true;
      end if;

      -- Step 3:
      -- set IBF and set F1, DUT software reads data and sets F0
      write_dbbin(data => not test_status41_c, a0 => '1');
      -- test F1=1, F0=1, IBF=0, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "1100" then
        -- error
        fail_o <= true;
      end if;

      -- Step 4:
      -- set IBF and clear F1, DUT software reads data and clears F0
      write_dbbin(data => not test_status41_c, a0 => '0');
      -- test F1=0, F0=0, IBF=0, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "0000" then
        -- error
        fail_o <= true;
      end if;

      -- Step 5:
      -- set IBF and set F1, DUT software reads data and loads OBF with F0=1
      write_dbbin(data => test_status41_c, a0 => '1');
      -- test F1=1, F0=1, IBF=0, OBF=1
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "1101" then
        -- error
        fail_o <= true;
      end if;
      -- read OBF, test for 099H
      read_dbbout(a0 => '0');
      if rdata /= "10011001" then
        -- error
        fail_o <= true;
      end if;
      -- test F1=1, F0=1, IBF=0, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "1100" then
        -- error
        fail_o <= true;
      end if;

      -- Step 6:
      -- set IBF and clear F1, DUT software reads data and loads OBF with F0=0
      -- and F1=1
      write_dbbin(data => test_status41_c, a0 => '0');
      -- test F1=1, F0=0, IBF=0, OBF=1
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "1001" then
        -- error
        fail_o <= true;
      end if;
      -- read OBF; test for 066H
      read_dbbout(a0 => '0');
      if rdata /= "01100110" then
        -- error
        fail_o <= true;
      end if;
      -- test F1=1, F0=0, IBF=0, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "1000" then
        -- error
        fail_o <= true;
      end if;

      -- send ok to dut
      write_dbbin(data => test_status41_c, a0 => '1');
    end;

    ---------------------------------------------------------------------------
    --
    procedure status41a_test is
    begin
      -- test F1=0, F0=0, IBF=0, OBF=0
      read_dbbout(a0 => '1');
      if rdata(3 downto 0) /= "0000" then
        -- error
        fail_o <= true;
      end if;

      -- Step 1:
      -- set IBF and F1, DUT software sets STS to A
      write_dbbin(data => test_status41a_c, a0 => '1');
      -- test STS=A, F1=1, F0=0, IBF=0, OBF=1
      read_dbbout(a0 => '1');
      if rdata /= "10101001" then
        -- error
        fail_o <= true;
      end if;
      --
      read_dbbout(a0 => '0');
      if rdata /= "00000001" then
        -- error
        fail_o <= true;
      end if;

      -- Step 2:
      -- set IBF and clear F1, DUT software sets STS to 5
      write_dbbin(data => not test_status41a_c, a0 => '0');
      -- test STS=5, F1=0, F0=0, IBF=0, OBF=1
      read_dbbout(a0 => '1');
      if rdata /= "01010001" then
        -- error
        fail_o <= true;
      end if;
      --
      read_dbbout(a0 => '0');
      if rdata /= "00000010" then
        -- error
        fail_o <= true;
      end if;

      -- Step 3:
      -- set IBF and set F1, DUT software sets STS to 0
      write_dbbin(data => test_status41a_c, a0 => '1');
      -- test STS=0, F1=1, F0=0, IBF=0, OBF=1
      read_dbbout(a0 => '1');
      if rdata /= "00001001" then
        -- error
        fail_o <= true;
      end if;
      --
      read_dbbout(a0 => '0');
      if rdata /= "00000011" then
        -- error
        fail_o <= true;
      end if;

      -- Step 4:
      -- set IBF and clear F1, DUT software sets STS to 0
      write_dbbin(data => not test_status41a_c, a0 => '0');
      -- test STS=0, F1=0, F0=0, IBF=0, OBF=1
      read_dbbout(a0 => '1');
      if rdata /= "00000001" then
        -- error
        fail_o <= true;
      end if;
      --
      read_dbbout(a0 => '0');
      if rdata /= "00000100" then
        -- error
        fail_o <= true;
      end if;

      -- send ok to dut
      write_dbbin(data => test_status41a_c, a0 => '1');
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
        when test_echo_c =>
          echo_test;

        when test_status41_c =>
          status41_test;

        when test_status41a_c =>
          status41a_test;

        when others =>
          null;
      end case;

    end loop;


    wait;

  end process stim;

end;
