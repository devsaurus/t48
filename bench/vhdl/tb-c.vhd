-------------------------------------------------------------------------------
--
-- The testbench for t48_core.
--
-- $Id: tb-c.vhd,v 1.1 2004-03-24 21:42:10 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_behav_c0 of tb is

  for behav

    for rom_4k : syn_rom
      use configuration work.syn_rom_lpm_c0;
    end for;

    for ram_256 : syn_ram
      use configuration work.syn_ram_lpm_c0;
    end for;

    for ext_ram_b : syn_ram
      use configuration work.syn_ram_lpm_c0;
    end for;

    for t48_core_b : t48_core
      use configuration work.t48_core_struct_c0;
    end for;

  end for;

end tb_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
