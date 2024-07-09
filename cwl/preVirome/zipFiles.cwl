cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.index) ]

hints:
  DockerRequirement:
    dockerPull: scontaldo/humanmapper

baseCommand: ["pigz", "-p"]

inputs:
  threads:
    type: int?
    default: 1
    inputBinding:
      position: 1
  read_1:
    type: File
    inputBinding:
      position: 2
  read_2:
    type: File
    inputBinding:
      position: 3

outputs:
  read_1_zip:
    type: File
    outputBinding:
      glob: "$(inputs.read_1.basename).gz"
  read_2_zip:
    type: File
    outputBinding:
      glob: "$(inputs.read_2.basename).gz"
