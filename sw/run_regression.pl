#!/usr/bin/perl -w
#
# ############################################################################
#
# run_regression.pl
#
# $Id: run_regression.pl,v 1.7 2004-07-04 12:05:55 arniml Exp $
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
my $ghdl_simulator     = './tb_behav_c0';
my $ghdl_simulator_vcd = $ghdl_simulator.' --vcd=temp.vcd';
#
# Choose simulator:
my $vhdl_simulator     = $ghdl_simulator;
my $vhdl_simulator_vcd = $ghdl_simulator_vcd;
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

        system('sh', '-c', 'rm -f $SIM_DIR/t48_rom.hex');
        system('sh', '-c', 'make -f $VERIF_DIR/include/Makefile.cell clean');
        system('sh', '-c', 'make -f $VERIF_DIR/include/Makefile.cell simu clean');
        if ($? == 0) {
            chdir($ENV{'SIM_DIR'});
            system('sh', '-c', 'ls -l t48_rom.hex');
            system('sh', '-c', $dump_compare_cell > 0 ? $vhdl_simulator_vcd : $vhdl_simulator);

            if ($dump_compare_cell) {
                system('sh', '-c', 'rm -f dump sim.dump vhdl.dump');
                system('sh', '-c',
                       'vcd2vec.pl -s ../../sw/dump_compare.signals < temp.vcd | vec2dump.pl > vhdl.dump');
                system('sh', '-c', 'i8039 -f t48_rom.hex -x t48_ext_rom.hex -d > dump');
                system('sh', '-c', 'egrep \':.+\|\' dump | sed -e \'s/[^|]*. *//\' > sim.dump');
                system('sh', '-c', 'diff -b -q sim.dump vhdl.dump');
                print("Dump Compare: ");
                if ($? == 0) {
                    print("PASS\n");
                } else {
                    print("FAIL\n");
                }
                system('sh', '-c', 'rm -f dump sim.dump vhdl.dump temp.vcd');
            } elsif ($dump_compare) {
                print("Dump Compare: Excluded\n");
            }

        } else {
            print("Error: Cannot make cell $cell!\n");
        }
    } else {
        print("Error: Cannot change to directory $cell_dir!\n");
    }
}

chdir($pwd);
