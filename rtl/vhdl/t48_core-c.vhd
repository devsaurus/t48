-------------------------------------------------------------------------------
--
-- T48 Microcontroller Core
--
-- $Id: t48_core-c.vhd,v 1.1 2004-03-23 21:31:53 arniml Exp $
--
-------------------------------------------------------------------------------

configuration t48_core_struct_c0 of t48_core is

  for struct

    for alu_b : alu
      use configuration work.alu_rtl_c0;
    end for;

    for bus_mux_b : bus_mux
      use configuration work.bus_mux_rtl_c0;
    end for;

    for clock_ctrl_b : clock_ctrl
      use configuration work.clock_ctrl_rtl_c0;
    end for;

    for cond_branch_b : cond_branch
      use configuration work.cond_branch_rtl_c0;
    end for;

    for use_db_bus
      for db_bus_b : db_bus
        use configuration work.db_bus_rtl_c0;
      end for;
    end for;

    for decoder_b : decoder
      use configuration work.decoder_rtl_c0;
    end for;

    for dmem_ctrl_b : dmem_ctrl
      use configuration work.dmem_ctrl_rtl_c0;
    end for;

    for use_timer
      for timer_b : timer
        use configuration work.timer_rtl_c0;
      end for;
    end for;

    for use_p1
      for p1_b : p1
        use configuration work.p1_rtl_c0;
      end for;
    end for;

    for use_p2
      for p2_b : p2
        use configuration work.p2_rtl_c0;
      end for;
    end for;

    for pmem_ctrl_b : pmem_ctrl
      use configuration work.pmem_ctrl_rtl_c0;
    end for;

    for psw_b : psw
      use configuration work.psw_rtl_c0;
    end for;

  end for;

end t48_core_struct_c0;
