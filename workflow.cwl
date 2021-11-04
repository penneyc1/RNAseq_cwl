cwlVersion: v1.0
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  fastq1:
    type: File
    doc: "Paired-end read 1. Used in fastqc, kallisto."
  fastq2:
    type: File
    doc: "Paired-end read 2. Used in fastqc, kallisto."
  kallisto_index:
    type: File
    doc: "Absolute path to kallisto index file, .idx extension."
  star_index:
    type: File?
    doc: "Absolute path to STAR index file, (/data/starIndex_hg38_no_alt.tar.gz)                                                                              ."
  # rsem_index:
  #   type: File?
  #   doc: "Absolute path to RSEM index file, (/data/rsem_ref_hg38_no_alt.tar.gz).                                                                              "
  stargenomedir:
    type: Directory
    doc: "Absolute path to STAR genome directory, prepared with STAR_RSEM_prep.s                                                                              h script (from 'https://github.com/ENCODE-DCC/long-rna-seq-pipeline/blob/master/                                                                              DAC/STAR_RSEM.sh')."
  # rsemrefdir:
  #   type: Directory?
  #   doc: "Absolute path to RSEM genome directory, prepared with STAR_RSEM_prep.s                                                                              h script (from 'https://github.com/ENCODE-DCC/long-rna-seq-pipeline/blob/master/                                                                              DAC/STAR_RSEM.sh')."
  datatype:
    type: string
    doc: "Datatype for rMATS - e.g., 'paired'."
  # nthreadsrsem:
  #   type: int?
## rMATS
  s1:
    type: File
  s2:
    type: File
  gencodegtf:
    type: File
  readtype:
    type: string
  readlength:
    type: int
  nthread:
    type: int
  rmatsoutputdir:
    type: Directory
  rmatstempdir:
    type: Directory
## STAR
  staroutputprefix:
    type: string
  staroutsamtype:
    type: string
  staroutsunmapped:
    type: string
  staroutsamattributes:
    type: string

steps:
  fastqc:
    doc: fastqc - quality control for trimmed fastq
    run: "fastqc.cwl"
    in:
      fastq1:
        source: fastq1
      fastq2:
        source: fastq2
    out:
      - fastqc_zip
      - fastqc_html
  kallisto:
    doc: kallisto -  quant
    run: "kallisto.cwl"
    in:
      fastq1:
        source: fastq1
      fastq2:
        source: fastq2
      kallisto_index:
        source: kallisto_index
    out:
      - quantification
  star:
    doc: star
    run: "star.cwl"
    in:
      stargenomedir:
        source: stargenomedir
      nthread:
        source: nthread
      fastq1:
        source: fastq1
      fastq2:
        source: fastq2
      staroutputprefix:
        source: staroutputprefix
      staroutsamtype:
        source: staroutsamtype
      staroutsunmapped:
        source: staroutsunmapped
      staroutsamattributes:
        source: staroutsamattributes
    out:
      - staroutputs

  rMATS:
    doc: "rMATS"
    run: "rmats.cwl"
    in:
      s1:
        source: s1
      s2:
        source: s2
      gencodegtf:
        source: gencodegtf
      stargenomedir:
        source: stargenomedir
      readtype:
        source: readtype
      readlength:
        source: readlength
      nthread:
        source: nthread
      rmatsoutputdir:
        source: rmatsoutputdir
      rmatstempdir:
        source: rmatstempdir
    out:
      - rmatsoutput

outputs:
  out_fastqc_zip:
    type:
      type: array
      items: File
    outputSource: fastqc/fastqc_zip
  out_fastqc_html:
    type:
      type: array
      items: File
    outputSource: fastqc/fastqc_html
  quantification:
    type:
      type: array
      items: File
    outputSource: kallisto/quantification
#  starbamout:
#    type:
#      type: array
#      items: File
#    outputSource: star-rsem/starbamout
#  starlogfinalout:
#    type:
#      type: array
#      items: File
#    outputSource: star-rsem/starlogfinalout
#  rsemgenequants:
#    type:
#      type: array
#      items: File
#    outputSource: star-rsem/rsemgenequants
#  rsemtranscriptquants:
#    type:
#      type: array
#      items: File
#    outputSource: star-rsem/rsemtranscriptquants
#  rsemdiagnosticplots:
#    type:
#      type: array
#      items: File
#    outputSource: star-rsem/rsemdiagnosticplots
#  rsembigwigfiles:
#    type:
#      type: array
#      items: File
#    outputSource: star-rsem/rsembigwigfiles
##rMATS
  rmatsoutput:
    type:
      type: array
      items: File
    outputSource: rMATS/rmatsoutput
##STAR
  staroutputs:
    type:
      type: array
      items: File
    outputSource: star/staroutputs
