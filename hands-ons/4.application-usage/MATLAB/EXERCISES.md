REQUIREMENTS: 
   * Prior to running any of the following examples, you need to follow the
   configuration lines for MATLAB:
       
       https://www.hpc2n.umu.se/resources/software/configure-matlab-2018

   * Load the MATLAB module and launch the MATLAB instance: 

   ml MATLAB/2021a

   matlab -singleCompThread

The following folders are included for MATLAB:

   * "SERIAL" contains a function "funct.m" which performs a FFT on a matrix.
   The execution time is obtained with tic/toc and written down in a file called
   "log.out". The script can be run using the MATLAB GUI with the script "submit.m". 

   As an alternative, you can submit the job via a batch script "job.sh". Here,
   you will need to fix the Project_ID with the one provided for the present course.

   * "PARFOR" shows you a parallelized loop with the "parfor" directive. A pause()
   function is included in the loop to make it heavy. This function can be
   submitted to the queue by running the script "submit.m" in the MATLAB GUI.
   The number of workers can be set by replacing the string *FIXME* (in the "submit.m"
   file) with the number you desire. 

   Try different values for the number of workers from 1 to 28 and take a note
   of the simulation time output at the end of the simulation. Where does the
   code achieve its peak performance? 

   * "SPMD" presents an example of a parallelized code using SPMD paradigm. You
   can submit this job to the queue with "sbatch spmd.sh"

   * "GPU" computes a Mandelbrot set both on CPU "mandelcpu.m" and on GPU
   "mandelgpu.m". You can submit the jobs through the MATLAB GUI using the 
   "submit*.m" files. 

   The final output if everything ran well are two .png figures
   which display the timings for both architectures. Use the "eom" command on the
   terminal to visualize the images (eom outputX.png)