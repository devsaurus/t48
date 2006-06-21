-------------------------------------------------------------------------------
--
-- The testbench for t48_core.
--
-- $Id: tb-c.vhd,v 1.4 2006-06-21 01:04:05 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_behav_c0 of tb is

  for behav

    for rom_internal_2k : lpm_rom
      use configuration work.lpm_rom_c0;
    end for;

    for rom_external_2k : lpm_rom
      use configuration work.lpm_rom_c0;
    end for;

    for ram_256 : generic_ram_ena
      use configuration work.generic_ram_ena_rtl_c0;
    end for;

    for ext_ram_b : generic_ram_ena
      use configuration work.generic_ram_ena_rtl_c0;
    end for;

    for t48_core_b : t48_core
      use configuration work.t48_core_struct_c0;
    end for;

    for if_timing_b : if_timing
      use configuration work.if_timing_behav_c0;
    end for;

  end for;

end tb_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.3  2004/05/21 11:22:44  arniml
-- exchange syn_rom for lpm_rom
--
-- Revision 1.2  2004/04/25 16:23:21  arniml
-- added if_timing
--
-- Revision 1.1  2004/03/24 21:42:10  arniml
-- initial check-in
--
-------------------------------------------------------------------------------
