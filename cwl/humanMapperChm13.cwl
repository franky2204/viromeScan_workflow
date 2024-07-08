#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

doc: |
  Filter uman reads using chm13

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.index_chm13)]
hints:
  ResourceRequirement:
    coresMax: $(inputs.threads)
  DockerRequirement:
    dockerPull: scontaldo/humanmapper

baseCommand: ["bash", "/scripts/humanMapper.sh"]

inputs:
  read_1:
    type: File
    inputBinding:
      position: 1 
  read_2:
    type: File
    inputBinding:
      position: 2
  index_chm13:
    doc: "index chm13 used as reference"
    type: File
    inputBinding:
      position: 3
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  threads:
    doc: "Max number of threads in use"
    type: int?
    default: 1
    inputBinding:
      position: 4

      
outputs:
  unmapped_chm_R1:
    type: File
    outputBinding:
      glob: "*chm13v2.0_unmapped_R1.fastq.gz"
  unmapped_chm_R2:
    type: File
    outputBinding:
      glob: "*chm13v2.0_unmapped_R2.fastq.gz"




