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

### Tools for efficient simulations 

Chart flow for a more efficient Matlab code using existing tools (adapted from[^1])

![pctworkflow](images/pctworkflow.png)

### 

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



!!! Keypoints "Keypoints" 

    - The software on Kebnekaise is mostly accessed through the module system.

## References

[^1]: <a href="https://se.mathworks.com/help/parallel-computing/choosing-a-parallel-computing-solution.html" target="_blank">MathWorks documentation on Parallel Computing</a>
