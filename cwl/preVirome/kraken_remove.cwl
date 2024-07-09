#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}


inputs:
  read_1: File
  read_2: File
  db_path: 
    type:
      - Directory
      - File
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")
  threads: int?
  

outputs:
 
  file_1_output:
    type: File
    outputSource: kraken2/read_1_output
  file_2_output:
    type: File
    outputSource: kraken2/read_2_output

steps:
  kraken2:
    run: cwl/remove_mapped_reads.cwl
    in:
      read_1: read_1
      read_2: read_2
      db_path: db_path
      threads: threads
    out: [read_1_output, read_2_output] 
