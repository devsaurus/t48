-------------------------------------------------------------------------------
--
-- The testbench for t8041a.
--
-- Copyright (c) 2004-2022, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8041a_behav_c0 of tb_t8041a is

  for behav

    for t8041a_b : t8041a
      use configuration work.t8041a_struct_c0;
    end for;

  end for;

end tb_t8041a_behav_c0;
