# Simple batch script examples   

!!! Objectives

    - See and try out different types of simple batch script examples.
    - Try using constraints: how to allocate specific CPUs. 
    - Try using constraints: how to allocate specific GPUs.  

For consistency, I have given all the example batch scripts the suffix ``.sh`` even though it is not required. Another commonly used suffix is ``.batch``, but any or none will work.

You need to compile any programs mentioned in a batch script in order to run the examples, except for ``compile-run.sh`` and the ``CUDA`` examples, which includes compilation.

!!! Important

    - The course project has the following project ID: hpc2n2024-084
    - In order to use it in a batch job, add this to the batch script: ``#SBATCH -A hpc2n2024-084``
    - We have a storage project linked to the compute project: **intro-hpc2n**. 
        - You find it in ``/proj/nobackup/intro-hpc2n``. 
        - Remember to create your own directory under it. 

!!! Hint 

    Try to change the C programs, add different programs, and in general play around with the examples!

!!! NOTE 

    1. For these test examples I would suggest using the ``foss`` compiler toolchain, version 2022b, unless otherwise specified. If you decide to use a different one, you will have to make changes to some of the batch scripts.
    2. To submit a job script, do ``sbatch JOBSCRIPT``
    3. In most of the examples, I name the executable when I compile. The flag ``-o`` tells the compiler you want to name the executable. If you don't include that and a name, you will get an executable named ``a.out``. Of course, you do not have to name the executable ``hello``. This is just an example. In general, I have named all the executables the same as the program (without the suffix).

## Serial batch job

To compile a serial program, like ``hello.c`` with gcc do:

```bash 
gcc hello.c -o hello
```

**Sample batch script (hello.sh)**

```bash
#!/bin/bash
# Project id - change to your own after the course!
#SBATCH -A hpc2n2024-084
# Asking for 1 core
#SBATCH -n 1
# Asking for a walltime of 1 min
#SBATCH --time=00:01:00
 
# Purge modules before loading new ones in a script.
ml purge  > /dev/null 2>&1
ml foss/2022b

./hello
```

!!! Note "Exercise: serial job"

    Submit the job with ``sbatch``. Check on it with ``squeue --me``. Take a look at the output (``slurm-JOBID.out``) with ``nano`` or your favourite editor. 

## MPI batch job 

To compile an MPI program, like ``mpi_hello.c`` (and create an executable named ``mpi_hello``) with gcc, do:

```bash 
mpicc mpi_hello.c -o mpi_hello
```

**Sample batch script (mpi_hello.sh)** 

```bash 
#!/bin/bash
# Remember to change this to your own Project ID after the course! 
#SBATCH -A hpc2n2024-084
# Number of tasks - default is 1 core per task 
#SBATCH -n 14
#SBATCH --time=00:05:00

# It is always a good idea to do ml purge before loading other modules 
ml purge > /dev/null 2>&1

ml add foss/2022b

# Use srun since this is an MPI program 
srun ./mpi_hello
```

!!! Note "Exercise: MPI job"

    Submit the job with ``sbatch``. Check on it with ``squeue --me``. Take a look at the output (``slurm-JOBID.out``) with ``nano`` or your favourite editor. Try running it more than once to see that the order of the tasks are random. 

## OpenMP batch job 

To compile an OpenMP program, like ``omp_hello.c`` (and create an executable named ``omp_hello``) with gcc, do:

```bash 
gcc -fopenmp omp_hello.c -o omp_hello
```

**Sample batch script (omp_hello.sh)** 

```bash
#!/bin/bash
#SBATCH -A hpc2n2024-084 
# Number of cores per task 
#SBATCH -c 28
#SBATCH --time=00:05:00

# It is always a good idea to do ml purge before loading other modules 
ml purge > /dev/null 2>&1

ml add foss/2022b

# Set OMP_NUM_THREADS to the same value as -c with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

./omp_hello
```

!!! Note "Exercise: OpenMP job" 

    Set ``OMP_NUM_THREADS`` to some value between 1 and 28 (``export OMP_NUM_THREADS=value``). Submit the job with ``sbatch``. Take a look at the output (``slurm-JOBID.out``) with nano or your favourite editor. Change the value of ``OMP_NUM_THREADS``). Submit it again and check on the output to see the change.  

## Multiple serial jobs from same submit file  

This submit file shows one way of running several programs from inside the same submit file. 

To run this example, you need to compile the following serial C programs:

```bash 
hello.c
Greeting.c
Adding2.c
Mult2.c
```

When the C programs have been compiled, submit the ``multiple-serial.sh`` program:

??? Note "multiple-serial.sh" 

    All jobs run at the same time, so you need as many cores as they need combined. You also need to ask for long enough time that even the longest of the jobs will finish. 

    Note that here you submit with ``srun`` even if it is serial jobs. You use ``&`` to send the job to the background. Also note the ``wait`` at the end. If you do not add that, the whole batch job will finish when the first of the jobs inside ends. 

    ```bash
    #!/bin/bash
    #SBATCH -A hpc2n2024-084
    # Add enough cores that all jobs can run at the same time 
    #SBATCH -n 5
    # Make sure that the time is long enough that the longest job will have time to finish 
    #SBATCH --time=00:05:00

    module purge > /dev/null 2>&1
    ml foss/2022b 

    srun -n 1 --exclusive ./hello &
    srun -n 1 --exclusive ./Greeting & 
    srun -n 1 --exclusive ./Adding2 10 20 &
    srun -n 1 --exclusive /bin/hostname & 
    srun -n 1 --exclusive ./Mult2 10 2 
    wait
    ``` 

!!! note "Exercise: multiple serial jobs"

    Compile the above mentioned programs. Submit the batch script with  

    ```bash 
    sbatch multiple-serial.sh
    ```

    If you run it several times you will notice that the order is random.

## Job arrays  

Job arrays offer a mechanism for submitting and managing collections of similar jobs. All jobs must have the same initial options (e.g. size, time limit, etc.), however it is possible to change some of these options after the job has begun execution using the scontrol command specifying the JobID of the array or individual ArrayJobID.

More information here on <a href="https://slurm.schedmd.com/job_array.html" target="_blank">the official Slurm documentation pages</a>. 

To try an example, we have included a small Python script ``hello-world-array.py`` and a batch script ``hello-world-array.sh``. Both can also be found in the ``exercises/simple`` directory you have cloned. 

!!! note "hello-world-array.py"

    ```bash
    # import sys library (we need this for the command line args)
    import sys

    # print task number
    print('Hello world! from task number: ', sys.argv[1])
    ```

!!! note "hello-world-array.sh" 

    ```bash
    #!/bin/bash
    # This is a very simple example of how to run a Python script with a job array
    #SBATCH -A hpc2n2024-084 # Change to your own after the course!
    #SBATCH --time=00:05:00 # Asking for 5 minutes
    #SBATCH --array=1-10   # how many tasks in the array
    #SBATCH -c 1 # Asking for 1 core    # one core per task
    #SBATCH -o hello-world-%j-%a.out

    # Load any modules you need, here for Python 3.11.3
    ml GCC/12.3.0 Python/3.11.3

    # Run your Python script
    srun python hello-world-array.py $SLURM_ARRAY_TASK_ID
    ``` 

!!! note "Exercise: job arrays" 

    Submit the batch script. Look at the output files. Change the number of tasks in the array. Rerun. See the change. 

## Multiple parallel jobs sequentially 

To run this example, you need to compile the following parallel C programs:

```bash 
mpi_hello.c
mpi_greeting.c
mpi_hi.c
```

When the MPI C programs have been compiled, submit the ``multiple-parallel-sequential.sh`` program:

```bash
#!/bin/bash
#SBATCH -A hpc2n2024-084 
# Since the files are run sequentially I only need enough cores for the largest of them to run 
#SBATCH -c 28
# Remember to ask for enough time for all jobs to complete
#SBATCH --time=00:10:00
 
module purge > /dev/null 2>&1 
ml foss/2022b

# Here 14 tasks with 2 cores per task. Output to file - not needed if your job creates output in a file directly 
# In this example I also copy the output somewhere else and then run another executable.

srun -n 14 -c 2 ./mpi_hello > myoutput1 2>&1
cp myoutput1 mydatadir
srun -n 14 -c 2 ./mpi_greeting > myoutput2 2>&1
cp myoutput2 mydatadir
srun -n 14 -c 2 ./mpi_hi > myoutput3 2>&1
cp myoutput3 mydatadir
```

```bash 
sbatch multiple-parallel-sequential.sh
```

!!! note "Exercise: multiple parallel jobs sequentially" 

    Submit the job: 

    ```bash 
    sbatch multiple-parallel-sequential.sh
    ```

    See that output data are thrown to files and copied to the directory ``mydatadir``. 

## Multiple parallel jobs simultaneously 

To run this example, you need to compile the following parallel C programs:

```bash 
mpi_hello.c
mpi_greeting.c
mpi_hi.c
```

As before, we recommend using the ``foss/2022b`` module for this. If you use a different one you need to change it in the ``multiple-parallel-simultaneous.sh`` batch script. 

When the MPI C programs have been compiled, submit the ``multiple-parallel-simultaneous.sh`` program:

```bash 
#!/bin/bash
#SBATCH -A hpc2n2024-084
# Since the files run simultaneously I need enough cores for all of them to run 
#SBATCH -n 56
# Remember to ask for enough time for all jobs to complete
#SBATCH --time=00:10:00
 
module purge > /dev/null 2>&1 
ml foss/2022b

srun -n 14 --exclusive ./mpi_hello &
srun -n 14 --exclusive ./mpi_greeting &
srun -n 14 --exclusive ./mpi_hi &
wait
```

Just like for the multiple serial jobs simultaneously example, you need to add ``wait`` to make sure the batch job will not finish when the first of the jobs in it finishes. 

!!! note "Exercise: multiple parallel jobs simultaneously" 

    When you have compiled the needed programs, as mentioned above, submit with 

    ```bash 
    sbatch multiple-parallel-simultaneous.sh
    ```

## Compiling and running in the batch job

Sometimes you have a program that takes a long time to compile, or that you need to recompile before each run. To see a simple example of compiling and running from the batch job, look at the batch script ``compile-run.sh``. 

In this case it compiles and runs the ``mpi_hello.c`` program. 

!!! note "compile-run.sh" 

    ```bash
    #!/bin/bash
    # CHANGE THE PROJECT ID TO YOUR OWN PROJECT ID AFTER THE COURSE!
    #SBATCH -A hpc2n2024-084
    #Name the job, for easier finding in the list
    #SBATCH -J compiler-run
    #SBATCH -t 00:10:00
    #SBATCH -n 12

    ml purge > /dev/null 2>&1

    ml foss/2022b 

    mpicc mpi_hello.c -o mpi_hello 
    mpirun ./mpi_hello
    ```

!!! note "Exercise: compile and run in a batch job"

    This batch script can be submitted directly, without compiling anything first, as that happens in the batch script. Try submitting it with ``sbatch`` and see what happens. Which files are created? You could try changing the program it compiles and runs to a different one. Remember to change the compiler if you are not using an MPI program.     

## Getting errors and outputs in separate files

As a default, Slurm throws both errors and other output to the same file, named ``slurm-JOBID.out``. If you want the errors and other output to separate files, you can do as in the example ``separate-err-out.sh``: 

```bash
#!/bin/bash 
# Remember to change this to your own Project ID after the course! 
#SBATCH -A hpc2n2024-084
#SBATCH -n 8 
#SBATCH --time=00:05:00

# Putting the output in a separate output file and the errors in an 
# error file instead of putting it all in slurm-JOBID.out 
# Note the environment variable %J, which contains the job ID. It is handy to 
# avoid naming the files the same for different runs, and thus overwriting them.  
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

ml purge > /dev/null 2>&1
ml foss/2022b

mpirun ./mpi_hello 
```

You need the ``mpi_hello.c`` file compiled (and the executable named ``mpi_hello``) for this to run without changes. Of course, you can also just add your own programs. 

!!! note "Exercise: errors and outputs in separate files" 

    Compile the file ``mpi_hello.s`` after loading the module ``foss/2022b``. Submit the job script with ``sbatch``. See that separate output and error files are created. 

## CUDA/GPU programs  

To run programs/software that uses GPUs, you need to allocated GPUs in the job script. They will not be allocated by your program. 

To compile a cuda program, like ``hello-world.cu`` you need to load a toolchain containing CUDA compilers/load CUDA compilers. 

To run a piece of software that uses GPUs, you need to load a module version which is GPU aware. In many cases there are several versions of a module, only some of which are for running on GPUs. 

!!! Important 

    Remember to check the modules, versions, and prerequisites! Also make sure you check for the correct node type. Some of the GPUs are on Intel nodes (check modules on ``kebnekaise.hpc2n.umu.se``), some on AMD nodes (check modules on ``kebnekaise-amd.hpc2n.umu.se``). 

### V100 - Intel Skylake

#### CUDA 

We recommend ``fosscuda/2020b`` (contains ``GCC``, ``OpenMPI``, ``OpenBLAS``/``LAPACK``, ``FFTW``, ``ScaLAPACK``, and ``CUDA``) or ``intelcuda/2019a`` (contains icc, ifort, IntelMPI, IntelMKL, and CUDA)

```bash 
$ ml fosscuda/2020b
$ nvcc hello-world.cu -o hello
```

The batch script gpu.sh compiles and runs a small cuda program called 'hello-world.cu'. To submit it:

```bash 
$ sbatch gpu.sh
```

### A100 - AMD Zen3

In order to find the correct modules, as well as compile a program if you need that, you must login to one of the AMD login nodes with either SSH (kebnekaise-amd.hpc2n.umu.se) or ThinLinc (kebnekaise-amd-tl.kebnekaise.hpc2n.umu.se)

After that, you load a suitable CUDA toolchain, like CUDA/11.7.0 and use nvcc to compile the program 'hello-world.cu'

```bash 
$ ml CUDA/11.7.0
$ nvcc hello-world.cu -o hello
```

The batch script gpu-a100.sh compiles and runs a small cuda program called 'hello-world.cu'. To submit it:

```bash 
$ sbatch gpu-a100.sh
```

To use the reservation for running on this node, make sure

```bash
#SBATCH --reservation=intro-gpu
```

is added.

A40 - Intel broadwell 

L40s - AMD Zen4

H100 - AMD Zen4

A6000 - AMD Zen4

MI100 - AMD Zen3 

:w


\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{GPU Job - V100} 

  \begin{block}{}
\begin{footnotesize}
\texttt{\#!/bin/bash} \\
\texttt{\#SBATCH -A hpc2n2023-132} \\
\texttt{\# Expected time for job to complete}  \\ 
\texttt{\#SBATCH --time=00:10:00} \\
\texttt{\# Number of GPU cards needed. Here asking for 2 V100 cards} \\
\texttt{\#SBATCH --gres=v100:2} \\
\vspace{3mm} 
\texttt{module purge > /dev/null 2>\&1} \\
\texttt{\# Change to modules needed for your program} \\ 
\texttt{ml fosscuda/2021b} \\ 
\vspace{3mm}
\texttt{./my-cuda-program} \\
\end{footnotesize}
  \end{block}

}


\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{GPU Job - A100} 

  \begin{block}{}
\begin{footnotesize}
\texttt{\#!/bin/bash} \\
\texttt{\#SBATCH -A hpc2n2023-132} \\
\texttt{\# Expected time for job to complete}  \\ 
\texttt{\#SBATCH --time=00:10:00} \\
\texttt{\# Adding the partition for the A100 GPUs} \\
\texttt{\#SBATCH -p amd\_gpu} \\ 
\texttt{\# Number of GPU cards needed. Here asking for 2 A100 cards} \\ 
\texttt{\#SBATCH --gres=a100:2} \\
\vspace{3mm} 
\texttt{module purge > /dev/null 2>\&1} \\
\texttt{\# Change to modules needed for your software - remember to login} \\
\texttt{\# to kebnekaise-amd.hpc2n.umu.se or} \\
\texttt{\# kebnekaise-amd-tl.hpc2n.umu.se login node to see availability} \\
\texttt{ml CUDA/11.7.0} \\ 
\vspace{3mm}
\texttt{./my-cuda-program} \\
\end{footnotesize}
  \end{block}

}


\frame{\frametitle{Important information}

  \begin{block}{}
    \begin{itemize}
      \begin{small}
      \item The course project has the following project ID: hpc2n2023-132
      \item In order to use it in a batch job, add this to the batch script:
        \begin{itemize}
          \begin{small}
          \item \#SBATCH -A hpc2n2023-132
          \end{small}
        \end{itemize}
      \item There is a reservation with one A100 GPU node reserved for the course, in order to let us run small GPU examples without having to wait for too long. The reservation also is for one Broadwell CPU node. 
      \item The reservation is ONLY valid during the course:
        \begin{itemize}
          \begin{small}
          \item intro-gpu \\ (add with \#SBATCH --reservation=intro-gpu)
          \end{small}
      \item To use the reservation with the A100 GPU node, also add \texttt{\#SBATCH -p amd\_gpu} and \texttt{\#SBATCH --gres=a100:x (for x=1,2)}. 
        \end{itemize}
      \item We have a storage project linked to the compute project. It is hpc2n2023-132. You find it in /proj/nobackup/hpc2n2023-132. Remember to create your own directory under it.
      \end{small}
    \end{itemize}
  \end{block}

}

\frame{\frametitle{Questions and support}

  \begin{block}{}
    \textbf{Questions?} Now: Ask me or one of the other support or application experts present. 

    \vspace{0.5cm}
    OR 
    \vspace{0.5cm}

    \begin{itemize}
    \item Documentation: \texttt{https://www.hpc2n.umu.se/support}
    \item Support questions to: \texttt{https://supr.naiss.se/support/} or \texttt{support@hpc2n.umu.se}
    \end{itemize}
  \end{block}

}

\end{document}






