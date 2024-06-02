#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  threads: int?

  viro_db: Directory
  scan_type: string
  read_1: File
  read_2: File
  output_folder: string?
  viro_exec: File

     
outputs:
  output: 
    type: Directory
    outputSource: viromescan/output
steps: 
    viromescan:
      run: cwl/viromescan1.cwl
      in:
        viro_exec: viro_exec
        threads: threads
        viro_db: viro_db
        scan_type: scan_type
        read_1: read_1
        read_2: read_2
        output_folder: output_folder
      out: [output]
    