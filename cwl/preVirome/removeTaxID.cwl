#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

  DockerRequirement:
    dockerPull: fpant/viromescan

baseCommand: ["python3", "/scripts/removeBacteria.py"]

inputs: 
  kraken_res:
    type: File
    inputBinding:
      position: 1
  bacteria_ids:
    type: File
    inputBinding:
      position: 2


outputs:
  krakenNB_res:
    type: File
    outputBinding:
      glob: "notBacteriaLines.lst"
