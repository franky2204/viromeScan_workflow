cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: fpant/viromescan

baseCommand: ["awk"]

inputs:
  kraken_res:
    type: File
    inputBinding:
      position: 1

arguments:
  - valueFrom: '{print $2}'

stdout: "kraken_pos.lst"

outputs:
  kraken_pos:
    type: File
    outputBinding:
      glob: "kraken_pos.lst"

