#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

doc: |
  Run fastqc on raw reads in FASTQ format (single or paired end) or aligned reads in BAM.

baseCommand: "fastqc"
arguments: 
 # - valueFrom: /mnt/isilon/choi_lab/users/penneyc/experiments/CP219_RNASeq_Pipeline/RNAseq_cwl/fastqcoutdir
  - valueFrom: $(runtime.outdir)
    prefix: "-o"
  - valueFrom: "--noextract"

inputs:
  fastqs:
    type: string[]
    inputBinding:
      position: 1

outputs:
  fastqc_zip:
    doc: all data e.g. figures
    type:
      type: array
      items: File
    outputBinding:
      glob: "*_fastqc.zip"
  fastqc_html:
    doc: html report showing results from zip
    type:
      type: array
      items: File
    outputBinding:
      glob: "*_fastqc.html"
