##_______________Catadapt_____________##

##Comma separated lists of can be either single or matching, paired end reads. Specify list of input files, desired output filenames and adapters to run.

cutadapt_forward_input_names: []
cutadapt_forward_output_names: []

cutadapt_reverse_input_names: []
cutadapt_reverse_output_names: []

cutadapt_forward_adapter: 
cutadapt_reverse_adapter: 

##_______________FastQC_______________##

## 'fastqs' is a comma separated list of all fastq files for processing through fastqc.
fastqs: []

##_______________Kallisto_____________##

## Populate the "path" lines in 'fastqlist1' and 'fastqlist2' with the paths to your pairs of reads. You may have as many pairs as you would like (i.e., you may add more "class:" and "path:" entries as needed). They are sent to the aligner in a way such that the first entry in fastqlist1 will be considered to be paired with the first entry in fastqlist2 and so on. These reads are used in Kallisto and STAR steps.
fastq1list:
  - class: File
    path: 
fastq2list:
  - class: File
    path: 
kallisto_index:
  class: File
  path: 

##_____________STAR_________________##

## 'stargenomedir' should be the path to your STAR index directory, this is used in both rMATS and STAR steps.
stargenomedir:
  class: Directory
  path: 
##'staroutputprefix' is a comma-separated list of prefixes for the star jobs run on fastq1list/fastq2list.
staroutputprefixlist: []
## Value for --outSAMunmapped, options are None or Within.
staroutsunmapped: 
## Value for --outSAMattributes, options are NH, Standard, All or None.
staroutsamattributes: 
## 'nthread' should be adjusted to be an integer value suitable for your machine/the job, used in both rMATS and STAR steps.
nthread: 

##____________rMATS_________________##

##'s1' and 's2' are paths to text files detailing pairs of reads for rMATS.
###From rMATS Github (@https://github.com/Xinglab/rmats-turbo/blob/v4.1.2/README.md)
###'Create txt files that will be used to pass this grouping of inputs to rMATS. The expected format is : to separate paired reads and , to separate replicates.'
##### Example: /path/to/s1.txt
###### /path/to/1_1.R1.fastq:/path/to/1_1.R2.fastq,/path/to/1_2.R1.fastq:/path/to/1_2.R2.fastq
s1:
  class: File
  path: 
s2:
  class: File
  path: 
##'gencodegtf' is the path to the assembly's annotation .gtf file.
gencodegtf:
  class: File
  path: 
##'readtype' can be one of either "single" or "paired".
readtype: 
## 'readlength' is an integer denoting the length of each read.
readlength: 
## Specify directory for rMATS output.
rmatsoutputdir:
  class: Directory
  path: 
## Specify temp directory for rMATS job.
rmatstempdir:
  class: Directory
  path: 

##____________RSEM_________________##
## "rsem_upstream_reads" and "rsem_downstream_reads" are same format as "fastqs" above, i.e., comma separated list of reads.
rsem_upstream_reads: []
rsem_downstream_reads: []
## "rsem_reference_name" points to the output of 'rsem-prepare-reference' which needs to be run before this step can be run (see "https://deweylab.github.io/RSEM/rsem-prepare-reference.html" for details).
rsem_reference_name:
## "rsem_sample_name" is the desired experiment_ID or sample name for your RSEM runs.
rsem_sample_name: 
