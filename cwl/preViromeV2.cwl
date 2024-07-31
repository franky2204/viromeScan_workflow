#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  read_1: File
  read_2: File
  threads: int?
  index:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .fai
      - .pac
      - .sa
  index_chm13:
    type: File
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  bacteria_ids: File
  kraken_res_dir: Directory
  

outputs:
  readNB_1:
    type: File
    outputSource: seqtdk_filter/readNB_1
  readNB_2:  
    type: File
    outputSource: seqtdk_filter/readNB_2
  count:
    type: File
    outputSource: count-genome3/count
  krakenNB_res:
    type: File
    outputSource: only_position/kraken_pos
  kraken_res:
    type: File
    outputSource: find_kraken_results/kraken_res
  
    

steps:
  count-start:
    run: preVirome/countUniteFastq.cwl
    in:
      read_1: read_1
      read_2: read_2
    out: [count]
  find_kraken_results:
    run: preVirome/findKrakenResults.cwl
    in:
      read_1: humanMapper_chm13/unmapped_R1
      dir: kraken_res_dir
    out: [kraken_res]
  remove_taxID:
    run: preVirome/removeTaxID.cwl
    in:
      kraken_res: find_kraken_results/kraken_res
      bacteria_ids: bacteria_ids
    out: [krakenNB_res]
  only_position:
    run: preVirome/onlyPosition.cwl
    in:
      kraken_res: remove_taxID/krakenNB_res
    out: [kraken_pos]
  seqtdk_filter:
    run: preVirome/seqtkFilter.cwl
    in:
      read_1: read_1
      read_2: read_2
      kraken_res: only_position/kraken_pos
    out: [readNB_1, readNB_2]
  count-genome3:
    run: preVirome/countFast.cwl
    in:
      read_1: seqtdk_filter/readNB_1
      read_2: seqtdk_filter/readNB_2
      file_count: count-genome2/count
    out: [count]
