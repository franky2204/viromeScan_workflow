#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  fastq_directory: Directory
  db_path: 
    type:
      - Directory
      - File
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")
  threads: int?
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
  index_chm13:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  viro_exec: File
  viro_db: Directory
  scan_type: string

outputs:
  output: 
    type: Directory[]
    outputSource: viromescan/output
  count:
    type: File[]
    outputSource: pre-virome/count
  read_1_kraken:
    type: File[]
    outputSource: pre-virome/read_1_kraken
  read_2_kraken:
    type: File[]
    outputSource: pre-virome/read_2_kraken

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  pre-virome:
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    run: cwl/preVirome.cwl
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      db_path: db_path
      threads: threads
      index: index
      index_chm13: index_chm13
    out: [read_1_kraken, read_2_kraken, count]
  viromescan:
    run: cwl/viromescan1.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      viro_exec: viro_exec
      threads: threads
      viro_db: viro_db
      scan_type: scan_type
      read_1: pre-virome/read_1_kraken
      read_2: pre-virome/read_2_kraken
    out: [output]
    
