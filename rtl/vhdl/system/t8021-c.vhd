-------------------------------------------------------------------------------
--
-- T8021 Microcontroller System
--
-- Copyright (c) 2004-2023, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8021_struct_c0 of t8021 is

  for struct

    for t8021_notri_b : t8021_notri
      use configuration work.t8021_notri_struct_c0;
    end for;

  end for;

end t8021_struct_c0;
