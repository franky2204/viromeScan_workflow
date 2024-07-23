cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["bash", "-c"]

inputs:
  read_1:
    type: File
  kraken_res_dir:
    type: Directory

arguments:
  - valueFrom: >
      file=$(basename $(inputs.read_1.path) | cut -d'_' -f1).kraken2;
      if [ -f $(inputs.kraken_res_dir.path)/$file ]; then
        cp $(inputs.kraken_res_dir.path)/$file $(inputs.kraken_res_dir.basename | cut -d'_' -f1).kraken2;
      else
        echo "File not found: $(inputs.input_dir.path)/$file" 1>&2;
        exit 1;
      fi
    shellQuote: false

outputs:
  kraken_res:
    type: File
    outputBinding:
      glob: "*.kraken2"
