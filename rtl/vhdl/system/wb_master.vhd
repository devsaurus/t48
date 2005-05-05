-------------------------------------------------------------------------------
--
-- The Wishbone master module.
--
-- $Id: wb_master.vhd,v 1.1 2005-05-05 19:49:03 arniml Exp $
--
-- Copyright (c) 2005, Arnim Laeuger (arniml@opencores.org)
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

use work.t48_pack.all;

entity wb_master is

  port (
    xtal_i      : in  std_logic;
    res_i       : in  std_logic;
    en_clk_o    : out std_logic;
    -- T48 Interface ----------------------------------------------------------
    ale_i       : in  std_logic;
    rd_n_i      : in  std_logic;
    wr_n_i      : in  std_logic;
    sel_range_i : in  std_logic_vector( 1 downto 0);
    db_bus_i    : in  std_logic_vector( 7 downto 0);
    db_bus_o    : out std_logic_vector( 7 downto 0);
    -- Wishbone Interface -----------------------------------------------------
    wb_cyc_o    : out std_logic;
    wb_stb_o    : out std_logic;
    wb_we_o     : out std_logic;
    wb_adr_o    : out std_logic_vector(23 downto 0);
    wb_ack_i    : in  std_logic;
    wb_dat_i    : in  std_logic_vector( 7 downto 0);
    wb_dat_o    : out std_logic_vector( 7 downto 0)
  );

end wb_master;


architecture rtl of wb_master is

  -----------------------------------------------------------------------------
  -- Controller FSM
  -----------------------------------------------------------------------------
  type   state_t is (IDLE, CYC, WAIT_INACT);
  signal state_s,
         state_q  : state_t;

  -----------------------------------------------------------------------------
  -- Select signals for each range
  -----------------------------------------------------------------------------
  signal sel_adr1_s,
         sel_adr2_s,
         sel_wb_s    : boolean;

  signal wr_s,
         rd_s        : boolean;

  signal adr_q : std_logic_vector(23 downto 0);

begin

  -----------------------------------------------------------------------------
  -- Select signal generation
  -----------------------------------------------------------------------------
  sel_adr1_s <= sel_range_i = "01";
  sel_adr2_s <= sel_range_i = "10";
  sel_wb_s   <= sel_range_i = "00";

  wr_s       <= wr_n_i = '0';
  rd_s       <= rd_n_i = '0';


  -----------------------------------------------------------------------------
  -- Process seq
  --
  -- Purpose:
  --   Implements the sequential elements.
  --
  seq: process (res_i, xtal_i)
  begin
    if res_i = res_active_c then
      adr_q   <= (others => '0');
      state_q <= IDLE;

    elsif xtal_i'event and xtal_i = clk_active_c then
      -- Address register -----------------------------------------------------
      -- update lowest address byte
      if ale_i = '1' then
        adr_q(word_t'range) <= db_bus_i;
      end if;
      -- set adr1 part
      if wr_s and sel_adr1_s then
        adr_q(word_t'length*2 - 1 downto word_t'length) <= db_bus_i;
      end if;
      -- set adr2 part
      if wr_s and sel_adr2_s then
        adr_q(word_t'length*3 - 1 downto word_t'length*2) <= db_bus_i;
      end if;

      -- FSM state ------------------------------------------------------------
      state_q <= state_s;

    end if;
  end process seq;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- Process fsm
  --
  -- Purpose:
  --   Implements the state transitions of the controller FSM.
  --
  fsm: process (state_q,
                wr_s,
                rd_s,
                sel_wb_s,
                wb_ack_i)
  begin
    -- default assignments
    wb_cyc_o <= '0';
    wb_stb_o <= '0';
    en_clk_o <= '1';

    case state_q is
      when IDLE =>
        if sel_wb_s and (wr_s or rd_s) then
          state_s <= CYC;
        end if;

      when CYC =>
        wb_cyc_o <= '1';
        wb_stb_o <= '1';
        en_clk_o <= '0';

        if wb_ack_i = '1' then
          state_s <= WAIT_INACT;
        else
          state_s <= CYC;
        end if;

      when WAIT_INACT =>
        if not wr_s and not rd_s then
          state_s <= IDLE;
        else
          state_s <= WAIT_INACT;
        end if;

      when others =>
        null;

    end case;

  end process fsm;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  --  Output multiplexer
  -----------------------------------------------------------------------------
  db_bus_o <=   adr_q(word_t'length*2 - 1 downto word_t'length)
              when sel_adr1_s else
                adr_q(word_t'length*3 - 1 downto word_t'length*2)
              when sel_adr1_s else
                wb_dat_i;
              

  -----------------------------------------------------------------------------
  -- Output mapping
  -----------------------------------------------------------------------------
  wb_adr_o <= adr_q;
  wb_dat_o <= db_bus_i;
  wb_we_o  <=   '1'
              when wr_s else
                '0';

end rtl;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
