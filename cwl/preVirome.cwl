#!usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}

inputs:
  read_1: File
  read_2: File
  db_path: 
    type:
      - Directory
      - File
    secondaryFiles:
      - $("opts.k2d")
      - $("taxo.k2d")
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

outputs:
    read_1_kraken:
        type: File
        outputSource: zip-kraken/read_1_zip
    read_2_kraken:  
        type: File
        outputSource: zip-kraken/read_2_zip
    count:
        type: File
        outputSource: count-genome3/count
    

steps:
  count-start:
    run: preVirome/countUniteFastq.cwl
    in:
      read_1: read_1
      read_2: read_2
    out: [count]
  humanmapper:
    run: preVirome/humanMapper.cwl
    in:
      read_1: read_1
      read_2: read_2
      index: index
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome1:
    run: preVirome/countUniteFastq.cwl
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
      file_count: count-start/count
    out: [count]
  humanMapper_chm13:
    run: preVirome/humanMapper.cwl
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
      index: index_chm13
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome2:
    run: preVirome/countUniteFastq.cwl
    in:
      read_1: humanMapper_chm13/unmapped_R1
      read_2: humanMapper_chm13/unmapped_R2
      file_count: count-genome1/count
    out: [count]
  kraken2:
    run: preVirome/remove_mapped_reads.cwl
    in:
      read_1: humanMapper_chm13/unmapped_R1
      read_2: humanMapper_chm13/unmapped_R2
      db_path: db_path
      threads: threads
    out: [read_1_output, read_2_output]
  zip-kraken:
    run: preVirome/zipFiles.cwl
    in:
      read_1: kraken2/read_1_output
      read_2: kraken2/read_2_output
    out: [read_1_zip, read_2_zip]
  count-genome3:
    run: preVirome/countUniteFastq.cwl
    in:
      read_1: zip-kraken/read_1_zip
      read_2: zip-kraken/read_2_zip
      file_count: count-genome2/count
    out: [count]