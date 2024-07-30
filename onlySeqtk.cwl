#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
    read_1:
        type: File
    read_2:
        type: File
    kraken_res: 
        type: File
outputs:
  readNB_1:
    type: File
    outputSource: onlySeqtk/readNB_1
  readNB_2:
    type: File
    outputSource: onlySeqtk/readNB_2
steps:
    onlySeqtk:    
        run: cwl/preVirome/seqtkFilter.cwl
        in:
            read_1: read_1
            read_2: read_2
            kraken_res: kraken_res
        out: [readNB_1, readNB_2]