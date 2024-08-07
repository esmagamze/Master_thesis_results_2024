for f in *bam; do samtools flagstat $f > $f.mapping.stats; done 
