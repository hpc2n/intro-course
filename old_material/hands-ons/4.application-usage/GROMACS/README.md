# GROMACS test cases provided in this folder are:

   * "GPU" folder, here the job can be submitted with "sbatch job-gpu-gromacs.sh"
   At the end of the script you can find three ways to run GROMACS :

     mpirun -np $SLURM_NTASKS gmx_mpi mdrun $mdargs -dlb yes  -v -deffnm step4.1_equilibration
     mpirun -np $SLURM_NTASKS gmx_mpi mdrun -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration
     gmx mdrun -ntmpi $SLURM_NTASKS -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration

   in general, the last two perform better than the default option. 

   An example is included for running efficient simulations on our recently deployed AMD GPU nodes. The "step4.1_equilibration-amd.mdp" 
   script has some differences w.r.t. to the previous script "step4.1_equilibration.mdp" mainly in the type of thermostat, which is
   set to "v-rescale" in the former. The batch script for running on the AMD GPU nodes is "job-gpu-gromacs-amd.sh". 

   * "MPI" folder, there is a script to run GROMACS using MPI "sbatch job-mpi-gromacs.sh"

      - For GROMACS, it is always recommended to do a profiling analysis before
     you run long production simulations. A sample script for doing that with "tune_pme"
     is provided and it can be submitted with "sbatch job-tune-pme.sh". Take a look at the
     output "perf.out". 

   * "VSITES" folder, here two different setups of the same system are provided one by using
     the classical molecular dynamics and the the other by using virtual sites which allows 
     to use a longer time step. Submit the jobs in each folder with "sbatch job*.sh" 

