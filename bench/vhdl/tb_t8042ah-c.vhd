-------------------------------------------------------------------------------
--
-- The testbench for t8042ah.
--
-- Copyright (c) 2004-2022, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8042ah_behav_c0 of tb_t8042ah is

  for behav

    for t8042ah_b : t8042ah
      use configuration work.t8042ah_struct_c0;
    end for;
    for upi_stim_b : upi_stim
      use configuration work.upi_stim_behav_c0;
    end for;

  end for;

end tb_t8042ah_behav_c0;
