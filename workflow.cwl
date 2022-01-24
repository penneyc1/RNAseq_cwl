#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

inputs:

  cutadapt_forward_input_names: string[]
  cutadapt_forward_output_names: string[]
  cutadapt_reverse_input_names: string[]
  cutadapt_reverse_output_names: string[]
  cutadapt_forward_adapter: string
  cutadapt_reverse_adapter: string

  kallisto_index:
    type: File
  fastq1list: File[]
  fastq2list: File[]
  fastqs: string[]
  stargenomedir:
    type: Directory
  nthread:
    type: int
  staroutputprefixlist: string[]
  staroutsunmapped:
    type: string
  staroutsamattributes:
    type: string
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
  rmatsoutputdir:
    type: Directory
  rmatstempdir:
    type: Directory
  rsem_upstream_reads:
    type: string[]
  rsem_downstream_reads:
    type: string[]
  rsem_reference_name:
    type: string
  rsem_sample_name:
    type: string

outputs:
  cutadapt_output:
    type:
      type: array
      items: File
    outputSource: cutadapt/cutadapt_output
  quantification:
    type:
      type: array
      items: File
    outputSource: kallisto/quantification
  fastqc_zip:
    type:
      type: array
      items: File
    outputSource: fastqc/fastqc_zip
  fastqc_html:
    type:
      type: array
      items: File
    outputSource: fastqc/fastqc_html
  staroutputs:
    type:
      type: array
      items:
        type: array
        items: File
    outputSource: star/staroutputs
  rmatsoutput:
    type:
      type: array
      items: File
    outputSource: rMATS/rmatsoutput
  rsem_output:
    type:
      type: array
      items: File
    outputSource: rsem/rsem_output
steps:
  cutadapt:
    run: cutadapt.cwl
    in: 
      cutadapt_input_forward: cutadapt_forward_input_names
      cutadapt_input_reverse: cutadapt_reverse_input_names
      cutadapt_output_forward: cutadapt_forward_output_names
      cutadapt_output_reverse: cutadapt_reverse_output_names
      cutadapt_forward_adapter: cutadapt_forward_adapter
      cutadapt_reverse_adapter: cutadapt_reverse_adapter
    scatter:
      - cutadapt_input_forward
      - cutadapt_input_reverse
      - cutadapt_output_forward
      - cutadapt_output_reverse
    scatterMethod: dotproduct
    out:
      - cutadapt_output
  kallisto:
    run: kallisto.cwl
    in:
      fastqR1: fastq1list
      fastqR2: fastq2list
      kallisto_index: kallisto_index
    scatter:
      - fastqR1
      - fastqR2
    scatterMethod: dotproduct
    out:
      - quantification
  fastqc:
    run: fastqc.cwl
    in:
      fastqs: fastqs
    out:
      - fastqc_zip
      - fastqc_html
  star:
    doc: star
    run: "star.cwl"
    in:
      stargenomedir:
        source: stargenomedir
      nthread:
        source: nthread
      fastqR1: fastq1list
      fastqR2: fastq2list
      staroutputprefix: staroutputprefixlist
      staroutsunmapped:
        source: staroutsunmapped
      staroutsamattributes:
        source: staroutsamattributes
    scatter:
      - fastqR1
      - fastqR2
      - staroutputprefix
    scatterMethod: dotproduct
    out: [staroutputs]
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
  rsem:
    doc: "RSEM"
    run: "rsem.cwl"
    in:
      rsem_upstream_reads:
        source: rsem_upstream_reads
      rsem_downstream_reads:
        source: rsem_downstream_reads
      rsem_reference_name:
        source: rsem_reference_name
      rsem_sample_name:
        source: rsem_sample_name
    out:
      - rsem_output
