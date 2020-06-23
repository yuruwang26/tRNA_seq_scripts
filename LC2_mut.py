import pandas as pd
import csv

reader = pd.read_csv('RPL17_S7_L1_bc10_trim2.QC.readcount.txt', delimiter="\t", names=["chr", "position", "base", "base_sum", "unknown", "A", "C", "G", "T", "N", "X"], chunksize=1000000)
#reader.ncolumns = ["chr", "position", "base", "base_sum", "unknown", "A", "C", "G", "T", "N", "X"]
for df in reader:
    mutation_rate = 0.05
    countGT = 0
    #print (r + len(df))
    for i in range(len(df)):
        A = float(df['A'].iloc[i].split(':')[1])
        C = float(df['C'].iloc[i].split(':')[1])
        G = float(df['G'].iloc[i].split(':')[1])
        T = float(df['T'].iloc[i].split(':')[1])
        if df['base_sum'].iloc[i] >= 20:
            if df['base'].iloc[i] == 'A' or df['base'].iloc[i] == 'a': 
                #if (C + G + T)/df['base_sum'].iloc[i] >= mutation_rate and i+3 < len(df):
                if i+3 < len(df):
                    mut = (C + G + T)/df['base_sum'].iloc[i]
                    print('A->TCG', df['base_sum'].iloc[i], A, T, C, G, df['chr'].iloc[i],df['position'].iloc[i], mut, df['base'].iloc[i-3], df['base'].iloc[i-2], df['base'].iloc[i-1], df['base'].iloc[i], df['base'].iloc[i+1], df['base'].iloc[i+2], df['base'].iloc[i+3])

            if df['base'].iloc[i] == 'T' or df['base'].iloc[i] == 't': 
                #if (A + C + G)/df['base_sum'].iloc[i] >= mutation_rate and i+3 < len(df):
                if i+3 < len(df):
                    mut = (C + G + A)/df['base_sum'].iloc[i]
                    print('T->ACG', df['base_sum'].iloc[i], A, T, C, G, df['chr'].iloc[i],df['position'].iloc[i], mut, df['base'].iloc[i-3], df['base'].iloc[i-2], df['base'].iloc[i-1], df['base'].iloc[i], df['base'].iloc[i+1], df['base'].iloc[i+2], df['base'].iloc[i+3])
            if df['base'].iloc[i] == 'C' or df['base'].iloc[i] == 'c': 
                #if (A + T + G)/df['base_sum'].iloc[i] >= mutation_rate and i+3 < len(df):
                if i+3 < len(df):
                    mut = (A + G + T)/df['base_sum'].iloc[i]
                    print('C->ATG', df['base_sum'].iloc[i], A, T, C, G, df['chr'].iloc[i],df['position'].iloc[i], mut, df['base'].iloc[i-3], df['base'].iloc[i-2], df['base'].iloc[i-1], df['base'].iloc[i], df['base'].iloc[i+1], df['base'].iloc[i+2], df['base'].iloc[i+3])
            if df['base'].iloc[i] == 'G' or df['base'].iloc[i] == 'g': 
                #if (A + T + C)/df['base_sum'].iloc[i] >= mutation_rate and i+3 < len(df):
                if i+3 < len(df):
                    mut = (C + A + T)/df['base_sum'].iloc[i]
                    print('G->ATC', df['base_sum'].iloc[i], A, T, C, G, df['chr'].iloc[i],df['position'].iloc[i], mut, df['base'].iloc[i-3], df['base'].iloc[i-2], df['base'].iloc[i-1], df['base'].iloc[i], df['base'].iloc[i+1], df['base'].iloc[i+2], df['base'].iloc[i+3])