# RNAseq_cwl
Pipeline for processing fastq files through one or more of: Cutadapt-Fastqc-kallisto-STAR-rMATS-RSEM.

Requires an environment with cwltool, cutadapt, fastqc, kallisto, STAR, RSEM and rMATS installed and pointed to by your $PATH variable.

Modify "job.yml" with the fastq files, variables and directories you would like to use for the job (see job.yml for more detailed instructions), then run as batch job (or off the command-line in interactive mode with enough resources for STAR/rMATS etc.).

Usage:

cwl-runner workflow.cwl job.yml

To decide to not use a tool simply comment out its associated lines in the workflow file (i.e., all inputs, steps and outputs). The job.yml file can remain as it is.

Files are output to the running directory directly unless specified otherwise.
