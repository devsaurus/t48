-------------------------------------------------------------------------------
--
-- A synchronous parametrizable RAM instantiating a standard RAM from
-- the Altera LPM.
--
-- $Id: syn_ram-lpm-c.vhd,v 1.1 2004-03-24 21:32:27 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration syn_ram_lpm_c0 of syn_ram is

  for lpm

    for ram_b : lpm_ram_dq
      use configuration work.lpm_ram_dq_c0;
    end for;

  end for;

end syn_ram_lpm_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
