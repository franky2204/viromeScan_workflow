#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  threads: int?
  read_1: File
  read_2: File
  

outputs:
  read_1_zip:
    type: File
    outputSource: zip-kraken/read_1_zip
  read_2_zip:
    type: File
    outputSource: zip-kraken/read_2_zip

steps:
  zip-kraken:
    run: cwl/preVirome/zipFiles.cwl
    in:
      threads: threads
      read_1: read_1
      read_2: read_2
    out: [read_1_zip, read_2_zip]