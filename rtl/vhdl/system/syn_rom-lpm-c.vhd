-------------------------------------------------------------------------------
--
-- A synchronous parametrizable ROM instantiating a standard ROM from
-- the Altera LPM.
--
-- $Id: syn_rom-lpm-c.vhd,v 1.1 2004-03-24 21:32:27 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration syn_rom_lpm_c0 of syn_rom is

  for lpm

    for rom_b : lpm_rom
      use configuration work.lpm_rom_c0;
    end for;

  end for;

end syn_rom_lpm_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
