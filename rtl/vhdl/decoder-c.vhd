-------------------------------------------------------------------------------
--
-- The Decoder unit.
-- It decodes the instruction opcodes and executes them.
--
-- $Id: decoder-c.vhd,v 1.1 2004-03-23 21:31:52 arniml Exp $
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration decoder_rtl_c0 of decoder is

  for rtl

    for opc_decoder_b: opc_decoder
      use configuration work.opc_decoder_rtl_c0;
    end for;

    for int_b: int
      use configuration work.int_rtl_c0;
    end for;

  end for;

end decoder_rtl_c0;
