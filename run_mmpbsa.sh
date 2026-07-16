#!/bin/bash

# Stop script if any command fails
set -e

# Activate conda environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate gmxMMPBSA

echo "Step 1: Creating index file..."
gmx make_ndx -f md.gro -o 2025.ndx

echo "Step 2: Creating 2025-compatible TPR file..."
gmx grompp \
  -f md.mdp \
  -c md.gro \
  -p gromacs.top \
  -n 2025.ndx \
  -o 2025.tpr

echo "Step 3: Reducing trajectory frames..."
gmx trjconv \
  -s 2025.tpr \
  -f md.xtc \
  -o md_reduced.xtc \
  -dt 10

echo "Step 4: Fixing PBC and centering trajectory..."
gmx trjconv \
  -f md_reduced.xtc \
  -o md_1.xtc \
  -s 2025.tpr \
  -pbc mol \
  -center \
  -n 2025.ndx \
  -ur compact

echo "Step 5: Running gmx_MMPBSA..."
gmx_MMPBSA \
  -O \
  -i mmgbsa.in \
  -cs 2025.tpr \
  -cp gromacs.top \
  -ci 2025.ndx \
  -cg 1 13 \
  -ct md_1.xtc

echo "All steps completed successfully."
