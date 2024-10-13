trim_galore --fastqc --paired -q 30 --basename ${snakemake_wildcards[sample]} -o ${snakemake_params[out_path]} "${snakemake_input[r1]}" "${snakemake_input[r2]}"

