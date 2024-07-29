#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  
inputs:
    kraken_res:
        type: File  
outputs:
  kraken_pos:
    type: File
    outputSource: only_position/kraken_pos

steps:
  only_position:    
    run: cwl/preVirome/onlyPosition.cwl
    in:
      kraken_res: kraken_res
    out: [kraken_pos]