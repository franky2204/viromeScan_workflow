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
    dockerPull: scontaldo/kraken2:v2.1.2 
  ResourceRequirement:
    coresMax: $(inputs.threads)

baseCommand: ["kraken2", "--paired", "--unclassified-out", "fasta_out#.fastq"]

inputs:
  db_path:
    type: 
      - Directory
      - File
    inputBinding:
      position: 1
      prefix: "--db"
      valueFrom: |
        ${ return (self.class == "File") ? self.dirname : self.path }
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")     
  read_1:
    type: File
    inputBinding:
      position: 2
  read_2:
    type: File
    inputBinding:
      position: 3
  threads:
    type: int?
    default: 1
    inputBinding:
      position: 4
      prefix: "--threads"

outputs:
  read_1_output:
    type: File
    outputBinding:
      glob: "fasta_out_1.fastq"

  read_2_output: 
    type: File
    outputBinding:
      glob: "fasta_out_2.fastq"
