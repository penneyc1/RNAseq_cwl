#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

baseCommand: ["rsem-calculate-expression", "--paired-end"]

inputs:

  rsem_upstream_reads:
    type: string[]
    inputBinding:
      position: 1
  rsem_downstream_reads:
    type: string[]
    inputBinding:
      position: 2
  rsem_reference_name:
    type: string
    inputBinding:
      position: 3
  rsem_sample_name:
    type: string
    inputBinding:
      position: 4
outputs:
  rsem_output:
    doc: all output files
    type:
      type: array
      items: File
    outputBinding:
      glob: $(inputs.sample_name)
