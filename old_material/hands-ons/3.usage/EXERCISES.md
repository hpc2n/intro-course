# Hands-on exercises. 

---
## 0. NOTES

The reservation is only valid during the course and is commented out due to this in the job examples. If you are running this during the course, you can add the reservation and/or remove the out-commenting. 

See the file README.md for help and hints. That file also contains information about the various examples, including how to compile and run them. 


## 1. EXERCISE - PROJECT STORAGE

Create a directory for yourself in the course's project storage /proj/nobackup/hpc2n2023-132/

## 2. EXERCISE - LOADING MODULES

In the test examples I have used the 'foss' compiler toolchain, version 2021b, unless otherwise specified. 

### 2.1 

Load the recommended toolchain. Then check with 'ml' to see what was loaded. 

Try compiling these programs:

```bash
hello.c
omp_hello.c
```

Remember, the README file contains information about how to compile C and OpenMP/C programs. 

These programs are very short. Try running them on the login node (this is not normally recommended, but these programs are short enough that it will not cause problems). 

The 'omp_hello.c' is an OpenMP program. You can see the different outputs when you change the number of threads with

```bash
export OMP_NUM_THREADS=<number>
```

Try change it to 1, 2, 4, 8 and run the program.

### 2.2 

Try using a different compiler toolchain (see the README file for how to find the toolchains). Remember that you need to compile and run with the same toolchain. 

NOTE: remember to unload or purge the previously loaded toolchain! 

Good example programs to test with are:

```bash
hello.c
omp_hello.c
```

The 'omp_hello.c' is an OpenMP program. You can see the different outputs when you change the number of threads with 

```bash
export OMP_NUM_THREADS=<number>
```

Try change it to 1, 2, 4, 8 and run the program. 

NOTE, again, that in this example you are just running the job on the login node. This is OK as long as it is a very short job that uses few resources. 

## 3. EXERCISE - BATCH JOBS

NOTE: remember to unload any toolchains you do not want to use, and load the one(s) you want to use before compiling anything!

### 3.1 

Submit one of the example jobs 

### 3.2 

Look at the output of the job. Which file did the job create? 

### 3.3 

Look at the list of jobs (```squeue, squeue -u <username>```). Check the status of the jobs (```scontrol show job <jobid>```). 

### 3.4 

Try submitting more jobs and see the changes and different states. Try cancelling one of the jobs. 

Again, look in the README file for help with commands! 

## 4. EXERCISE - BATCH SCRIPTS

NOTE: remember to unload any toolchains you do not want to use, and load the one(s) you want to use before compiling anything! 

NOTE 2: A few of the submit scripts copies the output to a directory I have called "mydatadir" as an example of this. Remember to create that directory before running those examples, or change it in the submit file.

### 4.1 

As a default, SLURM throws both errors and other output to the same file, named ```'slurm-<jobid>.out'```. 

The job script 'separate-err-out.sh' shows an example of how to split the output and error from the job into separate files. Try it out. Remember to compile the corresponding program and make sure the executable is named suitably for the script. Or change the name of the executable in the script. 

### 4.2 
  
Try and change the toolchain that is loaded in one of the scripts. Remember to load and compile the relevant program with the same toolchain before you submit the job.  

### 4.3 
  
Change the number of cores per task for the OpenMP job, in 'omp_hello.sh'. Run the job script and see the changes to the output file.  

### 4.4 
  
Compile the MPI C program 'mpi_hello.c' and run the corresponding job script.  What happens when you change the number of tasks? Try run it several times and see that the output order is random. 

### 4.5 
  
Compile the corresponding programs and submit the 'multiple-serial.sh' script. Run it a few times and see the order in the output is random. 

### 4.6 
  
Compile the corresponding programs and submit the 'multiple-parallel-sequential.sh' program. Note that the output data will be thrown to file and copied to the directory 'mydatadir'.  

### 4.7 
  
Compile the corresponding programs and submit the 'multiple-parallel-simultaneous.sh' program. Look at the output. 

## 5. EXERCISE - CUDA/GPU PROGRAM  

### V100

Load a suitable toolchain, like fosscuda/2020b and use 'nvcc' to compile the program 'hello-world.cu'  

Submit the job script 'gpu.sh' with the correct executable (named as in the script or changed to whatever you named it). 

### A100

- Login to the AMD login node with either SSH (kebnekaise-amd.hpc2n.umu.se) or ThinLinc (kebnekaise-amd-tl.kebnekaise.hpc2n.umu.se)

- Load a suitable CUDA toolchain, like CUDA/11.7.0 and use nvcc to compile the program 'hello-world.cu'

- Try run the binary on the login node (not normally recommended, but this is a short program). See that it works.

- Submit the script 'gpu-a100.sh' and see that it runs. Make changes to it if you want. 
