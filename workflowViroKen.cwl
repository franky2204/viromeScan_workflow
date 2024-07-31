#in order to use this you need to have a file containing all the non bacteric ids 
#file_name.lst whitch is in short a txt renamed containg an id for each line.
#To obtain it (this process is required only once) take the file inspect.txt from the kraken DB
#then cut it before the first line containing the word Archea
#sed "'/Archaea/q' input.txt > output.txt"
#or for added security  "awk '/Archaea/ {print; exit} {print}' inspect.txt > output.txt"
# plus remove manually the last row or by using "sed '$d' input.txt > output.txt"
# also remove the first two lines(they are root(1) and cellular organisms(131567))?
#after that use the following bash to obtain the file_name.lst
#awk '{print $5}' bacteria.txt | sort -n | uniq > taxids.txt


#!usr/bin/env cwl-runner
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
  viromescan:
    run: cwl/viromescan1.cwl
    scatter: [read_1,read_2]
    scatterMethod: dotproduct
    in:
      viro_exec: viro_exec
      threads: threads
      viro_db: viro_db
      scan_type: scan_type
      read_1: pre-viromeV2/readNB_1
      read_2: pre-viromeV2/readNB_2
    out: [output]