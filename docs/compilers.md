# Compiling and Linking with Libraries

!!! note "Objectives"

    - Learn about the compilers at HPC2N
        - How to load the compiler toolchains
        - How to use the compilers
        - What are the popular flags
    - How to link with libraries. 

## Installed compilers

There are compilers available for Fortran 77, Fortran 90, Fortran 95, C, and C++. The compilers can produce both general-purpose code and architecture-specific optimized code to improve performance (loop-level optimizations, inter-procedural analysis and cache optimizations).

## Loading compilers 

!!! note 

    You need to load a compiler suite (and possibly libraries, depending on what you need) before you can compile and link. 

Use <code>ml av</code> to get a list of available <code>compiler toolchains</code> as mentioned in the [modules - compiler toolchains](../modules#compiler__toolchains) section. 

You load a compiler toolchain the same way you load any other module. They are always available directly, without the need to load prerequisites first. 

!!! Hint

    Code-along!

!!! Example "Example: Loading foss/2023b"

    This compiler toolchain contains: <code>GCC/13.2.0</code>, <code>BLAS</code> (with <code>LAPACK</code>, <code>ScaLAPACK</code>, and <code>FFTW</code>. 

    ```bash
    b-an01 [~]$ ml foss/2023b
    b-an01 [~]$ ml

    Currently Loaded Modules:
      1) snicenvironment (S)   7) numactl/2.0.16     13) libevent/2.1.12  19) FlexiBLAS/3.3.1
      2) systemdefault   (S)   8) XZ/5.4.4           14) UCX/1.15.0       20) FFTW/3.3.10
      3) GCCcore/13.2.0        9) libxml2/2.11.5     15) PMIx/4.2.6       21) FFTW.MPI/3.3.10
      4) zlib/1.2.13          10) libpciaccess/0.17  16) UCC/1.2.0        22) ScaLAPACK/2.2.0-fb
      5) binutils/2.40        11) hwloc/2.9.2        17) OpenMPI/4.1.6    23) foss/2023b
      6) GCC/13.2.0           12) OpenSSL/1.1        18) OpenBLAS/0.3.24

      Where:
       S:  Module is Sticky, requires --force to unload or purge

 

    b-an01 [~]$ 
    ```

## Compiling

!!! note 

    **OpenMP**: All compilers has this included, so it is enough to load the module for a specific compiler toolchain and then add the appropriate flag.

!!! note

    If you do not name the executable (with the flag <code>-o SOMENAME</code>, it will be named <code>a.out</code> as default. 

    This also means that the next time you compile something, if you also do not name that executable, it will overwrite the previous <code>a.out</code> file. 

### Compiling with GCC

| **Language** | **Compiler name** | **MPI** | 
| ------------ | ----------------- | ------- | 
| Fortran77 | gfortran | mpif77 |
| Fortran90 | gfortran | mpif90 |
| Fortran95 | gfortran | N/A |
| C | gcc | mpicc | 
| C++ | g++ | mpiCC |

In order to access the MPI compilers, load [a compiler toolchain which contains an MPI library](../modules#compiler__toolchains).  

!!! Hint

    Code-along!

!!! Example "Example: compiling a C program"

    You can find the file <code>hello.c</code> in the exercises directory, in the subdirectory "simple". Or you can download it here: <a href="https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/simple/hello.c" target="_blank">hello.c</a>. 

    In this example we compile the C program <code>hello.c</code> and name the output (the executable) <code>hello</code>. 

    ```bash
    b-an01 [~]$ gcc hello.c -o hello 
    ```

!!! Example "Example: compiling an MPI C program"

    You can find the file <code>mpi_hello.c</code> in the exercises directory, in the subdirectory "simple". Or you can download it here: <a href="https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/simple/mpi_hello.c" target="_blank">mpi_hello.c</a>. 

    In this example we compile the MPI C program <code>mpi_hello.c</code> and name the output (the executable) <code>mpi_hello</code>. 

    ```bash
    b-an01 [~]$ mpicc mpi_hello.c -i mpi_hello 
    ```

#### Flags

!!! note

    List of commonly used flags:

    - **-o file** Place output in file ‘file’.
    - **-c** Compile or assemble the source files, but do not link.
    - **-fopenmp** Enable handling of the OpenMP directives.
    - **-g** Produce debugging information in the operating systems native format.
    - **-O** or **-O1** Optimize. The compiler tried to reduce code size and execution time.
    - **-O2** Optimize even more. GCC performs nearly all supported optimizations that do not involve a space-speed tradeoff.
    - **-O3** Optimize even more. The compiler will also do loop unrolling and function inlining. RECOMMENDED
    - **-O0** Do not optimize. This is the default.
    - **-Os** Optimize for size.
    - **-Ofast** Disregard strict standards compliance. -Ofast enables all -O3 optimizations. It also enables optimizations that are not valid for all standard-compliant programs. It turns on -ffast-math and the Fortran-specific -fno-protect-parens and -fstack-arrays.
    - **-ffast-math** Sets the options **-fno-math-errno**, **-funsafe-math-optimizations**, **-ffinite-math-only**, **-fno-rounding-math**, **-fno-signaling-nans** and **-fcx-limited-range**.
    - **-l library** Search the library named ‘library’ when linking.

!!! Hint

    Code-along!

!!! Example "Example: compiling an OpenMP C program"

    You can find the file <code>omp_hello.c</code> in the exercises directory, in the subdirectory "simple". Or you can download it here: <a href="https://raw.githubusercontent.com/hpc2n/intro-course/master/exercises/simple/omp_hello.c" target="_blank">omp_hello.c</a>. 

    In this example we compile the OpenMP C program <code>omp_hello.c</code> and name the output (executable) <code>omp_hello</code>. 

    ```bash 
    b-an01 [~]$ gcc -fopenmp omp_hello.c -o omp_hello
    ```

!!! note

    You can change the number of threads with <code>export OMP_NUM_THREADS=#threads</code>

!!! Hint

    Code-along!

!!! Example 

    Run the binary <code>omp_hello</code> that we got in the previous example. Set the number of threads to 4 and then rerun the binary. 

    ```bash
    b-an01 [~]$ ./omp_hello 
    Thread 0 says: Hello World
    Thread 0 reports: the number of threads are 1
    b-an01 [~]$ export OMP_NUM_THREADS=4
    b-an01 [~]$ ./omp_hello 
    Thread 1 says: Hello World
    Thread 0 says: Hello World
    Thread 0 reports: the number of threads are 4
    Thread 3 says: Hello World
    Thread 2 says: Hello World
    b-an01 [~]$ 
    ```

### Compiling with Intel 

| **Language** | **Compiler name** | **MPI** | 
| ------------ | ----------------- | ------- | 
| Fortran77 | ifort | mpiifort | 
| Fortran90 | ifort | mpiifort | 
| Fortran95 | ifort | N/A | 
| C | icc | mpiicc |
| C++ | icpc | mpiicc | 

In order to access the MPI compilers, load [a compiler toolchain which contains an MPI library](../modules#compiler__toolchains).                                

!!! Example "Example: compiling a C program"

    We are again compiling the <code>hello.c</code> program from before. This time we name the executable <code>hello_intel</code> to not overwrite the previously created executable. 

    ```bash
    b-an01 [~]$ icc hello.c -o hello 
    ```

#### Flags 

!!! note

    List of commonly used flags:

    - **-fast** This option maximizes speed across the entire program.
    - **-g** Produce symbolic debug information in an object file. The **-g** option changes the default optimization from **-O2** to **-O0**. It is often a good idea to add **-traceback** also, so the compiler generates extra information in the object file to provide source file traceback information.
    - **-debug all** Enables generation of enhanced debugging information. You need to also specify **-g**
    - **-O0** Disable optimizations. Use if you want to be certain of getting correct code. Otherwise use **-O2** for speed.
    - **-O** Same as **-O2**
    - **-O1** Optimize to favor code size and code locality. Disables loop unrolling. **-O1** may improve performance for applications with very large code size, many branches, and execution time not dominated by code within loops. In most cases, **-O2** is recommended over **-O1**.
    - **-O2** (default) Optimize for code speed. This is the generally recommended optimization level.
    - **-O3** Enable **-O2** optimizations and in addition, enable more aggressive optimizations such as loop and memory access transformation, and prefetching. The **-O3** option optimizes for maximum speed, but may not improve performance for some programs and may in some cases even slow down code. 
    - **-Os** Enable speed optimizations, but disable some optimizations that increase code size for small speed benefit.
    - **-fpe{0,1,3}** Allows some control over floating-point exception (divide by zero, overflow, invalid operation, underflow, denormalized number, positive infinity, negative infinity or a NaN) handling for the main program at runtime. Fortran only. 
    - **-qopenmp** Enable the parallelizer to generate multi-threaded code based on the OpenMP directives. 
    - **-parallel** Enable the auto-parallelizer to generate multi-threaded code for loops that can be safely executed in parallel. 

## Linking

### Build environment

Using a compiler toolchain by itself is possible but requires a fair bit of manual work, figuring out which paths to add to **-I** or **-L** for including files and libraries, and similar.

To make life as a software builder easier there is a special module available, <code>buildenv</code>, that can be loaded on top of any toolchain. If it is missing for some toolchain, send a mail to support@hpc2n.umu.se and let us know.

This module defines a large number of environment variables with the relevant settings for the used toolchain. Among other things it sets CC, CXX, F90, FC, MPICC, MPICXX, MPIF90, CFLAGS, FFLAGS, and much more.

To see all of them, **after loading a toolchain** do:

```bash
ml show buildenv
```

To use the environment variables, load buildenv:

```bash
ml buildenv
```

Using the environment variable (prefaced with $) for linking is highly recommended!

!!! Example

    Linking with LAPACK (gcc, C program). 

    ```bash
    gcc -o PROGRAM PROGRAM.c -lflexiblas -lgfortran
    ```

    OR use the environment variable <code>$LIBLAPACK</code>: 

    ```bash
    gcc -o PROGRAM PROGRAM.c $LIBLAPACK
    ```

!!! note

    You can see a list of all the libraries on Kebnekaise (June 2024) here: <a href="https://docs.hpc2n.umu.se/documentation/compiling/#libraries" target="_blank">https://docs.hpc2n.umu.se/documentation/compiling/#libraries</a>. 

!!! Keypoints

    - In order to compile a program, you must first load a "compiler toolchain" module 
    - Kebnekaise has both GCC and Intel compilers installed 
    - The GCC compilers are: 
        - gfortran
        - gcc
        - g++
    - The Intel compilers are: 
        - ifort
        - icc
        - icpc
    - Compiling MPI programs can be done after loading a compiler toolchains which contains MPI libraries 
    - The easiest way to figure out how to link with a library is to use <code>ml show buildenv</code> after loading a compiler toolchain 

