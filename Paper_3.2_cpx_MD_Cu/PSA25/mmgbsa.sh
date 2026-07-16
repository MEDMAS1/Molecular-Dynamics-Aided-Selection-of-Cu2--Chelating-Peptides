#!/bin/bash



echo 0 q | gmx make_ndx -f md.gro -o new_index.ndx;


echo ;

echo 1 0 | gmx trjconv -f new.xtc -o md_1_noPBC.xtc -s md.tpr -pbc mol -center -n new_index.ndx -ur compact;


gmx_MMPBSA -O -i mmgbsa.in -cs md.tpr -cp gromacs.top -ci new_index.ndx -cg 1 13 -ct md_1_noPBC.xtc -o FINAL_RESULTS_MMPBSA.dat -eo FINAL_RESULTS_MMPBSA.csv -do FINAL_DECOMP_MMPBSA.dat -deo FINAL_DECOMP_MMPBSA.csv;
