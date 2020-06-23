#!/bin/bash
mySample="RPL17_S7_L1_bc10_trim2 RPL17_S7_L1_bc7_trim2 RPL17_S7_L1_bc8_trim2 RPL17_S7_L1_bc9_trim2"

for s in $mySample
do
fastq_quality_trimmer -t 20 -l 22 -i $s.fastq -o $s.QC.fastq

done
