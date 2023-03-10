-------------------------------------------------------------------------------
--
-- The T48 Bus Connector.
-- Multiplexes all drivers of the T48 bus.
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
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.t48_pack.word_t;
use work.t48_pack.bus_idle_level_c;

entity t48_bus_mux is

  port (
    alu_data_i : in  word_t := (others => bus_idle_level_c);
    bus_data_i : in  word_t := (others => bus_idle_level_c);
    dec_data_i : in  word_t := (others => bus_idle_level_c);
    dm_data_i  : in  word_t := (others => bus_idle_level_c);
    pm_data_i  : in  word_t := (others => bus_idle_level_c);
    p0_data_i  : in  word_t := (others => bus_idle_level_c);
    p1_data_i  : in  word_t := (others => bus_idle_level_c);
    p2_data_i  : in  word_t := (others => bus_idle_level_c);
    psw_data_i : in  word_t := (others => bus_idle_level_c);
    tim_data_i : in  word_t := (others => bus_idle_level_c);
    adc_data_i : in  word_t := (others => bus_idle_level_c);
    data_o     : out word_t
  );

end t48_bus_mux;


architecture rtl of t48_bus_mux is

begin

  or_tree: if bus_idle_level_c = '0' generate
    data_o <= alu_data_i or
              bus_data_i or
              dec_data_i or
              dm_data_i  or
              pm_data_i  or
              p0_data_i  or
              p1_data_i  or
              p2_data_i  or
              psw_data_i or
              tim_data_i or
              adc_data_i;
  end generate;

  and_tree: if bus_idle_level_c = '1' generate
    data_o <= alu_data_i and
              bus_data_i and
              dec_data_i and
              dm_data_i  and
              pm_data_i  and
              p0_data_i  and
              p1_data_i  and
              p2_data_i  and
              psw_data_i and
              tim_data_i and
              adc_data_i;
  end generate;

end rtl;
