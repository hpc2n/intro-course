#include <stdlib.h>
#include <stdio.h>
#include "mpi.h"
 
int main(int argc, char *argv[])
{

MPI_Init(&argc, &argv);
int myRank;
int numProcs;
        MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
        MPI_Comm_size(MPI_COMM_WORLD, &numProcs);
 

        printf("Print ranks on CPU %d \n", myRank);
        print_gpu();

        MPI_Finalize();

        return 0;
}
