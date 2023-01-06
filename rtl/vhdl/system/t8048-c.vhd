-------------------------------------------------------------------------------
--
-- T8048 Microcontroller System
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8048_struct_c0 of t8048 is

  for struct

    for t8048_notri_b : t8048_notri
      use configuration work.t8048_notri_struct_c0;
    end for;

  end for;

end t8048_struct_c0;
