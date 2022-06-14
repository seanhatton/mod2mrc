#!/bin/bash
# Model to MRC (mod2mrc)
# Takes an MRC and matching/aligned IMOD model file 
# to produce a binary MRC of the model
# https://bio3d.colorado.edu/imod/

input_mrc="input_image.mrc"
input_mod="manually_segmented_objects.mod"
declare -a object_list
# List the object names in numerical order (object 1 first)
object_list=(membrane synapse mitochondia vesicle)

for i in "${!object_list[@]}"; do
    obj_num="$(($i + 1))"
    printf "Processing object %s labelled as %s\n" "$obj_num" "${object_list[$i]}"
    outmod="${object_list[$i]}.mod"
    outmrc="${object_list[$i]}.mrc"
    printf "Extracting %s from %s\n" "$outmod" "$input_mod"
    imodextract $obj_num $input_mod $outmod
    printf "Closing contours in %s\n" "$outmod"
    imodmesh -C $outmod
    printf "Converting %s to the binary file %s\n" "$outmod" "$outmrc"
    imodmop -mask 1 $outmod $input_mrc $outmrc
    printf "Correcting origin flip"
    alterheader -to $outmrc
done
#rm *.mod~
