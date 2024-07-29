cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}  

hints:
  DockerRequirement:
    dockerPull: fpant/viromescan

baseCommand: ["awk", "'{print $2}'" ]

inputs:
    kraken_res:
        type: File
        inputBinding:
            position: 1

stdout: "kraken_pos.lst"

outputs:
  kraken_pos:
    type: File
    outputBinding:
      glob: "kraken_pos.lst"

