# STAR --genomeDir /mnt/isilon/choi_lab/users/penneyc/reference/GRCh38.gencode.v28/star_index/  \
# --runThreadN 6 \
# --readFilesIn /mnt/isilon/choi_lab/users/penneyc/experiments/CP218_RNASeq_Pipeline/testsamples/R1.chr6.fq /mnt/isilon/choi_lab/users/penneyc/experiments/CP218_RNASeq_Pipeline/testsamples/R2.chr6.fq \
# --outFileNamePrefix STAR_RESULT \
# --outSAMtype BAM SortedByCoordinate \
# --outSAMunmapped Within \
# --outSAMattributes Standard

#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: "STAR"

inputs:
  stargenomedir:
    type: Directory
    inputBinding:
      position: 1
      prefix: --genomeDir
  nthread:
    type: int
    inputBinding:
      position: 2
      prefix: --runThreadN
  fastq1:
    type: File
    inputBinding:
      position: 3
      prefix: readFilesIn
  fastq2:
    type: File
    inputBinding:
      position: 4
  staroutputprefix:
    type: string
    inputBinding:
      position: 5
      prefix: --outFileNamePrefix
  staroutsamtype:
    type: string
    inputBinding:
      position: 6
      prefix: --outSAMtype
  staroutsunmapped:
    type: string
    inputBinding:
      position: 7
      prefix: --outSAMunmapped
  staroutsamattributes:
    type: string
    inputBinding:
      position: 8
      prefix: --outSAMattributes

outputs:
  staroutputs:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*out*"
