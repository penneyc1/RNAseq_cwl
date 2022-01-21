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
  fastqR1:
    type: File
    inputBinding:
      position: 3
  fastqR2:
    type: File
    inputBinding: 
      position: 4

outputs:
  quantification:
    type: File
    outputBinding:
      glob: "*.h5"
