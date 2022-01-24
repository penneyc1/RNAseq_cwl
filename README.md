# RNAseq_cwl
Pipeline for processing fastq files through one or more of: Cutadapt-Fastqc-kallisto-STAR-rMATS-RSEM.

Requires an environment with the following programs installed and pointed to by your $PATH variable.

1.) cwltool
2.) cutadapt
3.) fastqc
4.) kallisto
5.) STAR
6.) RSEM 
7.) rMATS 

Additionally requires a STAR index directory (see manual @ https://physiology.med.cornell.edu/faculty/skrabanek/lab/angsd/lecture_notes/STARmanual.pdf) and that you've ran RSEM's "rsem-prepare-reference" (see manual @ https://deweylab.github.io/RSEM/rsem-prepare-reference.html) command and can point to its output. 

To Run:

Modify "manifest.yml" so that it contains references to the fastq files, variables and directories you would like to use for the job (see example_job.yml for example), then run as a batch job (or off the command-line in interactive mode with enough resources for the more resource-intensive programs e.g. STAR).

Usage:

$ cwl-runner workflow.cwl manifest.yml

To decide to not use a tool simply comment out its associated lines in the workflow.cwl file (i.e., all inputs, steps and outputs). The programs that the inputs/outputs/steps belong to have been indicated with comments. The manifest.yml file can remain as it is (i.e., uncommented).

Files are output to the running directory directly unless specified otherwise.

