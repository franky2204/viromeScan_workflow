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
  

hints:
  DockerRequirement:
    dockerPull: scontaldo/humanmapper
  ResourceRequirement:
    coresMax: $(inputs.threads)

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
      glob: "*R1.f*.gz"
  read_2_zip:
    type: File
    outputBinding:
      glob: "*R2.f*.gz"
