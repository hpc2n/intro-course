# Application examples

## Matlab

### How to find Matlab 

Matlab is available through the Menu bar if you are using ThinLinc client (recommended). Additionally, you can load 
a Matlab module on a Linux terminal on Kebnekaise. Details for these two options can be found 
[here](https://www.hpc2n.umu.se/resources/software/matlab){:target="_blank"}. 

### First time configuration

The first time you access Matlab on Kebnekaise, you need to configure it by following these guidelines 
[Configuring Matlab](https://www.hpc2n.umu.se/resources/software/configure-matlab-2018){:target="_blank"}. After configuring the cluster, it is a good practice to validate the
cluster (HOME -> Parallel -> Create and Manage Clusters):

![clustervalidation](images/clusterProfileManager.png)

Notice that it is recommended to use a small number of workers for the validation, in this case 4. 

!!! Warning "Kebnekaise is only open for local project requests!" 

    - The PI must be affiliated with UmU, LTU, IRF, MiUN, or SLU.
    - You can still add members (join) from anywhere.


### Tools for efficient simulations 

Chart flow for a more efficient Matlab code using existing tools (adapted from[^1])

![pctworkflow](images/pctworkflow.png)

!!! Warning "Use MATLAB for lightweight tasks on the login nodes" 

    Remember that login nodes are used by many users and if you run heavy jobs there,
    you will interfere with the workflow of them.

### Exercises

!!! Note "Exercise 1: Matlab serial job"
 
    The folder SERIAL contains a function [funct.m](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/SERIAL/funct.m){:target="_blank"} 
    which performs a FFT on a matrix.
    The execution time is obtained with tic/toc and written down in the output file called
    **log.out**. Run the function by using the MATLAB GUI with the help of the script [submit.m](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/SERIAL/submit.m){:target="_blank"}.

    As an alternative, you can submit the job via a batch script 
    [job.sh](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/SERIAL/job.sh){:target="_blank"}. 
    Here, you will need to fix the Project_ID with the one provided for the present course and the Matlab version.


!!! Note "Exercise 2: Matlab parallel job"

    * PARFOR folder contains an [example](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/PARFOR/parallel_example.m){:target="_blank"} of a parallelized loop with the "parfor" directive. A pause()
    function is included in the loop to make it heavy. This function can be
    submitted to the queue by running the script [submit.m](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/PARFOR/submit.m){:target="_blank"} in the MATLAB GUI.
    The number of workers can be set by replacing the string *FIXME* (in the "submit.m"
    file) with the number you desire. 
      Try different values for the number of workers from 1 to 10 and take a note
      of the simulation time output at the end of the simulation. Where does the
      code achieve its peak performance? 

    * SPMD folder presents an example of a parallelized code using [SPMD](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/SPMD/spmdex.m){:target="_blank"} paradigm. Submit this job to the queue through the MATLAB GUI. This
    example illustrates the use of *parpool* to run parallel code in a more interactive manner.

!!! Note "Exercise 3: Matlab GPU job"

    GPU folder contains a test case that computes a Mandelbrot set both 
    on CPU [mandelcpu.m](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/GPU/mandelcpu.m){:target="_blank"} 
    and on GPU [mandelgpu.m](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/GPU/mandelgpu.m){:target="_blank"}. You can submit the jobs through 
    the MATLAB GUI using the [submitcpu.m](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/GPU/submitcpu.m){:target="_blank"} and [submitgpu.m](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/MATLAB/GPU/submitgpu.m){:target="_blank"}  files. 

    The final output if everything ran well are two .png figures
    which display the timings for both architectures. Use the "eom" command on the
    terminal to visualize the images (eom out-X.png)

## R

### How to find Matlab 

Similar to Matlab, R is available through the Menu bar if you are using ThinLinc client (recommended). Additionally, you can load 
a Matlab module on a Linux terminal on Kebnekaise. Details for these two options can be found 
[here](https://www.hpc2n.umu.se/resources/software/r){:target="_blank"}. 

### First time configuration

The first time you access R on Kebnekaise, you need to configure it by following the 
[Preparations](https://www.hpc2n.umu.se/resources/software/user_installed/r){:target="_blank"} step.


!!! Warning "Use R for lightweight tasks on the login nodes" 

    Remember that login nodes are used by many users and if you run heavy jobs there,
    you will interfere with the workflow of them.

### Exercises

??? important

    Prior to running the examples, you will need to install several packages.
    Follow these instructions:

       https://www.hpc2n.umu.se/resources/software/user_installed/r

    * The packages needed are:

        For this R version (check if they are not already installed)

        ml GCC/10.2.0  OpenMPI/4.0.5
        ml R/4.0.4

        Rmpi
        doParallel
        caret
        MASS
        klaR
        nnet
        e1071
        rpart
        mlbench
        parallel

!!! Note "Exercise 1: R serial job"

   In the SERIAL folder, a [serial](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/R/SERIAL/serial.R){:target="_blank"} is provided. Submit the script 
   [job.sh](https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/R/SERIAL/job.sh){:target="_blank"} with the command *R CMD* and also with *Rscript*. Where could
   it be more suitable to use *Rscript*?

   2) "Job-Arrays" folder shows an example for job arrays batch file. Submit the
   script and take a look at the output.

   3) In the folder "Rmpi", you can find the R script "Rmpi_1.R" which uses 5
   MPI slaves to apply the runif() function on an array "c". Submit this job
   with "sbatch job_Rmpi_1.sh". As a result, you will see the random numbers
   generated by the slaves in the slurm output file

   Two other examples for Rmpi are shown in Rmpi_2.R and Rmpi_3.R with the
   corresponding batch jobs job_Rmpi_2.sh and job_Rmpi_3.sh, respectively.

   4) The folder "doParallel" contains two examples:
       1. doParallel.R shows how to use the "foreach" function in sequential mode
       (1 core) and the parallel mode using 4 cores. The differences in the
       call to "foreach" for  are basically:
             --- the cluster initialization: makeCluster, registerDoParallel
             --- the use of %dopar% instead of %do%
          
          submit the **job_doParallel.sh** script and compare the timings of the
          sequential and parallel codes.

       2. doParallel_ML.R presents the evaluation of several ML models in both
       sequential and parallel modes using the standard "iris" database. The 
       difference is basically in the use of %dopar% instead of %do% function. 

          submit the job with "sbatch job_doParallel_ML.sh" 

       In the output file observe the resulting elapsed times for the sequential
       and the 4 cores parallel simulation.

       Upon submitting the job to the queue you will get a number called job ID.
       Use the command 

       job-usage job_ID

       to obtain a URL which you can copy/paste in your local browser. Tip: refresh
       your browser several times to get the statistics. 

       Can you see how the CPU is used? What about the memory?


       Note 1: In order to run this exercise, you need to have all the packages 
       listed at the beginning of this document installed. 
       Note 2: If you want to try a different number of cores for running the 
       scripts, you should change that number in both the *.R and *.sh scripts


   5) In the folder "MachineLearning" we show a single ML model using a sonar database
   together with Random Forest. The simulations are done in serial mode and parallel
   mode. You may change the values for the number of cores (1 in the present case) 
   to other values. Notice that the number of cores needs to be the same in the
   files job.sh and  Rscript.R. 

   Try a different number of cores and monitor the timings which are reported at
   the end of the output file.




!!! Keypoints "Keypoints" 

    - The software on Kebnekaise is mostly accessed through the module system.

## References

[^1]: <a href="https://se.mathworks.com/help/parallel-computing/choosing-a-parallel-computing-solution.html" target="_blank">MathWorks documentation on Parallel Computing</a>
