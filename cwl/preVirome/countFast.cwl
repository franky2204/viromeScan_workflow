class: CommandLineTool
cwlVersion: "v1.2"

doc:  |
  Count reads of fastq 

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.read_1)
        writable: True
      - entry: $(inputs.read_2)
        writable: True
      - entry: $(inputs.file_count)
        writable: True

hints:
  DockerRequirement:
    dockerPull: scontaldo/humanmapper



baseCommand: ["bash", "/scripts/countFast.sh"]


inputs:
  read_1:
    type: File
    inputBinding:
      position: 1 
  read_2:
    type: File
    inputBinding:
      position: 2 
  file_count:
    type: File?
    inputBinding:
      position: 3


outputs:
  count:
    type: File
    outputBinding:
      glob: "*_count.txt"