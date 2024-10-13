import pandas as pd

configfile: "config.yml"

metadata = pd.read_csv(config["METAFILE"], sep = ',', header = 0)

samples = metadata["sample"].tolist()

input_path = config["fastq_dir"]

output_path = config["trimmed_dir"]

working_dir = config["working_dir"]

ir_ref = config["ir_ref"]
rule all:
    input:
        expand(working_dir + "/04.IR_Results/IRFinder/{sample}_IR", sample = samples),

rule trim_reads:
    input:
        r1=input_path + "/{sample}_1.fastq.gz",
        r2=input_path + "/{sample}_2.fastq.gz"
    output:
        r1=output_path + "/{sample}_val_1.fq.gz",
        r2=output_path + "/{sample}_val_2.fq.gz"
    params:
        out_path = output_path
    script:
        "scripts/trim_galore.sh"

rule alignment:
    input:
        r1=output_path + "/{sample}_val_1.fq.gz",
        r2=output_path + "/{sample}_val_2.fq.gz",
    output:
        bam=working_dir + "/03.alignment/{sample}_Aligned.out.bam"
    script:
        "scripts/star.sh"

rule irfinder:
  input:
    bam=working_dir + "/03.alignment/{sample}_Aligned.out.bam",
    ref=ir_ref
  output:
    results=directory(working_dir + "/04.IR_Results/IRFinder/{sample}_IR")
  script:
    "scripts/irfinder.sh"
