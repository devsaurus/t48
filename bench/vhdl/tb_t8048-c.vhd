-------------------------------------------------------------------------------
--
-- The testbench for t8048.
--
-- $Id: tb_t8048-c.vhd,v 1.1 2004-03-24 21:42:10 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8048_behav_c0 of tb_t8048 is

  for behav

    for ext_ram_b : syn_ram
      use configuration work.syn_ram_lpm_c0;
    end for;

    for t8048_b : t8048
      use configuration work.t8048_struct_c0;
    end for;

  end for;

end tb_t8048_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
