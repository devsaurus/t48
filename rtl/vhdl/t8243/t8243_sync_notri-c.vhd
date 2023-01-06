-------------------------------------------------------------------------------
--
-- T8243 Core
--
-------------------------------------------------------------------------------

configuration t8243_sync_notri_struct_c0 of t8243_sync_notri is

  for struct

    for t8243_core_b: t8243_core
      use configuration work.t8243_core_rtl_c0;
    end for;

  end for;

end t8243_sync_notri_struct_c0;
