# Hands-on exercises. 

---
## Benchmarking a simulation

### 1. MPI 

Go to the MPI folder and run the script job-tune-pme.sh by using different values 
of the nr. of MPI ranks (-n ) and the nr. of OpenMP threads (-c ). One needs to
set these values so that "n x c <= 28" (for a singlenode).

Take a look at the "perf.out" file. The last line will tell you what flags you can
use for running GROMACS efficiently.

More information about what parameters you can tune with tune_pme tool can be found
in: https://manual.gromacs.org/current/onlinehelp/gmx-tune_pme.html


