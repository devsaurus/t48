-------------------------------------------------------------------------------
--
-- The testbench for t8039.
--
-- $Id: tb_t8039-c.vhd,v 1.1 2004-04-18 19:00:07 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration tb_t8039_behav_c0 of tb_t8039 is

  for behav

    for ext_ram_b : syn_ram
      use configuration work.syn_ram_lpm_c0;
    end for;

    for ext_rom_b : syn_rom
      use configuration work.syn_rom_lpm_c0;
    end for;

    for t8039_b : t8039
      use configuration work.t8039_struct_c0;
    end for;

  end for;

end tb_t8039_behav_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
