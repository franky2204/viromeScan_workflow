#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}
  LoadListingRequirement:
    loadListing: shallow_listing

inputs:
  dir:
    type: Directory
  read_1:
    type: File

expression: |
  ${
    var files = inputs.dir.listing;
    var name = inputs.read_1.basename.split(".")[0];
    var name2 = name.split("_")[0];
    var result = null;

    files.forEach(function (file) {
      if (file.basename.endsWith(".kraken2") && file.basename.startsWith(name2)){
        result = file;
      }
    });

    return {"kraken_res": result};
  }

outputs:
  kraken_res: 
    type: File
