#!/usr/bin/env bash
set -euo pipefail

# Run this script from the "final" folder.
# For each result folder, it creates:
#   folder/pdb/   converted PDB files
#   folder/pdbqt/ copied/standardized PDBQT files

if ! command -v obabel >/dev/null 2>&1; then
    echo "Error: obabel was not found. Install Open Babel or add obabel to PATH."
    exit 1
fi

shopt -s nullglob

for dir in *_out; do
    [ -d "$dir" ] || continue

    echo "Processing $dir"
    mkdir -p "$dir/pdb" "$dir/pdbqt"

    for file in "$dir"/*.pdbqt; do
        [ -f "$file" ] || continue

        name="$(basename "$file" .pdbqt)"

        obabel -ipdbqt "$file" -opdb -O "$dir/pdb/${name}.pdb"
        obabel -ipdbqt "$file" -opdbqt -O "$dir/pdbqt/${name}.pdbqt"
    done
done

echo "Done. Each *_out folder now has pdb/ and pdbqt/ output folders."
