-------------------------------------------------------------------------------
--
-- T8022 Microcontroller System
--
-- Copyright (c) 2004-2023, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8022_struct_c0 of t8022 is

  for struct

    for t8022_notri_b : t8022_notri
      use configuration work.t8022_notri_struct_c0;
    end for;

  end for;

end t8022_struct_c0;
