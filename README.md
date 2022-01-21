# RNAseq_cwl
Pipeline for processing fastq files through one or more of: fastqc-kallisto-star-rmats.

Requires cwltool, fastqc, kallisto, STAR and rMATS to be installed and pointed to by your $PATH variable.

Modify "job.yml" with the fastq files, variables and directories you would like to use for the job (see job.yml for more detailed instructions), then run as batch job (or off the command-line in interactive mode with enough resources for STAR/rMATS etc.).

Usage:

cwl-runner workflow.cwl job.yml

