
#### python /mnt/isilon/choi_lab/users/penneyc/miniconda3/envs/eclip/rMATS/rmats.py --s1 s1.txt --s2 s2.txt --gtf /mnt/isilon/choi_lab/users/penneyc/reference/GRCh38.gencode.v28/gencode.v28.primary_assembly.annotation.gtf --bi /mnt/isilon/choi_lab/users/penneyc/reference/RNA_Pipeline_STAR_Genome -t paired --readLength 50 --nthread 4 --od /mnt/isilon/choi_lab/users/penneyc/experiments/CP218_RNASeq_Pipeline/rmatstest/output --tmp /mnt/isilon/choi_lab/users/penneyc/experiments/CP218_RNASeq_Pipeline/rmatstest/tmp

#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: "[python, /mnt/isilon/choi_lab/users/penneyc/miniconda3/envs/eclip/rMATS/rmats.py]"

inputs:
  s1:
    doc: Text file containing comma-separated absolute filepaths for fastq files.
    type: File
    inputBinding:
      position: 1
      prefix: --s1
  s2:
    doc: Text file containing comma-separated absolute filepaths for fastq files.
    type: File
    inputBinding:
      position: 1
      prefix: --s1
  gencodegtf:
    type: File
    inputBinding:
      position: 2
      prefix: --gtf
  stargenomedir:
    type: Directory
    inputBinding:
      position: 3
      prefix: --bi
  readtype:
    type: string
    inputBinding:
      position: 4
      prefix: -t
  readlength:
    type: int
    inputBinding:
      position: 5
      prefix: --readLength
  nthread:
    type: int
    inputBinding:
      position: 6
      prefix: --nthread
  rmatsoutputdir:
    type: Directory
    inputBinding:
      position: 7
      prefix: --od
  rmatstempdir:
    type: Directory
    inputBinding:
      position: 8
      prefix: --tmp
outputs:
  rmatsoutput:
    doc: all outputs
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.txt"
