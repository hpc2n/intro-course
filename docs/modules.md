# The Module System (Lmod)

!!! note "Objectives"

    - Learn the basics of the module system which is used to access most of the software on Kebnekaise
    - Try some of the most used commands for the module system: 
        - find/list software modules
        - load/unload software modules
    - Learn about compiler toolchains 

Most programs are accessed by first loading them as a 'module'. 

Modules are: 

- used to set up your environment (paths to executables, libraries, etc.) for using a particular (set of) software package(s) 
- a tool to help users manage their Unix/Linux shell environment, allowing groups of related environment-variable settings to be made or removed dynamically 
- allows having multiple versions of a program or package available by just loading the proper module 
- are installed in a hierarchial layout. This means that some modules are only available after loading a specific compiler and/or MPI version. 

## Useful commands (Lmod)

- See which modules exists: 
    - <code>module spider</code> or <code>ml spider</code>
- See which versions exist of a specific module:
    - <code>module spider MODULE</code> or <code>ml spider MODULE</code>
- See prerequisites and how to load a specfic version of a module: 
    - <code>module spider MODULE/VERSION</code> or <code>ml spider MODULE/VERSION</code>
- List modules depending only on what is currently loaded: 
    - <code>module avail</code> or <code>ml av</code>
- See which modules are currently loaded: 
    - <code>module list</code> or <code>ml</code>
- Loading a module: 
    - <code>module load MODULE</code> or <code>ml MODULE</code> 
- Loading a specific version of a module: 
    - <code>module load MODULE/VERSION</code> or <code>ml MODULE/VERSION</code>
- Unload a module:
    - <code>module unload MODULE</code> or <code>ml -MODULE</code>
- Get more information about a module: 
    - <code>ml show MODULE</code> or <code>module show MODULE</code>
- Unload all modules except the 'sticky' modules:
    - <code>module purge</code> or <code>ml purge</code>

!!! Warning "Important!" 

    Not all the modules (and versions) are the same on the skylake nodes and the zen3/zen4 nodes. 

    The regular login node ``kebnekaise.hpc2n.umu.se`` has the modules available on skylake nodes. (ThinLinc: ``kebnekaise-tl.hpc2n.umu.se``)

    In order to check if a module is available on the zen3/zen4 nodes, login to ``kebnekaise-amd.hpc2n.umu.se``. (ThinLinc: ``kebnekaise-amd-tl.hpc2n.umu.se``). 

!!! Hint "Hint"

    Code-along! You should do this in a terminal (either regular SSH or terminal opened in ThinLinc). 

??? Admonition "Example: checking which versions exist of the module 'Python' on the regular login node"

    ```bash
    b-an01 [~]$ ml spider Python

    ---------------------------------------------------------------------------------------------------------
      Python:
    ---------------------------------------------------------------------------------------------------------
        Description:
          Python is a programming language that lets you work more quickly and integrate your systems more effectively.

         Versions:
            Python/2.7.15
            Python/2.7.16
            Python/2.7.18-bare
            Python/2.7.18
            Python/3.7.2
            Python/3.7.4
            Python/3.8.2
            Python/3.8.6
            Python/3.9.5-bare
            Python/3.9.5
            Python/3.9.6-bare
            Python/3.9.6
            Python/3.10.4-bare
            Python/3.10.4
            Python/3.10.8-bare
            Python/3.10.8
            Python/3.11.3
            Python/3.11.5
         Other possible modules matches:
            Biopython  Boost.Python  Brotli-python  GitPython  IPython  Python-bundle-PyPI  flatbuffers-python  ...

    ---------------------------------------------------------------------------------------------------------
      To find other possible module matches execute:

          $ module -r spider '.*Python.*'

    ---------------------------------------------------------------------------------------------------------
      For detailed information about a specific "Python" package (including how to load the modules) use the module's full name.
      Note that names that have a trailing (E) are extensions provided by other modules.
      For example:

         $ module spider Python/3.11.5
    ---------------------------------------------------------------------------------------------------------

 

    b-an01 [~]$ 
    ```

??? Admonition "Example: Check how to load a specific Python version (3.11.5 in this example) on the regular login node"

    ```bash 
    b-an01 [~]$ ml spider Python/3.11.5

    ---------------------------------------------------------------------------------------------------------
      Python: Python/3.11.5
    ---------------------------------------------------------------------------------------------------------
        Description:
          Python is a programming language that lets you work more quickly and integrate your systems more effectively.

        You will need to load all module(s) on any one of the lines below before the "Python/3.11.5" module is available to load.

          GCCcore/13.2.0
 
        This module provides the following extensions:

           flit_core/3.9.0 (E), packaging/23.2 (E), pip/23.2.1 (E), setuptools-scm/8.0.4 (E), setuptools/68.2.2 (E), tomli/2.0.1 (E), typing_extensions/4.8.0 (E), wheel/0.41.2 (E)

        Help:
          Description
          ===========
          Python is a programming language that lets you work more quickly and integrate your systems more effectively.
      
          More information
          ================
           - Homepage: https://python.org/
      
      
          Included extensions
          ===================
          flit_core-3.9.0, packaging-23.2, pip-23.2.1, setuptools-68.2.2, setuptools-
          scm-8.0.4, tomli-2.0.1, typing_extensions-4.8.0, wheel-0.41.2
      


 

    b-an01 [~]$ 
    ```

??? Admonition "Example: Load Python/3.11.5 and its prerequisite(s) (on the regular login node)"

    Here we also show the loaded module before and after the load. For illustration, we use first <code>ml</code> and then <code>module list</code>:

    ```bash
    b-an01 [~]$ ml

    Currently Loaded Modules:
      1) snicenvironment (S)   2) systemdefault (S)

     Where:
       S:  Module is Sticky, requires --force to unload or purge

 

    b-an01 [~]$ module load GCCcore/13.2.0 Python/3.11.5
    b-an01 [~]$ module list

    Currently Loaded Modules:
      1) snicenvironment (S)   4) zlib/1.2.13     7) ncurses/6.4      10) SQLite/3.43.1  13) OpenSSL/1.1
      2) systemdefault   (S)   5) binutils/2.40   8) libreadline/8.2  11) XZ/5.4.4       14) Python/3.11.5
      3) GCCcore/13.2.0        6) bzip2/1.0.8     9) Tcl/8.6.13       12) libffi/3.4.4

      Where:
       S:  Module is Sticky, requires --force to unload or purge

 

    b-an01 [~]$ 
    ```

??? Admonition "Example: Unloading the module <code>Python/3.11.5</code> (on the regular login node)"

    In this example we unload the module <code>Python/3.11.5</code>, but not the prerequisite <code>GCCcore/13.2.0</code>. We also look at the output of <code>module list</code> before and after. 

    ```bash
    b-an01 [~]$ module list

    Currently Loaded Modules:
      1) snicenvironment (S)   4) zlib/1.2.13     7) ncurses/6.4      10) SQLite/3.43.1  13) OpenSSL/1.1
      2) systemdefault   (S)   5) binutils/2.40   8) libreadline/8.2  11) XZ/5.4.4       14) Python/3.11.5
      3) GCCcore/13.2.0        6) bzip2/1.0.8     9) Tcl/8.6.13       12) libffi/3.4.4

      Where:
       S:  Module is Sticky, requires --force to unload or purge

 
    b-an01 [~]$ ml unload Python/3.11.5
    b-an01 [~]$ module list

    Currently Loaded Modules:
      1) snicenvironment (S)   2) systemdefault (S)   3) GCCcore/13.2.0

      Where:
       S:  Module is Sticky, requires --force to unload or purge

 

    b-an01 [~]$ 
    ``` 

    As you can see, the prerequisite did not get unloaded. This is on purpose, because you may have other things loaded which uses the prerequisite. 

??? Admonition "Example: unloading every module you have loaded, with <code>module purge</code> except the 'sticky' modules (some needed things for the environment) (on the regular login node)"
 
    First we load some modules. Here Python 3.11.5, SciPy-bundle, and prerequisites for them. We also do <code>module list</code> after loading the modules and after using <code>module purge</code>. 

    ```bash
    b-an01 [~]$ ml GCC/13.2.0 
    b-an01 [~]$ ml Python/3.11.5 ml SciPy-bundle/2023.11 
    b-an01 [~]$ ml list

    Currently Loaded Modules:
      1) snicenvironment (S)   7) bzip2/1.0.8      13) libffi/3.4.4     19) cffi/1.15.1
      2) systemdefault   (S)   8) ncurses/6.4      14) OpenSSL/1.1      20) cryptography/41.0.5
       3) GCCcore/13.2.0        9) libreadline/8.2  15) Python/3.11.5    21) virtualenv/20.24.6
       4) zlib/1.2.13          10) Tcl/8.6.13       16) OpenBLAS/0.3.24  22) Python-bundle-PyPI/2023.10
       5) binutils/2.40        11) SQLite/3.43.1    17) FlexiBLAS/3.3.1  23) pybind11/2.11.1
       6) GCC/13.2.0           12) XZ/5.4.4         18) FFTW/3.3.10      24) SciPy-bundle/2023.11

      Where:
       S:  Module is Sticky, requires --force to unload or purge



    b-an01 [~]$ ml purge
    The following modules were not unloaded:
      (Use "module --force purge" to unload all):

      1) snicenvironment   2) systemdefault
    b-an01 [~]$ ml list

    Currently Loaded Modules:
      1) snicenvironment (S)   2) systemdefault (S)

      Where:
       S:  Module is Sticky, requires --force to unload or purge

 

    b-an01 [~]$ 
    ```

!!! NOTE 

    - You can do several <code>module load</code> on the same line. Or you can do them one at a time, as you want.
        - The modules have to be loaded in order! You cannot list the prerequisite after the module that needs it! 
    - One advantage to loading modules one at a time is that you can then find compatible modules that depend on that version easily. 
        - Example: you have loaded <code>GCC/13.2.0</code> and <code>Python/3.11.5</code>. You can now do <code>ml av</code> to see which versions of other modules you want to load, say SciPy-bundle, are compatible. If you know the name of the module you want, you can even start writing <code>module load SciPy-bundle/</code> and press <code>TAB</code> - the system will then autocomplete to the compatible one(s). 

!!! Exercise

    Login to ``kebnekaise-amd`` (can be easily done with ``ssh kebnekaise-amd`` from a terminal window on the regular login node). Check if the versions of Python available differs from on the regular login node. 

## Compiler Toolchains

Compiler toolchains load bundles of software making up a complete environment for compiling/using a specific prebuilt software. Includes some/all of: compiler suite, MPI, BLAS, LAPACK, ScaLapack, FFTW, CUDA.

Some currently available toolchains (check <code>ml av</code> for versions and full, updated list): 

- **GCC**: GCC only
- **gcccuda**: GCC and CUDA
- **foss**: GCC, OpenMPI, OpenBLAS/LAPACK, FFTW, ScaLAPACK
- **gompi**: GCC, OpenMPI
- **gompic**: GCC, OpenMPI, CUDA
- **gomkl**: GCC, OpenMPI, MKL 
- **iccifort**: icc, ifort
- **iccifortcuda**: icc, ifort, CUDA
- **iimpi**: icc, ifort, IntelMPI
- **iimpic**: iccifort, CUDA, impi 
- **intel**: icc, ifort, IntelMPI, IntelMKL
- **intel-compilers**: icc, ifort (classic and oneAPI) 
- **intelcuda**: intel and CUDA
- **iompi**: iccifort and OpenMPI 

!!! Note "Exercise"

    Check which versions of the ``foss`` toolchain exist. Load one of them. Check which modules you now have loaded. Remove all the (non-sticky) modules. 

!!! Keypoints "Keypoints" 

    - The software on Kebnekaise is mostly accessed through the module system.
    - The modules are arranged in a hierarchial layout; many modules have prerequisites that needs to be loaded first. 
    - Important commands to the module system: 
        - Loading: <code>module load MODULE</code>
        - Unloading: <code>module unload MODULE</code>
        - Unload all modules: <code>module purge</code>
        - List all modules in the system: <code>module spider</code>
        - List versions available of a specific module: <code>module spider MODULE</code>
        - Show how to load a specific module and version: <code>module spider MODULE/VERSION</code>
        - List the modules you have currently loaded: <code>module list</code>
    - Compiler toolchains are modules containing compiler suites and various libraries 


!!! info "More information"

    - There is more information about the module system and how to work with it in <a href="https://docs.hpc2n.umu.se/documentation/modules/" target="_blank">HPC2N's documentation for the modules system</a>. 
