-------------------------------------------------------------------------------
--
-- T8x48 ROM
-- Wrapper for ROM model from the LPM library.
--
-- $Id: t48_rom-lpm-c.vhd,v 1.1 2006-06-21 00:58:27 arniml Exp $
--
-- Copyright (c) 2006 Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t48_rom_lpm_c0 of t48_rom is

  for lpm

    for rom_b: lpm_rom
      use configuration work.lpm_rom_c0;
    end for;

  end for;

end t48_rom_lpm_c0;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
