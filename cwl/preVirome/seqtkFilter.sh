file1=$1
file2=$2
sequence=$3

file_name=$(basename $file1)
pure_name=$(echo ${file_name} | cut -d'_' -f1)

unpigz $file1 > out1.fastq
unpigz $file2 > out2.fastq

seqtk subseq out1.fastq $sequence > ${pure_name}_NB_R1.fastq
seqtk subseq out2.fastq $sequence > ${pure_name}_NB_R2.fastq