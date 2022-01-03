# Hands-on exercises. 

---
## 0. NOTES

The reservation is only valid during the course and is commented out due to this in the job examples. If you are running this during the course, you can add the reservation and/or remove the out-commenting. 

See the file README.md for help and hints. That file also contains information about the various examples, including how to compile and run them. 


## 1. EXERCISE - RUNNING AMBER

Run the script **job-mpi-pmemd.sh** as it is and see the performance
of the simulation (average number of nanoseconds per day) in the file 
 **03_Prod.mdout** (at the bottom of the file).

Job submission command:  *sbatch job-mpi-pmemd.sh*

## 2. EXERCISE - OPTIMAL PERFORMANCE OF AMBER PMEMD

Run the script **job-mpi-pmemd.sh** for a different number of MPI tasks
(-n) and number of nodes (-N) and obtain the value for the 
performance of AMBER (as a function of the number of cores). 
The performance of AMBER can be obtained from the average
number of nanoseconds per day (ns/day) in the file **03_Prod.mdout**.

A plot of the number of ns/day vs. number of cores can help you to
visualize the results. Is it worth it to go from 14 cores to 28 cores?
What about going from 28 cores to 42 cores? Or even from 42 cores to 
56 cores?

## 3. EXERCISE - OPTIMAL PERFORMANCE OF AMBER CUDA

Run the script **job-gpu-pmemd.sh** for a different number of MPI tasks
(-n) and obtain the value for the performance of AMBER (as a function of the number of cores). 
You are encourage to plot the average number of ns/day vs. number of cores as in the
previous case. What is the optimal value for the number of MPI tasks?

## 4. EXERCISE - MONITORING YOUR JOB

Change the number of steps (nstlim) to 100000 in the file **03_Prod.in**.
Also, set the number of cores (-n) to 28 (1 node) and the time (-t) to
15 min in the file **job-mpi-pmemd.sh**. By submitting the job
to the queue with **sbatch job-mpi-pmemd.sh** you get a number as output, this number
is the job ID. On the command line, type **job-usage job_ID**. This will
generate a URL that you can copy/paste to your local browser to monitor
the efficiency of your simulation. How efficient is it in your case?

Hint: on the top right corner you can change the update frequency of the
plots from 15m to 1m for instance. It takes a few minutes before you can
see the results on the plots.



