-------------------------------------------------------------------------------
--
-- The Opcode Decoder.
-- Derives instruction mnemonics and multicycle information
-- using the OPC table unit.
--
-- $Id: opc_decoder-c.vhd,v 1.1 2004-03-23 21:31:52 arniml Exp $
--
-- All rights reserved
--
-------------------------------------------------------------------------------

configuration opc_decoder_rtl_c0 of opc_decoder is

  for rtl

    for opc_table_b: opc_table
      use configuration work.opc_table_rtl_c0;
    end for;

  end for;

end opc_decoder_rtl_c0;
