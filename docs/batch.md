# The Batch System (SLURM)  

!!! Objectives

    - Get information about what a batch system is and which one is used at HPC2N.
    - Learn basic commands for the batch system used at HPC2N. 
    - How to create a basic batch script. 
    - Managing your job: submitting, status, cancelling, checking... 
    - Learn how to allocate specific parts of Kebnekaise: skylake, zen3/zen4, GPUs... 

- Large/long/parallel jobs **must** be run through the batch system.
- Kebnekaise is running <a href="http://slurm.schedmd.com/" target="_blank">Slurm</a>. 
- Slurm is an Open Source job scheduler, which provides three key functions.
    - Keeps track of available system resources.
    - Enforces local system resource usage and job scheduling policies. 
    - Manages a job queue, distributing work across resources according to policies. 
- In order to run a batch job, you need to create and submit a SLURM submit file (also called a batch submit file, a batch script, or a job script).

!!! Note

    Guides and documentation for the batch system at HPC2N here at: <a href="https://docs.hpc2n.umu.se/documentation/batchsystem/intro/" target="_blank">HPC2N's batch system documentation</a>. 

## Basic commands

Using a job script is often recommended. 

- If you ask for the resources on the command line, you will wait for the program to run before you can use the window again (unless you can send it to the background with &).
- If you use a job script you have an easy record of the commands you used, to reuse or edit for later use.

!!! NOTE

    When you submit a job, the system will return the Job ID. You can also get it with ``squeue -me``. See below. 

In the following, JOBSCRIPT is the name you have given your job script and JOBID is the job ID for your job, assigned by Slurm. USERNAME is your username. 

- **Submit job**: ``sbatch JOBSCRIPT`` 
- **Get list of your jobs**: ``squeue -u USERNAME`` or ``squeue --me``
- **Give the Slurm commands on the command line**: ``srun commands-for-your-job/program`` 
- **Check on a specific job**: ``scontrol show job JOBID`` 
- **Delete a specific job**: ``scancel JOBID``
- **Delete all your own jobs**: ``scancel -u USERNAME``
- **Request an interactive allocation**: ``salloc -A PROJECT-ID .......`` 
    - Note that you will still be on the login node when the prompt returns and you MUST preface with ``srun`` to run on the allocated resources.
    - I.e. ``srun MYPROGRAM``
- **Get more detailed info about jobs**: <br>``sacct -l -j JOBID -o jobname,NTasks,nodelist,MaxRSS,MaxVMSize``
    - More flags etc. can be found with ``man sacct``
    - The output will be **very** wide. To view in a friendlier format, use <br>``sacct -l -j JOBID -o jobname,NTasks,nodelist,MaxRSS,MaxVMSize | less -S`` 
        - this makes it sideways scrollable, using the left/right arrow key
- Web url with graphical info about a job: ``job-usage JOBID``
- More information: ``man sbatch``, ``man srun``, ``man ....``

!!! Example 

    Submit job with ``sbatch``

    ```bash
    b-an01 [~]$ sbatch simple.sh 
    Submitted batch job 27774852
    ```

    Check status with ``squeue --me``

    ```bash
    b-an01 [~]$ squeue --me
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          27774852  cpu_zen4 simple.s bbrydsoe  R       0:00      1 b-cn1701
    ``` 

    Submit several jobs (here several instances of the same), check on the status

    ```bash
    b-an01 [~]$ sbatch simple.sh 
    Submitted batch job 27774872
    b-an01 [~]$ sbatch simple.sh 
    Submitted batch job 27774873
    b-an01 [~]$ sbatch simple.sh 
    Submitted batch job 27774874
    b-an01 [~]$ squeue --me
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             27774873  cpu_zen4 simple.s bbrydsoe  R       0:02      1 b-cn1702
             27774874  cpu_zen4 simple.s bbrydsoe  R       0:02      1 b-cn1702
             27774872  cpu_zen4 simple.s bbrydsoe  CG      0:04      1 b-cn1702
   ``` 

    The status "R" means it is running. "CG" means completing. When a job is pending it has the state "PD". 

    In these examples the jobs all ended up on nodes in the partition cpu_zen4. We will soon talk more about different types of nodes. 

!!! NOTE

    The output file from the job run will default be named ``slurm-JOBID.out``. It will contain both output as well as any errors. You can look at the content with ``vi``, ``nano``, ``emacs``, ``cat``, ``less``...

    The exception is if your program creates its own output files, or if you name the output file(s) differently within your jobscript. 

    You can use Slurm commands within your job script to split the error and output in separate files, and name them as you want. It is highly recommended to include the environment variable ``%J`` (the job ID) in the name, as that is an easy way to get a new name for each time you run the script and thus avoiding the previous output being overwritten. 

    Example, using the environment variable ``%J``: 

    - Error file: ``#SBATCH --error=job.%J.err`` 
    - Output file: ``#SBATCH --output=job.%J.out``

## Using the different parts of Kebnekaise 

As mentioned under the introduction, Kebnekaise is a very heterogeneous system, comprised of several different types of CPUs and GPUs. The batch system reflects these several different types of resources. 

At the top we have partitions, which are similar to queues. Each partition is made up of a specific set of nodes. At HPC2N we have three classes of partitions, one for CPU-only nodes, one for GPU nodes and one for large memory nodes. Each node type also has a set of features that can be used to select which node(s) the job should run on.

The three types of nodes also have corresponding resources one must apply for in SUPR to be able to use them.

While Kebnekaise has multiple partitions, one for each major type of resource, there is only a single partition, ``batch``, that users can submit jobs to. The system then figures out which partition(s) the job should be sent to, based on the requested features. 

!!! NOTE "Node overview" 

    The "selector" can be used if you need a specific type of node. More about that later. 

    **CPU-only nodes**

    | Type | Memory/core | number nodes | Selector | 
    | ---- | ----------- | ------------ | -------- |
    | 2 x 14 core Intel broadwell | 4460 MB | 48 | broadwell (intel_cpu) |
    | 2 x 14 core Intel skylake | 6785 MB | 52 | skylake (intel_cpu) | 
    | 2 x 64 core AMD zen3 | 8020 MB | 1 | zen3 (amd_cpu) | 
    | 2 x 128 core AMD zen4 | 2516 MB | 8 | zen4 (amd_cpu) | 

    **GPU enabled nodes**

    | Type | Memory/core | GPU card | number nodes | Selector | 
    | ---- | ----------- | -------- | ------------ | -------- | 
    | 2 x 14 core Intel broadwell | 9000 MB | 2 x Nvidia A40 | 4 | a40 | 
    | 2 x 14 core Intel skylake | 6785 MB | 2 x Nvidia V100 | 10 | v100 | 
    | 2 x 24 core AMD zen3 | 10600 MB | 2 x Nvidia A100 | 2 | a100 | 
    | 2 x 24 core AMD zen3 | 10600 MB | 2 x AMD MI100 | 1 | mi100 | 
    | 2 x 24 core AMD zen4 | 6630 MB | 2 x Nvidia A6000 | 1 | a6000 | 
    | 2 x 24 core AMD zen4 | 6630 MB | 2 x Nvidia L40s | 10 | l40s | 
    | 2 x 48 core AMD zen4 | 6630 MB | 4 x Nvidia H100 SXM5 | 2 | h100 | 

    **Large memory nodes**
 
    | Type | Memory/core | number nodes | 
    | ---- | ----------- | ------------ | 
    | 4 x 18 core Intel broadwell | 41666 MB | 8 | 

### Requesting features

To make it possible to target nodes in more detail there are a couple of features defined on each group of nodes. To select a feature one can use the ``-C`` option to ``sbatch`` or ``salloc``. This sets *constraints* on the job.

There are several reasons why one might want to do that, including for benchmarks, to be able to replicate results (in some cases), because specific modules are only available for certain architectures, etc. 

To constrain a job to a certain feature, use 

```bash
#SBATCH -C SELECTOR

!!! note 

    Features can be combined using “and” (``&``) or “or” (``|``). They should be wrapped in ``'``'s. 

List of constraints: 

!!! Note "For selecting type of CPU"

    SELECTOR is:

    intel_cpu
    broadwell
    skylake
    amd_cpu
    zen3
    zen4

!!! Note "For selecting type of GPU"

    SELECTOR is:

    v100
    a40
    a6000
    a100
    l40s
    h100
    mi100

For GPUs, the above GPU selector list of constraints can be used either as a specifier to ``--gpu=type:number`` or as a constraint together with an unspecified gpu request ``--gpu=number``.

!!! Note "For selecting GPUs with certain features"

    SELECTOR is: 
  
    nvidia_gpu (Any Nvidia GPU)
    amd_gpu (Any AMD GPU)
    GPU_SP (GPU with single precision capability)
    GPU_DP (GPU with double precision capability)
    GPU_AI (GPU with AI features, like half precisions and lower)
    GPU_ML (GPU with ML features, like half precisions and lower)

!!! Note "For selecting large memory nodes"

    SELECTOR is: 

    largemem

#### Examples 

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

#### Requesting GPUs

To use GPU resources one has to explicitly ask for one or more GPUs. Requests for GPUs can be done either in total for the job or per node of the job.

```bash
#SBATCH --gpus=1
```

or

```bash
#SBATCH --gpus-per-node=1
```

As mentioned about, for GPUs, constraints can be used either as a specifier to ``--gpu=type:number`` or as a constraint together with an unspecified gpu request ``--gpu=number``.

```bash
#SBATCH --gpus=SELECTOR:NUMBER
```

where SELECTOR is (like in the table above): 

- v100
- a40
- a6000
- a100
- l40s
- h100
- mi100



   \begin{block}{}
     \begin{scriptsize}
       \begin{itemize}
     \item Use the 'fat' nodes by adding this flag to your script: \\ 
 \texttt{\#SBATCH -p largemem} (separate resource) \\
     \item  Specifying Intel Broadwell, Intel Skylake, or AMD Zen3 CPUs: \\ 
 \texttt{\#SBATCH --constraint=broadwell} \\
 or \\
 \texttt{\#SBATCH --constraint=skylake} \\
 or \\
 \texttt{\#SBATCH --constraint=zen3} \\
     \item Using the GPU nodes (separate resource): \\ 
       \texttt{\#SBATCH --gres=gpu:$<$type-of-card$>$:x} where $<$type-of-card$>$ is either k80, v100, or a100 and x = 1, 2, or 4 (4 only for K80). \\
       \begin{itemize}
     \begin{scriptsize}
       \item In the case of the A100 GPU nodes, you also need to add a partition \\
         \texttt{\#SBATCH -p amd\_gpu}
     \end{scriptsize}
         \end{itemize}
       \item Use the AMD login node for correct modules and compilers for AMD Zen3 and A100 nodes: \\ \texttt{kebnekaise-amd-tl.hpc2n.umu.se} or \\\texttt{kebnekaise-amd.hpc2n.umu.se}
    \end{itemize}
 More on https://www.hpc2n.umu.se/documentation/guides/using\_kebnekaise
     \end{scriptsize}
   \end{block}
 }


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






