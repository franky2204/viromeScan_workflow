#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.read_1)
        writable: True
      - entry: $(inputs.read_2)
        writable: True
        
  DockerRequirement:
    dockerPull: fpant/viromescan

baseCommand: ["bash", "/scripts/seqtkFilter.sh"]

inputs: 
  read_1:
    type: File
    inputBinding:
      position: 1
  read_2:
    type: File
    inputBinding:
      position: 2
  kraken_res:
    type: File
    inputBinding:
      position: 3

outputs:
  readNB_1:
    type: File
    outputBinding:
      glob: "*_NB_R1.fastq"
  readNB_2:
    type: File
    outputBinding:
      glob: "*_NB_R2.fastq"
