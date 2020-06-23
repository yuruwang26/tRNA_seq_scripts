S7_bc7 <- read.csv("~/Tao_AlkB_tRNA_seq/dedupe/trim1/sorted/trim2/SAM_files/SAM/RPL17_S7_L1_bc7.mut.csv")
S7_bc8 <- read.csv("~/Tao_AlkB_tRNA_seq/dedupe/trim1/sorted/trim2/SAM_files/SAM/RPL17_S7_L1_bc8.mut.csv")
S7_bc9 <- read.csv("~/Tao_AlkB_tRNA_seq/dedupe/trim1/sorted/trim2/SAM_files/SAM/RPL17_S7_L1_bc9.mut.csv")
S7_bc10 <- read.csv("~/Tao_AlkB_tRNA_seq/dedupe/trim1/sorted/trim2/SAM_files/SAM/RPL17_S7_L1_bc10.mut.csv")


names(S7_bc7) <- c("mutation", "base_sum", "base_A", "base_T", "base_C", "base_G", "chr_loc", "pos", "mut_rate", "loc-3", "loc-2", "loc-1", "loc", "loc+1", "loc+2", "loc+3")
names(S7_bc8) <- c("mutation", "base_sum", "base_A", "base_T", "base_C", "base_G", "chr_loc", "pos", "mut_rate", "loc-3", "loc-2", "loc-1", "loc", "loc+1", "loc+2", "loc+3")
names(S7_bc9) <- c("mutation", "base_sum", "base_A", "base_T", "base_C", "base_G", "chr_loc", "pos", "mut_rate", "loc-3", "loc-2", "loc-1", "loc", "loc+1", "loc+2", "loc+3")
names(S7_bc10) <- c("mutation", "base_sum", "base_A", "base_T", "base_C", "base_G", "chr_loc", "pos", "mut_rate", "loc-3", "loc-2", "loc-1", "loc", "loc+1", "loc+2", "loc+3")

library (dplyr)

genes1 <- c("chr2.trna3-AlaAGC", "chr6.trna10-AlaCGC", "chr12.trna8-AlaTGC", "chr17.trna28-CysGCA", "chr1.trna69-AspGTC", "chr1.trna116-GluCTC",
"chr1.trna134-GluTTC", "chr11.trna15-PheGAA", "chr1.trna133-GlyCCC", "chr1.trna35-GlyGCC", "chr1.trna117-GlyTCC", "chr1.trna111-HisGTG", 
"chr6.trna57-IleAAT", "chr2.trna5-IleTAT", "chr1.trna119-LysCTT", "chr1.trna54-LysTTT", "chr5.trna16-LeuAAG", "chr1.trna34-LeuCAG", 
"chr16.trna27-LeuTAG", "chr1.trna58-LeuCAA", "chr6.trna141-LeuTAA","chr1.trna32-MetCAT", "chr6.trna75-MetCAT","chr1.trna26-AsnGTT", 
"chr1.trna65-ProAGG", "chr1.trna52-ProCGG", "chr14.trna3-ProTGG", "chr1.trna15-GlnCTG", "chr6.trna64-GlnTTG", 
"chr3.trna11-ArgACG", "chr16.trna1-ArgCCG", "chr6.trna4-ArgTCG", "chr7.trna3-ArgCCT", "chr1.trna9-ArgTCT", "chr14.trna8-SecTCA","chr6.trna147-SerAGA", 
"chr12.trna2-SerCGA", "chr6.trna51-SerTGA", "chr6.trna43-SerGCT", "chr17.trna36-ThrAGT", "chr6.trna121-ThrCGT", 
"chr1.trna56-ThrTGT", "chr3.trna2-ValAAC", "chr1.trna85-ValCAC", "chr10.trna6-ValTAC", "chr12.trna6-TrpCCA", "chr6.trna14-TyrGTA")

for (g in genes1) 
{
filter_file_1 <- dplyr::filter(S7_bc7, grepl(g, chr_loc))
select_file_1 <- select(filter_file_1, pos, mutation, mut_rate) 
colnames(select_file_1) <- c("pos","type","No_enzyme")
filter_file_2 <- dplyr::filter(S7_bc8, grepl(g, chr_loc))
select_file_2 <- select(filter_file_2, pos, mut_rate)
colnames(select_file_2) <- c("pos", "WT") 
filter_file_3 <- dplyr::filter(S7_bc9, grepl(g, chr_loc))
select_file_3 <- select(filter_file_3, pos, mut_rate) 
colnames(select_file_3) <- c("pos","D135S")
filter_file_4 <- dplyr::filter(S7_bc10, grepl(g, chr_loc))
select_file_4 <- select(filter_file_4, pos, mut_rate) 
colnames(select_file_4) <- c("pos","D135T")

select_file <- merge(select_file_1,select_file_2, by = c("pos","pos"),all.x =TRUE, all.y = TRUE)
select_file <- merge(select_file, select_file_3, by = c("pos","pos"),all.x =TRUE, all.y = TRUE)
select_file <- merge(select_file, select_file_4, by = c("pos","pos"),all.x =TRUE, all.y = TRUE)

write.csv(select_file, file=paste0("~/Tao_AlkB_tRNA_seq/dedupe/trim1/sorted/trim2/SAM_files/mutations/", g,"rate_summary", ".csv"))
jpeg(paste0("~/Tao_AlkB_tRNA_seq/dedupe/trim1/sorted/trim2/SAM_files/mutations/plots1/", g,".rplot.jpg"), width = 1200, height = 500)
plot(select_file$pos, select_file$No_enzyme, type="n", col ="blue", main = g)
points(select_file$pos, select_file$WT, type="n", col ="red")
points(select_file$pos, select_file$D135S, type="n", col ="green")
points(select_file$pos, select_file$D135T, type="n", col ="pink")
lines(select_file$pos, select_file$No_enzyme, col ="blue")
lines(select_file$pos, select_file$WT, col ="red")
lines(select_file$pos, select_file$D135S, col ="green")
lines(select_file$pos, select_file$D135T, col ="pink")
legend("topright", legend=c("No_enzyme", "WT", "WT + D135S", "WT + D135T"), col=c("blue", "red", "green", "pink"), lty=1:2, cex=1.2)
dev.off()
}