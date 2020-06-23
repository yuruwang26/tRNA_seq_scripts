#!/bin/bash

mysamples="RPL17_S7_L1_bc10_trim2.QC RPL17_S7_L1_bc7_trim2.QC RPL17_S7_L1_bc8_trim2.QC RPL17_S7_L1_bc9_trim2.QC"

for s in $mysamples
do

bowtie2 -p 8 -x ~/Tao_AlkB_tRNA_seq/genome/hg19CCA+mito+spike-in -U $s.fastq -S ./SAM_files/$s.sam

cd SAM_files

samtools view -b $s.sam -o $s.bam
samtools sort $s.bam -o $s.sorted.bam
samtools index $s.sorted.bam $s.sorted.bai

cd /home/yuruwang/Tao_AlkB_tRNA_seq/dedupe/trim1/sorted/trim2

done
