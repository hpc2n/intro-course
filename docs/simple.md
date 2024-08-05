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


!!! Note "For selecting type of GPU"

    Type is:

    - v100
    - a40
    - a6000
    - a100
    - l40s
    - h100
    - mi100

For GPUs, the above GPU list of constraints can be used either as a specifier to ``--gpu=type:number`` or as a constraint together with an unspecified gpu request ``--gpu=number``.

!!! Note "For selecting GPUs with certain features"

    Type is: 
  
    - nvidia_gpu (Any Nvidia GPU)
    - amd_gpu (Any AMD GPU)
    - GPU_SP (GPU with single precision capability)
    - GPU_DP (GPU with double precision capability)
    - GPU_AI (GPU with AI features, like half precisions and lower)
    - GPU_ML (GPU with ML features, like half precisions and lower)

!!! Note "For selecting large memory nodes"

    Type is: 

    - largemem

#### Examples, constraints 

!!! Note "Only nodes with Zen4"

     ```bash    
     #SBATCH -C zen4
     ```

!!! Note "Nodes with a combination of features: a Zen4 CPU and a GPU with AI features"

    ```bash
    #SBATCH -C 'zen4&GPU_AI'
    ```

!!! Note "Nodes with either a Zen3 CPU or a Zen4 CPU" 

    ```bash
    #SBATCH -C 'zen3|zen4'
    ```

#### Examples, requesting GPUs

To use GPU resources one has to explicitly ask for one or more GPUs. Requests for GPUs can be done either in total for the job or per node of the job.

!!! note "Ask for one GPU of any kind"

    ```bash
    #SBATCH --gpus=1
    ```

!!! note "Another way to ask for one GPU of any kind"

    ```bash
    #SBATCH --gpus-per-node=1
    ```

!!! note "Asking for a specific type of GPU"

    As mentioned before, for GPUs, constraints can be used either as a specifier to ``--gpu=type:number`` or as a constraint together with an unspecified gpu request ``--gpu=number``.

    ```bash
    #SBATCH --gpus=Type:NUMBER
    ```

    where Type is, as mentioned:  

    - v100
    - a40
    - a6000
    - a100
    - l40s
    - h100
    - mi100

\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{Simple example, serial} 

  \begin{block}{}
    \justify
\begin{footnotesize}
Example: Serial job on Kebnekaise, compiler toolchain 'foss' 
\end{footnotesize}
  \end{block}

  \begin{block}{}
\begin{footnotesize}
\texttt{\#!/bin/bash} \\
\texttt{\# Project id - change to your own after the course!} \\
\texttt{\#SBATCH -A hpc2n2023-132} \\
\texttt{\# Asking for 1 core} \\
\texttt{\#SBATCH -n 1} \\
\texttt{\# Asking for a walltime of 5 min} \\ 
\texttt{\#SBATCH --time=00:05:00} \\ 
\vspace{3mm} 
\texttt{\# Purge modules before loading new ones in a script. } \\
\texttt{ml purge > /dev/null 2>\&1} \\ 
\texttt{ml foss/2021b} \\ 
\vspace{3mm}
\texttt{./my\_serial\_program}
\end{footnotesize}
  \end{block}

  \begin{block}{}
    \justify
\begin{footnotesize}
Submit with: \\
\texttt{sbatch $<$jobscript$>$} 
\end{footnotesize}
  \end{block}

}

\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{Example, MPI C program} 

  \begin{block}{}
    \begin{footnotesize}
      \texttt{\#include $<$stdio.h$>$} \\
\texttt{\#include $<$mpi.h$>$} \\
\vspace{3mm} 
\texttt{int main (int argc, char *argv[]) {} \\ 
\vspace{3mm}
\texttt{int myrank, size;} \\ 
\vspace{3mm}
\texttt{MPI\_Init(\&argc, \&argv);} \\ 
\texttt{MPI\_Comm\_rank(MPI\_COMM\_WORLD, \&myrank);} \\ 
\texttt{MPI\_Comm\_size(MPI\_COMM\_WORLD, \&size);} \\ 
\vspace{3mm}
\texttt{printf("Processor \%d of \%d: Hello World!\textbackslash n", myrank, size);} \\ 
\vspace{3mm}
\texttt{MPI\_Finalize();}
\vspace{3mm}
\texttt{}}
    \end{footnotesize}
  \end{block}

} 


\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{Simple example, parallel} 

  \begin{block}{}
    \justify
  \begin{footnotesize}
  Example: MPI job on Kebnekaise, compiler toolchain 'foss' 
  \end{footnotesize}
\end{block}

  \begin{block}{}
\begin{footnotesize}
\texttt{\#!/bin/bash} \\
\texttt{\#SBATCH -A hpc2n2023-132} \\
\texttt{\#SBATCH -n 14} \\
\texttt{\#SBATCH --time=00:05:00} \\ 
\texttt{\#\#SBATCH --exclusive} \\ 
\texttt{\#SBATCH --reservation=intro-gpu} \\ 
\vspace{3mm} 
\texttt{module purge > /dev/null 2>\&1} \\ 
\texttt{ml foss/2021b} \\ 
\vspace{3mm}
\texttt{srun ./my\_parallel\_program}
\end{footnotesize}
  \end{block}

}


\begin{frame}[fragile]\frametitle{The Batch System (SLURM)}\framesubtitle{Simple example, output} 

  \begin{block}{}
    \justify
Example: Output from a MPI job on Kebnekaise, run on 14 cores (one NUMA island)
  \end{block}

  \begin{block}{}
\begin{tiny}
\begin{verbatim}
b-an01 [~/slurm]$ cat slurm-15952.out 

Processor 12 of 14: Hello World!
Processor 5 of 14: Hello World!
Processor 9 of 14: Hello World!
Processor 4 of 14: Hello World!
Processor 11 of 14: Hello World!
Processor 13 of 14: Hello World!
Processor 0 of 14: Hello World!
Processor 1 of 14: Hello World!
Processor 2 of 14: Hello World!
Processor 3 of 14: Hello World!
Processor 6 of 14: Hello World!
Processor 7 of 14: Hello World!
Processor 8 of 14: Hello World!
Processor 10 of 14: Hello World!
\end{verbatim}
\end{tiny}
  \end{block}

\end{frame}



\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{Starting more than one serial job in the same submit file} 

  \begin{block}{}
\begin{small}
\texttt{\#!/bin/bash} \\
\texttt{\#SBATCH -A hpc2n2023-132} \\
\texttt{\#SBATCH -n 5} \\
\texttt{\#SBATCH --time=00:15:00} \\ 
\vspace{3mm} 
\texttt{module purge > /dev/null 2>\&1} \\ 
\texttt{ml foss/2021b} \\ 
\vspace{3mm}
\texttt{srun -n 1 ./job1.batch \&} \\ 
\texttt{srun -n 1 ./job2.batch \&} \\ 
\texttt{srun -n 1 ./job3.batch \&} \\ 
\texttt{srun -n 1 ./job4.batch \&} \\ 
\texttt{srun -n 1 ./job5.batch } \\
\texttt{wait} \\
\end{small}
  \end{block}

} 

\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{Multiple Parallel Jobs Sequentially} 

  \begin{block}{}
\begin{scriptsize}
\texttt{\#!/bin/bash} \\
\texttt{\#SBATCH -A hpc2n2023-132} \\
\texttt{\#SBATCH -c 28} \\
\texttt{\# Remember to ask for enough time for all jobs to complete} \\ 
\texttt{\#SBATCH --time=02:00:00} \\ 
\vspace{3mm} 
\texttt{module purge > /dev/null 2>\&1} \\ 
\texttt{ml foss/2021b} \\ 
\vspace{3mm}
\texttt{\# Here 14 tasks with 2 cores per task. Output to file.} \\
\texttt{\# Not needed if your job creates output in a file} \\ 
\texttt{\# I also copy the output somewhere else and then run} \\
\texttt{\# another executable...} \\
\vspace{3mm}
\texttt{srun -n 14 -c 2 ./a.out > myoutput1 2>\&1} \\ 
\texttt{cp myoutput1 /pfs/nobackup/home/u/username/mydatadir} \\ 
\texttt{srun -n 14 -c 2 ./b.out > myoutput2 2>\&1} \\ 
\texttt{cp myoutput2 /pfs/nobackup/home/u/username/mydatadir} \\ 
\texttt{srun -n 14 -c 2 ./c.out > myoutput3 2>\&1} \\
\texttt{cp myoutput3 /pfs/nobackup/home/u/username/mydatadir} \\
\end{scriptsize}
  \end{block}

} 



\frame{\frametitle{The Batch System (SLURM)}\framesubtitle{Multiple Parallel Jobs Simultaneously} 

\begin{footnotesize}
Make sure you ask for enough cores that all jobs can run at the same time, and have enough memory. Of course, this will also work for serial jobs - just remove the srun from the command line.
\end{footnotesize} 

  \begin{block}{}
\begin{footnotesize}
\texttt{\#!/bin/bash} \\
\texttt{\#SBATCH -A hpc2n2023-132} \\
\texttt{\# Total number of cores the jobs need} \\
\texttt{\#SBATCH -n 56} \\
\texttt{\# Remember to ask for enough time for all of the jobs to} \\
\texttt{\# complete, even the longest} \\ 
\texttt{\#SBATCH --time=02:00:00} \\ 
\vspace{3mm} 
\texttt{module purge > /dev/null 2>\&1} \\ 
\texttt{ml foss/2021b} \\ 
\vspace{3mm}
\texttt{srun -n 14 --cpu\_bind=cores ./a.out \&} \\ 
\texttt{srun -n 28 --cpu\_bind=cores ./b.out \&} \\ 
\texttt{srun -n 14 --cpu\_bind=cores ./c.out \&} \\ 
\texttt{...} \\ 
\texttt{wait} \\
\end{footnotesize}
  \end{block}

} 


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






