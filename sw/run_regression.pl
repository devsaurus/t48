#!/usr/bin/perl -w
#
# ############################################################################
#
# run_regression.pl
#
# $Id: run_regression.pl,v 1.2 2004-04-09 19:17:09 arniml Exp $
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
# The testcells are identified by searching for the .asm file(s).
# Each testcell is built by calling the central Makefile.cell.
# The resulting hex-file is then copied to $SIM_DIR where the VHDL simulator
# is started.
#


use strict;

my (@asm_files, $asm_file);
my (%cells, $cell, $cell_dir, $tag);
my $pwd;


##############################################################################
# Commands to call the different VHDL simulators.
# 
# GHDL
my $ghdl_simulator = './tb_behav_c0';
#
# Choose simulator:
my $vhdl_simulator = $ghdl_simulator;
#
##############################################################################


$pwd = `pwd`;
chomp($pwd);


@asm_files = `find \$VERIF_DIR -name '*.asm'`;


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

        system('sh', '-c', 'rm -f $SIM_DIR/t48_rom.hex');
        system('sh', '-c', 'make -f $VERIF_DIR/include/Makefile.cell simu clean');
        if ($? == 0) {
            chdir($ENV{'SIM_DIR'});
            system('sh', '-c', 'ls -l t48_rom.hex');
            system('sh', '-c', $vhdl_simulator);
        } else {
            print("Error: Cannot make cell $cell!\n");
        }
    } else {
        print("Error: Cannot change to directory $cell_dir!\n");
    }
}

chdir($pwd);
