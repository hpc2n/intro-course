# Brief documentation on how to run the simple examples. 

---
## 0. NOTES

The reservation is only valid during the course and is commented out due to this in the job examples. If you are running this during the course, you can add the reservation and/or remove the out-commenting. 

For consistency, I have given all the example batch scripts the suffix .sh even though it is not required. Another commonly used suffix is .batch but any or none will work. 

You need to compile any programs mentioned in order to run the examples, except for compile-run.sh and the CUDA example, which includes compilation. 

Try to change the C programs, add different programs, and in general play around with the examples! 

## 1. LOADING MODULES

For these test I would suggest using the 'foss' compiler toolchain, version 2019b, unless otherwise specified. If you decide to use a different one, you will have to make changes to some of the batch scripts. 

In order to load the foss compiler toolchain version 2019b: 

```bash
$ ml foss/2019b
```
OR write 

```bash
$ module add foss/2019b
```

You can see that it is loaded with 

```bash
$ ml
```

Do 

```bash
$ ml av foss
```

to see other versions of foss. 

The foss 2019b toolchain uses the GCC compilers, so the examples below use those. 

## 2. CHECKING ON YOUR JOB 

### 2.1 SUBMITTING A JOB 

To submit a job, do 

```bash
$ sbatch <my-job-script> 
```

### 2.2 STATUS OF YOUR JOB(S) 

You can see the status of your job with

```bash
$ scontrol show job <jobid>
```

### 2.3 LIST OF JOBS

To see a list of your jobs, including their jobid's

```bash
$ squeue -u <username>
```

### 2.4 CANCELLING A JOB

To cancel a job, do: 

```bash
$ scancel <jobid>
```

## 3. EXAMPLES

### 3.1 SERIAL EXAMPLE

To compile a serial program, like hello.c do 

```bash 
$ gcc hello.c -o hello
```

The flag '-o' tells the compiler you want to name the executable. If you don't include that and a name, you will get an executable named 'a.out'. Of course, you do not have to name the executable 'hello'. This is just an example. 

The batch script corresponding to the serial example is called 'simple.sh' 

To submit the simple batch script, write: 

```bash 
$ sbatch simple.sh
```

### 3.2 MPI EXAMPLE 

To compile an MPI program, like mpi_hello.c (and create an executable named 'mpi_hello'), do:  

```bash 
$ mpicc mpi_hello.c -o mpi_hello 
```

To submit the corresponding submit script file, 'mpi_hello.sh': 

```bash 
$ sbatch mpi_hello.sh
```

### 3.3 OPENMP EXAMPLE 

To compile an OpenMP program, like omp_hello.c (and create an executable named 'omp_hello'), do: 

```bash 
$ gcc -fopenmp omp_hello.c -o omp_hello 
```

To submit the corresponding submit script file, 'omp_hello.sh': 

```bash 
$ sbatch omp_hello.sh 
```

### 3.4 MULTIPLE SERIAL JOBS FROM SAME SUBMIT FILE 

To run this example, you need to compile the following serial C programs: 

```bash 
hello.c
Greeting.c
Adding2.c
Mult2.c
```

When the C programs have been compiled, submit the multiple-serial.sh program: 

```bash 
$ sbatch multiple-serial.sh 
```

If you run it several times you will notice that the order is random. 

### 3.4 MULTIPLE PARALLEL JOBS SEQUENTIALLY 

To run this example, you need to compile the following parallel C programs: 

```bash 
mpi_hello.c
mpi_greeting.c
mpi_hi.c
```

When the MPI C programs have been compiled, submit the multiple-parallel-sequential.sh program:

```bash 
$ sbatch multiple-parallel-sequential.sh
```

Output data will be thrown to file and copied to the directory mydatadir. 

### 3.5 MULTIPLE PARALLEL JOBS SIMULTANEOUSLY 

To run this example, you need to compile the following parallel C programs:       

```bash 
mpi_hello.c
mpi_greeting.c
mpi_hi.c
```

When the MPI C programs have been compiled, submit the multiple-parallel-simultaneous.sh program:

```bash 
$ sbatch multiple-parallel-simultaneous.sh
```

### 3.6 COMPILING AND RUNNING IN THE BATCH JOB

Sometimes you have a program that takes a long time to compile, or that you need to recompile before each run. To see a simple example of compiling and running from the batch job, look at the batch script

```bash 
compile-run.sh
```

In this case it compiiles and runs the mpi_hello.c program 

### 3.7 GETTING ERRORS AND OUTPUTS IN SEPARATE FILES

As a default, SLURM throws both errors and other output to the same file, names slurm-<jobid>.out. If you want the errors and other output to separate files, you can do as in the example 

```bash 
separate-err-out.sh 
```

You need the mpi_hello.c file compiled (and the executable named mpi_hello) for this to run without changes. Of course, you can also just add your own programs. 

### 3.8 CUDA/GPU program 

To compile a cuda program, like hello-world.cu you need to load a toolchain containing CUDA compilers. We recommend fosscuda/2019b (contains GCC, OpenMPI, OpenBLAS/LAPACK, FFTW, ScaLAPACK, and CUDA) or intelcuda/2019b (contains icc, ifort, IntelMPI, IntelMKL, and CUDA) 

```bash 
$ ml fosscuda/2019b
$ nvcc hello-world.cu -o hello
```

The batch script gpu.sh compiles and runs a small cuda program called 'hello-world.cu'. To submit it: 

```bash 
$ sbatch gpu.sh
```


Have fun! 
