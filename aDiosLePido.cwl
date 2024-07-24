#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  read_1: File
  folder_try: Directory
  

outputs:
  kraken_res: 
    type: File
    outputSource: find_kraken_results/kraken_res

steps:
  find_kraken_results:
    run: cwl/preVirome/findKrakenResults.cwl
    in:
      dir: folder_try
      read_1: read_1
    out: [kraken_res]