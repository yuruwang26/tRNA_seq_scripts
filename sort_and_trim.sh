#!/bin/bash

grep -A 2 -B 1 "CTA$" RPL17_S7_L004_merge.dedupe.trim1.fastq | sed "/^--$/d" > ./sorted/RPL17_S7_L1_bc10.fastq
grep -A 2 -B 1 "TGT$" RPL17_S7_L004_merge.dedupe.trim1.fastq | sed "/^--$/d" > ./sorted/RPL17_S7_L1_bc7.fastq
grep -A 2 -B 1 "CAC$" RPL17_S7_L004_merge.dedupe.trim1.fastq | sed "/^--$/d" > ./sorted/RPL17_S7_L1_bc8.fastq 
grep -A 2 -B 1 "GCG$" RPL17_S7_L004_merge.dedupe.trim1.fastq | sed "/^--$/d" > ./sorted/RPL17_S7_L1_bc9.fastq 

#trim 3' adaptors#

cd sorted

cutadapt -u -7 -o ./trim2/RPL17_S7_L1_bc10_trim2.fastq RPL17_S7_L1_bc10.fastq
cutadapt -u -7 -o ./trim2/RPL17_S7_L1_bc7_trim2.fastq RPL17_S7_L1_bc7.fastq
cutadapt -u -7 -o ./trim2/RPL17_S7_L1_bc8_trim2.fastq RPL17_S7_L1_bc8.fastq
cutadapt -u -7 -o ./trim2/RPL17_S7_L1_bc9_trim2.fastq RPL17_S7_L1_bc9.fastq 

