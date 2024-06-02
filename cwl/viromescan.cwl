cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: [ $(inputs.viro_db)]

hints:
  DockerRequirement:
    dockerPull: fpant/viromescan
  ResourceRequirement:
    coresMax: $(inputs.threads)
    

baseCommand: ["bash", "/scripts/virome_run.sh"]


inputs:
  
  threads:
    type: int?
    default: 1
    inputBinding:
        position: 1

  viro_db:
    type: Directory
    inputBinding:
      position: 2

  scan_type:
    type: string
    inputBinding:
      position: 3

  read_1:
    type: File
    inputBinding:
      position: 4

  read_2: 
    type: File
    inputBinding:
      position: 5
      prefix: '-2'
  output_folder:
    type: string?
    default: 'output'
    inputBinding:
      position: 6
  
     
outputs:
  output:
    type: Directory
    outputBinding:
      glob: "*_output"

 