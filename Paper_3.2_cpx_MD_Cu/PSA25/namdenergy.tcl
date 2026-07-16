mol new md.gro
mol addfile new.trr -first 0 -last -1 -stride 1000  waitfor all

set sel1 [atomselect top "segname LIG"]
set out [open average.dat w]
set nf 36
set i 0
while {$i < $nf} {
set i [expr {$i + 1}]
set sel2 [atomselect top "segname AN1 and resid $i"]
set tempfile "TEMP_file_name"
set outfile "resid$i"
package require namdenergy
namdenergy -sel $sel1 $sel2  -par par_all36_na.prm   -par par_all27_prot_lipid.inp -par par_all22_prot.prm -par par_all36_cgenff.prm -par par_all36_lipid.prm -par par_all36_prot.prm -par par_all36_carb.prm -par lig.prm -vdw -elec -tempname ${tempfile} -ofile ${outfile}

}
