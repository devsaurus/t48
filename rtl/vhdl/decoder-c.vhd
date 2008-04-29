-------------------------------------------------------------------------------
--
-- The Decoder unit.
-- It decodes the instruction opcodes and executes them.
--
-- $Id: decoder-c.vhd,v 1.3 2008-04-29 21:19:21 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration t48_decoder_rtl_c0 of t48_decoder is

  for rtl

    for int_b: t48_int
      use configuration work.t48_int_rtl_c0;
    end for;

  end for;

end t48_decoder_rtl_c0;
