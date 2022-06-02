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
    imodextract $obj_num $input_mod ${object_list[$i]}.mod
    imodmesh -C ${object_list[$i]}.mod
    imodmop -mask 1 $i.mod $input_mrc ${object_list[$i]}.mrc 
done
rm *.mod~
