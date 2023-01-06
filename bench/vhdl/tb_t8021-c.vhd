-------------------------------------------------------------------------------
--
-- The testbench for t8021.
--
-- Copyright (c) 2004-2023, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8021_behav_c0 of tb_t8021 is

  for behav

    for t8021_b : t8021
      use configuration work.t8021_struct_c0;
    end for;

  end for;

end tb_t8021_behav_c0;
