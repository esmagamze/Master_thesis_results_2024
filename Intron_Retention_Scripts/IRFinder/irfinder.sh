${snakemake_config[irfinderbin_dir]}"/IRFinder -m BAM -r ${snakemake_input[ref]} -d ${snakemake_output[0]} ${snakemake_input[bam]}