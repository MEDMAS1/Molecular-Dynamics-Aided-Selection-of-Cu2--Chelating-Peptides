#!/bin/bash


echo 1 0 | gmx trjconv -s md.tpr -f new.xtc -o md_center.xtc -center -pbc mol -ur compact;

echo 0 | gmx trjconv -s md.tpr -f md_center.xtc -o start1ns.pdb -dump 1000;

echo 4 0 | gmx trjconv -s md.tpr -f new.xtc -o md.xtc -fit rot+trans;

echo 0 | gmx trjconv -s md.tpr -f md.xtc -o analisis.xtc -pbc mol -ur compact;

echo 4 | gmx gyrate -s md.tpr -f analisis.xtc -o rg_pep3_cpx.xvg;

xmgrace rg_pep3_cpx.xvg;
