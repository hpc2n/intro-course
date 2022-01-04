# REQUIREMENTS: 
   * Prior to running any of the following examples, you need to follow the
   configuration lines for MATLAB:
       
       https://www.hpc2n.umu.se/resources/software/configure-matlab-2018

   * Load the MATLAB module and launch the MATLAB instance: 

   ml MATLAB/2021b

   matlab -singleCompThread


## 1. EXERCISE - MATLAB SERIAL
   The folder SERIAL contains a function **funct.m** which performs a FFT on a matrix.
   The execution time is obtained with tic/toc and written down in the output file called
   **log.out**. Run the function **funct.m** by  using the MATLAB GUI with the help
   of the script **submit.m**. 

   As an alternative, you can submit the job via a batch script **job.sh**. Here,
   you will need to fix the Project_ID with the one provided for the present course.

## 2. EXERCISE - MATLAB PARALLEL

   * "PARFOR" contains an example of a parallelized loop with the "parfor" directive. A pause()
   function is included in the loop to make it heavy. This function can be
   submitted to the queue by running the script "submit.m" in the MATLAB GUI.
   The number of workers can be set by replacing the string *FIXME* (in the "submit.m"
   file) with the number you desire. 

   Try different values for the number of workers from 1 to 28 and take a note
   of the simulation time output at the end of the simulation. Where does the
   code achieve its peak performance? 

   * "SPMD" presents an example of a parallelized code using SPMD paradigm. You
   can submit this job to the queue through the MATLAB GUI.

## 3. EXERCISE - MATLAB GPU

   * "GPU" folder contains a test case that computes a Mandelbrot set both 
   on CPU **mandelcpu.m** and on GPU **mandelgpu.m**. You can submit the jobs through 
   the MATLAB GUI using the "submitX.m" files (X=cpu,gpu). 

   The final output if everything ran well are two .png figures
   which display the timings for both architectures. Use the "eom" command on the
   terminal to visualize the images (eom out-X.png)
