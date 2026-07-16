#!/bin/bash

echo 4 | gmx rmsf -s md.tpr -f analisis.xtc -o rmsf_atom.xvg;

xmgrace rmsf_atom.xvg;

echo 4 | gmx rmsf -s md.tpr -f analisis.xtc -res -o rmsf_rec.xvg;

xmgrace rmsf_rec.xvg;
