/******************************************************************************
*   The master thread forks a parallel region. Each of the threads will
*   obtain an unique thread number which they will then print, except      
*   for the master, which does only print the total number of threads.    
******************************************************************************/
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {

  int nthreads, thread_id;

/* Fork the threads and give them their own copy of the variables */
#pragma omp parallel private(nthreads, thread_id)
  {
    
    /* Get the thread number */
    thread_id = omp_get_thread_num();
    printf("Thread %d says: Hello World\n", thread_id);

    if (thread_id == 0)     /* This is only done by the master */
      {
	nthreads = omp_get_num_threads();
	printf("Thread %d reports: the number of threads are %d\n", thread_id, nthreads);
      }
    
  }  /* Now all threads join master thread and they are disbanded */
  
}


