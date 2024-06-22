# Building a container on Kebnekaise

This is an example for building a software called Gromacs. Apptainer is site-installed
so you don't need to load any module. Build a Gromacs container as follows in the directory
which contains the .def definition file:

``apptainer build gromacs.sif gromacs.def``

Download the **benchMEM.tpr** file from https://www.mpinat.mpg.de/grubmueller/bench and 
place it in the directory where the .sif is generated. In fact you can place the files at 
any other location but then you will need to modify the paths in the **job.sh** batch script.

Submit the **job.sh** file to the queue. The output of Gromacs including its performance at 
the bottom of it (line with the ns/day string) is written in the *md.log* files.

