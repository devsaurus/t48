-------------------------------------------------------------------------------
--
-- T8243 Core
--
-- $Id: t8243-c.vhd,v 1.1 2006-07-13 22:53:56 arniml Exp $
--
-------------------------------------------------------------------------------

configuration t8243_struct_c0 of t8243 is

  for struct

    for t8243_async_notri_b: t8243_async_notri
      use configuration work.t8243_async_notri_struct_c0;
    end for;

  end for;

end t8243_struct_c0;
