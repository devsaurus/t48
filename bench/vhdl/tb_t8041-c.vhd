-------------------------------------------------------------------------------
--
-- The testbench for t8041.
--
-- Copyright (c) 2004-2022, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8041_behav_c0 of tb_t8041 is

  for behav

    for t8041_b : t8041
      use configuration work.t8041_struct_c0;
    end for;
    for upi_stim_b : upi_stim
      use configuration work.upi_stim_behav_c0;
    end for;

  end for;

end tb_t8041_behav_c0;
