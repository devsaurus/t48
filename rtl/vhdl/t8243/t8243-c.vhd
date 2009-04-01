-------------------------------------------------------------------------------
--
-- T8243 Core
--
-- $Id$
--
-------------------------------------------------------------------------------

configuration t8243_struct_c0 of t8243 is

  for struct

    for t8243_async_notri_b: t8243_async_notri
      use configuration work.t8243_async_notri_struct_c0;
    end for;

  end for;

end t8243_struct_c0;
