# Load a Julia module
ml Julia/1.8.5-linux-x86_64

# The first time you use this script:

- start Julia and activate the environment 

julia --project=.

- go to package mode and add the **ArgParse** package

(alphafold-job-gen) pkg> add ArgParse

# After this, you can use the script as follows:

julia --project=. alphafoldjobgen.jl --help
