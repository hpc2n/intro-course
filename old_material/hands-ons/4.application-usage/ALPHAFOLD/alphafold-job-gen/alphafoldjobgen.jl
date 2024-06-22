# Script to generate batch jobs for Alphafold. 
# P. Ojeda-May 30 Nov. 2023
# Usage: 
#          julia --project=. alphafoldjobgen.jl --help
using ArgParse

function read_and_replace_fasta_wt(file_path)
    # Initialize variables to store header and sequence
    header = ""
    sequence = ""

    # Open the FASTA file
    open(file_path) do file
        # Iterate through each line in the file
        for (i, line) in enumerate(eachline(file))
            # Check if the line is a header line
            if i == 1 && startswith(line, '>')
                # Store the header (excluding '>')
                header = strip(line[2:end])
            elseif i == 2
                sequence = line
            end
        end
    end

    # Return the header and modified sequence
    return header, sequence
end

function read_and_replace_fasta(file_path, parsed_mutations)
    # Initialize variables to store header and sequence
    header = ""
    sequence = ""

    # Open the FASTA file
    open(file_path) do file
        # Iterate through each line in the file
        for (i, line) in enumerate(eachline(file))
            # Check if the line is a header line
            if i == 1 && startswith(line, '>')
                # Store the header (excluding '>')
                header = strip(line[2:end])
            elseif i == 2
                # Replace specified characters in the sequence
                split_line = collect(line)
                for mutation in parsed_mutations
                    position, character = mutation
                    split_line[position]=character
                end
                sequence = join(split_line)
            end
        end
    end

    # Return the header and modified sequence
    return header, sequence
end

function create_directory(path, header, sequence, nmer)
    # Create the directory
    mkdir(path)

    # Create the fasta file with sequence information
    content = """
    >$header
    $sequence
    """

    if nmer == 1 
        string_nmer = "monomer"
        repeat_content = content
        wall_time = 4
    else
        string_nmer = "multimer"
        repeat_content = content^nmer
        # Approximated timnigs for the nmers based on the full-fragment
        if nmer == 2
             wall_time = 4
        elseif nmer == 3
             wall_time = 8
        elseif nmer == 4
             wall_time = 16
        elseif nmer == 5
             wall_time = 20
        else
             wall_time = 75
        end
    end

    readme_path = joinpath(path, lazy"$path.fasta")
    open(readme_path, "w") do file
        write(file, repeat_content)
    end


    # Create the batch submit file for HPC2N 1 GPU node 
    content = """
    #!/bin/bash
    #SBATCH -A hpc2n2023-135
    #SBATCH -J $path
    #SBATCH -t $wall_time:00:00
    #SBATCH -c 28
    #SBATCH --gres=gpu:v100:2
    #SBATCH --exclusive
    
    # Clean the environment from loaded modules
    ml purge > /dev/null 2>&1
    
    # Load AlphaFold
    ml GCC/10.3.0  OpenMPI/4.1.1
    ml AlphaFold/2.2.2-CUDA-11.3.1
    export ALPHAFOLD_HHBLITS_N_CPU=28
    
    alphafold --fasta_paths=$path.fasta --max_template_date=2023-11-20 --model_preset=$string_nmer --output_dir=\$PWD
    """
    readme_path = joinpath(path, "job.sh")
    open(readme_path, "w") do file
        write(file, content)
    end

end


# Create an argument parser
parser = ArgParseSettings(description="Process FASTA file and perform sequence mutations")

# Define command-line options
@add_arg_table parser begin
    "--fastafile"  
        help="FASTA file located in your directory where this generator script is" 
    "--mutations"   
        help="List of mutations (e.g., '4 G 7 T'), 'wt' means no mutations" 
    "--nmer"
        help="1 -> monomer, 2 -> dimer, 3 -> trimer, and so on" 
        arg_type = Int
end

# Parse command-line arguments
args = parse_args(parser)

# Extract values from parsed arguments
file_path = get(args, "fastafile", "")
file_without_extension = replace(file_path, r"\.fasta$" => "")
mutations = split(get(args, "mutations", ""))
mutations = string.(mutations)
nmer = get(args, "nmer", "")

if mutations[1] == "wt"
     println("Creating files for the WT case")

     # Perform the replacement
     header, sequence = read_and_replace_fasta_wt(file_path)
     
     # Print the results
     println("Header: $header")
     println("Modified Sequence: $sequence")

     # Create mutant directory and fasta file
     wt_directory_name = "$file_without_extension-wt-nmer$(nmer)"
     println("Directory name: $wt_directory_name")
     create_directory(wt_directory_name,header,sequence,nmer)

else
     println("Creating files for the mutants")

     parsed_mutations = [(parse(Int, mutations[i]), mutations[i+1][1]) for i in 1:2:length(mutations)-1]
     
     # Perform the replacement
     header, modified_sequence = read_and_replace_fasta(file_path, parsed_mutations)
     
     # Print the results
     println("Header: $header")
     println("Modified Sequence: $modified_sequence")

     # Create mutant directory and fasta file
     mutant_directory_name = "$file_without_extension-mutant-$(join(mutations))-nmer$(nmer)"
     println("Directory name: $mutant_directory_name")
     create_directory(mutant_directory_name,header,modified_sequence,nmer)

end
