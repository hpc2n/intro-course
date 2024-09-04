#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:20:00
#Number of nodes
#SBATCH -N 1
#Ask for 1 GPU cards
#SBATCH --gpus=l40s:1
# If you ask for 2 GPU cards uncomment the following line
##SBATCH --exclusive

ml GCC/12.3.0 OpenMPI/4.1.5
ml TensorFlow/2.15.1-CUDA-12.1.1

echo "First example hello_tensorflow.py"
python hello_tensorflow.py
echo "     "

echo "Second example loss.py"
python loss.py
echo "     "

echo "Third example mnist_mlp.py" 
python mnist_mlp.py

