#include <stdlib.h>
#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>
 
 __global__ void __print_kernel__ ()
 {
    printf("GPU says, Hello world! \n");
 }
 
 extern "C" void print_gpu()
{
int nDevices; 

     cudaGetDeviceCount(&nDevices);
     printf("Nr. GPUs %d \n", nDevices);

     __print_kernel__ <<<1,1>>> ();

     cudaDeviceSynchronize();
}
