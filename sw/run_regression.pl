#!/usr/bin/perl -w
#
# ############################################################################
#
# run_regression.pl
#
# $Id: run_regression.pl,v 1.10 2006-06-24 00:52:24 arniml Exp $
#
# Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
#
# All rights reserved
#
# ############################################################################
#
# Purpose:
# ========
#
# Runs regression suite over all testcells found in $VERIF_DIR.
#
# run_regression.pl [-d]
#  -d : Perform a dump compare on each test with the i8039 simulator.
#
# The testcells are identified by searching for the .asm file(s).
# Each testcell is built by calling the central Makefile.cell.
# The resulting hex-file is then copied to $SIM_DIR where the VHDL simulator
# is started.
#


use strict;

use Getopt::Std;


sub print_usage {
    print <<EOU;
Runs regression tests in \$VERIF_DIR.
Usage:
 run_regression.pl [-d]
  -d : Perform a dump compare on each test with the i8039 simulator.
EOU
}


my %options;
my (@asm_files, $asm_file);
my (%cells, $cell, $cell_dir, $tag);
my $pwd;
my $dump_compare = 0;
my $dump_compare_cell = 0;


##############################################################################
# Commands to call the different VHDL simulators.
# 
# GHDL
my %ghdl_simulators    = ('gen' => './tb_behav_c0',
                          't48' => './tb_t8048_behav_c0',
                          't39' => './tb_t8039_behav_c0');
my $ghdl_simulator_opt = '--assert-level=error --stop-time=20ms';
my $ghdl_simulator_vcd = './tb_behav_c0 --assert-level=error --vcd=temp.vcd';
#
# Choose simulator:
my %vhdl_simulators    = %ghdl_simulators;
my $vhdl_simulator_opt = $ghdl_simulator_opt;
my $vhdl_simulator_vcd = $ghdl_simulator_vcd;
my ($vhdl_simulator_tag, $vhdl_simulator);
#
##############################################################################


# process command line options
if (!getopts('d', \%options)) {
    print_usage();
    exit(1);
}

if (exists($options{'d'})) {
    $dump_compare = 1;
}

$pwd = `pwd`;
chomp($pwd);


@asm_files = `find \$VERIF_DIR/black_box -name '*.asm'`;
push(@asm_files, `find \$VERIF_DIR/white_box -name '*.asm'`);


foreach $asm_file (@asm_files) {
    chomp($asm_file);
    # strip off assembler file names
    $asm_file =~ s/\/[^\/]+\.asm//;
    # strip off verification directory
    $asm_file =~ s/$ENV{'VERIF_DIR'}\///;
    $cells{$asm_file} = 1;
}

while (($cell, $tag) = each(%cells)) {
    $cell_dir = "$ENV{'VERIF_DIR'}/$cell";

    if (chdir($cell_dir)) {
        print("Processing $cell\n");

        $dump_compare_cell = -e 'no_dump_compare' ? 0 : $dump_compare;

        system('rm -f $SIM_DIR/*.hex');
        system('make -f $VERIF_DIR/include/Makefile.cell clean');
        system('make -f $VERIF_DIR/include/Makefile.cell all clean');
        if ($? == 0) {
            chdir($ENV{'SIM_DIR'});

            if ($dump_compare_cell) {
                system($vhdl_simulator_vcd);
                system('rm -f dump sim.dump vhdl.dump');
                system('vcd2vec.pl -s ../../sw/dump_compare.signals < temp.vcd | vec2dump.pl > vhdl.dump');
                system('i8039 -f t48_rom.hex -x t48_ext_rom.hex -d > dump');
                system('egrep \':.+\|\' dump | sed -e \'s/[^|]*. *//\' > sim.dump');
                system('diff -b -q sim.dump vhdl.dump');
                print("Dump Compare: ");
                if ($? == 0) {
                    print("PASS\n");
                } else {
                    print("FAIL\n");
                }
                system('rm -f dump sim.dump vhdl.dump temp.vcd');
            } elsif ($dump_compare) {
                print("Dump Compare: Excluded\n");
            } else {
                # run all enabled simulators
                while (($vhdl_simulator_tag, $vhdl_simulator) = each %vhdl_simulators) {
                    if (! -e "$cell_dir/no_$vhdl_simulator_tag") {
                        print("Executing simulator $vhdl_simulator_tag\n");
                        system($vhdl_simulator." ".$vhdl_simulator_opt);
                    }
                }
            }

        } else {
            print("Error: Cannot make cell $cell!\n");
        }
    } else {
        print("Error: Cannot change to directory $cell_dir!\n");
    }
}

chdir($pwd);
