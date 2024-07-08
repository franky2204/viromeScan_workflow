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
  viro_exec: File
  viro_db: Directory
  scan_type: string

outputs:
  unmapped_R1:
    type: File[]
    outputSource: humanmapper/unmapped_R1
  unmapped_R2:
    type: File[]
    outputSource: humanmapper/unmapped_R2
  unmapped_chm_R1:
    type: File[]
    outputSource: humanMapper_chm13/unmapped_chm_R1
  unmapped_chm_R2:
    type: File[]
    outputSource: humanMapper_chm13/unmapped_chm_R2
  read_1_output:
    type: File[]
    outputSource: kraken2/read_1_output
  read_2_output:    
    type: File[]
    outputSource: kraken2/read_2_output
  count_fastq:
    type: File[]
    outputSource: count-start/count
  count_fastq_g1:
    type: File[]
    outputSource: count-genome1/count
  count_fastq_g2:
    type: File[]
    outputSource: count-genome2/count
  count_fastq_g3:
    type: File[]
    outputSource: count-genome3/count
  virome_output:
    type: Directory
    outputSource: viromescan/output

steps:
  check-input:
    run: cwl/checkInput.cwl
    in:
      fastq_directory: fastq_directory
    out: [read_1, read_2]
  count-start:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
    out: [count]
  humanmapper:
    run: cwl/humanMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: check-input/read_1
      read_2: check-input/read_2
      index: index
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome1:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
    out: [count]
  humanMapper_chm13:
    run: cwl/humanMapper.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanmapper/unmapped_R1
      read_2: humanmapper/unmapped_R2
      index: index_chm13
      threads: threads
    out: [unmapped_R1, unmapped_R2]
  count-genome2:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanMapper_chm13/unmapped_R1
      read_2: humanMapper_chm13/unmapped_R2
    out: [count]
  kraken2:
    run: cwl/remove_mapped_reads.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: humanMapper_chm13/unmapped_R1
      read_2: humanMapper_chm13/unmapped_R2
      db_path: db_path
      threads: threads
    out: [read_1_output, read_2_output] 
  count-genome3:
    run: cwl/countFastq.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      read_1: kraken2/read_1_output
      read_2: kraken2/read_2_output
    out: [count]
  viromescan:
    run: cwl/viromescan1.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      viro_exec: viro_exec
      threads: threads
      viro_db: viro_db
      scan_type: scan_type
      read_1: kraken2/read_1_output
      read_2: kraken2/read_2_output
      output_folder: output_folder
    out: [output]
    
