-------------------------------------------------------------------------------
--
-- T8039 Microcontroller System
-- 8039 toplevel without tri-states
--
-- $Id: t8039_notri-c.vhd,v 1.1 2004-12-03 19:42:34 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t8039_notri_struct_c0 of t8039_notri is

  for struct

    for ram_128_b : syn_ram
      use configuration work.syn_ram_lpm_c0;
    end for;

    for t48_core_b : t48_core
      use configuration work.t48_core_struct_c0;
    end for;

  end for;

end t8039_notri_struct_c0;
