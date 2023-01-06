-------------------------------------------------------------------------------
--
-- The Decoder unit.
-- It decodes the instruction opcodes and executes them.
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
