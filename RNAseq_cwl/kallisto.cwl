#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

doc: |
  Run kallisto on raw reads in FASTQ format

baseCommand: [kallisto, quant]
arguments:
  - valueFrom: $(runtime.outdir)
    prefix: "-o"

inputs:
  kallisto_index:
    type: File
    inputBinding:
      prefix: "-i"
      position: 1
  fastq1:
    type: File
    inputBinding:
      position: 3
  fastq2:
    type: File
    inputBinding: 
      position: 4 

outputs:
  quantification:
    type:
      type: array
      items: File
    outputBinding:
      glob: abundance.h5
