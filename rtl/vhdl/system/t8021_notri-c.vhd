-------------------------------------------------------------------------------
--
-- T8021 Microcontroller System
--
-- Copyright (c) 2004-2023, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8021_notri_struct_c0 of t8021_notri is

  for struct

    for rom_1k_b : t48_rom
      use configuration work.t48_rom_lpm_c0;
    end for;

    for ram_64_b : generic_ram_ena
      use configuration work.generic_ram_ena_rtl_c0;
    end for;

    for t21_core_b : t21_core
      use configuration work.t21_core_struct_c0;
    end for;

  end for;

end t8021_notri_struct_c0;
