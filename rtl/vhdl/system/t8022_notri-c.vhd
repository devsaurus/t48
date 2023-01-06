-------------------------------------------------------------------------------
--
-- T8022 Microcontroller System
--
-- Copyright (c) 2004-2023, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8022_notri_struct_c0 of t8022_notri is

  for struct

    for rom_2k_b : t49_rom
      use configuration work.t49_rom_lpm_c0;
    end for;

    for ram_64_b : generic_ram_ena
      use configuration work.generic_ram_ena_rtl_c0;
    end for;

    for t22_core_b : t22_core
      use configuration work.t22_core_struct_c0;
    end for;

  end for;

end t8022_notri_struct_c0;
