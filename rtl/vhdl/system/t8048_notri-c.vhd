-------------------------------------------------------------------------------
--
-- T8048 Microcontroller System
--
-- $Id: t8048_notri-c.vhd,v 1.1 2004-12-01 23:07:21 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8048_notri_struct_c0 of t8048_notri is

  for struct

    for rom_1k_b : syn_rom
      use configuration work.syn_rom_lpm_c0;
    end for;

    for ram_64_b : syn_ram
      use configuration work.syn_ram_lpm_c0;
    end for;

    for t48_core_b : t48_core
      use configuration work.t48_core_struct_c0;
    end for;

  end for;

end t8048_notri_struct_c0;
