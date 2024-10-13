Import necessary libraries
from snakemake import snakemake

Define the Snakefile and specify the target rule
snakemake(
    snakefile="all.rules",
    targets=["all"],
    printshellcmds=True,  # Print the shell commands being executed
    cores=4,  # Specify the number of CPU cores to use
)
