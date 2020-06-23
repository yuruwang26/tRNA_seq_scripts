#!/bin/bash
mysamples="RPL17_S7_L1_bc10_trim2.QC RPL17_S7_L1_bc7_trim2.QC RPL17_S7_L1_bc8_trim2.QC RPL17_S7_L1_bc9_trim2.QC"

for s in $mysamples
do 

bam-readcount -b 20 -w 1 -f /home/yuruwang/Tao_AlkB_tRNA_seq/genome/hg19CCA+mito_adjusted_names.fa $s.sorted.bam > $s.readcount.txt

wait
done
