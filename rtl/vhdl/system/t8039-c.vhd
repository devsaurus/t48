-------------------------------------------------------------------------------
--
-- T8039 Microcontroller System
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8039_struct_c0 of t8039 is

  for struct

    for t8039_notri_b : t8039_notri
      use configuration work.t8039_notri_struct_c0;
    end for;

  end for;

end t8039_struct_c0;
