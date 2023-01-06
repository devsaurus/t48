-------------------------------------------------------------------------------
--
-- The testbench for t8022.
--
-- Copyright (c) 2004-2023, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8022_behav_c0 of tb_t8022 is

  for behav

    for t8022_b : t8022
      use configuration work.t8022_struct_c0;
    end for;

  end for;

end tb_t8022_behav_c0;
