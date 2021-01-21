#!/bin/bash
#SBATCH -A Project_ID 
#Asking for 5 min.
#SBATCH -t 00:05:00
#Number of nodes
#SBATCH -N 1
#SBATCH --exclusive
#Ask for 2 GPU cards
#SBATCH --gres=gpu:k80:2

export OMPI_MCA_mpi_warn_on_fork=0
ml GCC/8.2.0-2.31.1  CUDA/10.1.105  OpenMPI/3.1.3
ml TensorFlow/1.14.0-Python-3.7.2

echo "First example hello_tensorflow.py"
python hello_tensorflow.py

echo "Second example loss.py"
python loss.py

echo "Third example mnist_mlp.py" 
ml Keras/2.2.4-Python-3.7.2
python mnist_mlp.py


