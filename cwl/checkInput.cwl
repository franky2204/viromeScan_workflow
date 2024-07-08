#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  fastq_directory: Directory

outputs:
  read_1:
    type: File[] 
    outputSource: send-files/read_1 
  read_2:
    type: File[]
    outputSource: send-files/read_2 

steps:
  check-files: 
    run: checkInput/findFiles.cwl
    in:
      fastq_directory: fastq_directory
    out: [value]
  send-files:
    run: checkInput/sendFiles.cwl
    scatter: fastq_name
    in:
      fastq_name: check-files/value
      fastq_directory: fastq_directory
    out: [read_1, read_2]
