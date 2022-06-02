# mod2mrc
A simple script to convert IMOD model file of multiple objects into individual binary MRC files. 

## Prerequisites
* Install IMOD https://bio3d.colorado.edu/imod/
* Ensure that the IMOD executables are included in the PATH. Alternately, amend the script to specify the fully qualified location of the imod commands (lines 16-18).

## Usage
1. Place the original MRC, model file and the script in the same directory.
2. In the script name the original MRC and model files (lines 7-8).
3. List the preferred names for the objects in the "object_list" (line 11). Object 1 will be first and so on. 
4. Run the script in terminal.
