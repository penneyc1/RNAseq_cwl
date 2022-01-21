#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

inputs:
  kallisto_index:
    type: File
  fastq1list: File[]
  fastq2list: File[]
  fastqs: string[]
  stargenomedir:
    type: Directory
  nthread:
    type: int
  staroutputprefix: string[]
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

outputs:
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
    outputSource: rmats/rmatsoutput
steps:
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
