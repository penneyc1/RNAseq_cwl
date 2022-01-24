#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

baseCommand: "cutadapt"

inputs:
  cutadapt_input_forward:
    type: string
    inputBinding:
      position: 5
  cutadapt_input_reverse:
    type: string?
    inputBinding:
      position: 6
  cutadapt_output_forward:
    type: string
    inputBinding:
      position: 3
      prefix: -o
  cutadapt_output_reverse:
    type: string?
    inputBinding:
      position: 4
      prefix: -p
  cutadapt_forward_adapter:
    type: string
    inputBinding:
      position: 1
      prefix: -a
  cutadapt_reverse_adapter:
    type: string?
    inputBinding:
      position: 2
      prefix: -A
outputs:
  cutadapt_output:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*fastqc"
