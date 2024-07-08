cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: fpant/viromescan2.0
  ResourceRequirement:
    coresMax: $(inputs.threads)

baseCommand: ["conda","run","-n","viromescan"] 


inputs:
  
  viro_exec:
    type: File
    inputBinding:
      position: 1
      prefix: 'bash'

  threads:
    type: int?
    default: 1
    inputBinding:
        position: 2
        prefix: '-p'

  viro_db:
    type: Directory
    inputBinding:
      position: 3
      prefix: '-m'

  scan_type:
    type: string
    inputBinding:
      position: 4
      prefix: '-d'

  read_1:
    type: File
    inputBinding:
      position: 5
      prefix: '-1'

  read_2: 
    type: File
    inputBinding:
      position: 6
      prefix: '-2'
 
arguments:
  - position: 7
    valueFrom: -o
  - position: 8
    valueFrom: "output"
  
     
outputs:
  output:
    type: Directory
    outputBinding:
      glob: "output"
      outputEval: ${
          self[0].basename = inputs.read_1.nameroot+"_virome_output";
          return self; }
 