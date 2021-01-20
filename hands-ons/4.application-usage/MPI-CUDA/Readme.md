# Loading modules

ml purge
ml fosscuda/2019b buildenv 

# Compiling and linking
mpicc -c main.c -o main.o
nvcc -c print.cu -o print.o
mpicc main.o print.o -lcuda -lcudart -lstdc++ -o exe 

# Running the code using 2 MPI ranks

srun --account=projec_ID --exclusive -n2 --gres=gpu:v100:2,gpuexcl --time=00:02:00 ./exe

