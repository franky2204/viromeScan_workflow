cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
inputs:
  fastq_directory: Directory
  bacteria_ids: File
  threads: int?
  kraken_res_dir: Directory
  viro_exec: File
  viro_db: Directory
  scan_type: string

outputs:
  output: 
    type: Directory[]
    outputSource: viromescan/output
  count:
    type: File[]
    outputSource: pre-viromeV2/count
  krakenNB_res:
    type: File[]
    outputSource: pre-viromeV2/krakenNB_res
    
steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  pre-viromeV2:
    run: cwl/preViromeV2.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      threads: threads
      bacteria_ids: bacteria_ids
      kraken_res_dir: kraken_res_dir
    out: [readNB_1, readNB_2,krakenNB_res,count]
