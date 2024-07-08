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

hints:
  DockerRequirement:
    dockerPull: scontaldo/humanmapper



baseCommand: ["bash", "/scripts/countFastq.sh"]


inputs:
  read_1:
    type: File
    inputBinding:
      position: 1 
  read_2:
    type: File
    inputBinding:
      position: 2 


outputs:
  count:
    type: File
    outputBinding:
      glob: "*_count.txt"
