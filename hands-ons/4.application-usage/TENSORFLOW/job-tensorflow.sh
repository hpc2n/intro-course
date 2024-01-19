#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#Number of nodes
#SBATCH -N 1
#Ask for 1 GPU cards
#SBATCH --gres=gpu:v100:1
# If you ask for 2 GPU cards uncomment the following line
##SBATCH --exclusive

ml GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
ml TensorFlow/2.4.1 

echo "First example hello_tensorflow.py"
python hello_tensorflow.py
echo "     "

echo "Second example loss.py"
python loss.py
echo "     "

echo "Third example mnist_mlp.py" 
ml Keras/2.4.3 
python mnist_mlp.py

