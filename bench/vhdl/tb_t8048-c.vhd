-------------------------------------------------------------------------------
--
-- The testbench for t8048.
--
-- $Id: tb_t8048-c.vhd,v 1.3 2006-06-22 00:21:28 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8048_behav_c0 of tb_t8048 is

  for behav

    for ext_ram_b : generic_ram_ena
      use configuration work.generic_ram_ena_rtl_c0;
    end for;

    for ext_rom_b : lpm_rom
      use configuration work.lpm_rom_c0;
    end for;

    for t8048_b : t8048
      use configuration work.t8048_struct_c0;
    end for;

  end for;

end tb_t8048_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-- Revision 1.2  2006/06/21 01:04:05  arniml
-- replaced syn_ram and syn_rom with generic_ram_ena and t48_rom/t49_rom/t3x_rom
--
-- Revision 1.1  2004/03/24 21:42:10  arniml
-- initial check-in
--
-------------------------------------------------------------------------------
