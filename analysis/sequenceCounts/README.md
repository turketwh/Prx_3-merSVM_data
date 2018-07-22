## Sequence counts

This folder contains data, scripts, and code to search subgroup-specific FASTA files for 3-mers and sets of 3-mers, 
returning counts on how many 3-mer hits there are within the FASTA files.  


The results of this analysis relate to Tables 9, 10, and 11; the corresponding discussion in the manuscript; and the tables
and discussion in supplementary information *Additional file 2*.

---
### Compiling source code (if available)
If you have access to the source code only, then the Java programs can be compiled using the following commands:
```
javac FindSequenceMatches.java
javac FindMatchesAgainstAll.java
```

---
### Executing programs
The scripts to run are:
```
./doAhpEAnalysis.sh
./doPrx1Analysis.sh
./doPrx5Analysis.sh
./doPrx6Analysis.sh
./doPrxQAnalysis.sh
./doTpxAnalysis.sh
```

The six scripts could be run simultaneously and/or in any order.

---
### Description of *doAhpEAnalysis.sh* (the other five subgroup-specific scripts are similar)
This script contains the following program uses:
```
java FindSequenceMatches AhpE.3mers.txt ../../data/sequences/harper/AhpE.fasta AhpE.3mers.inFullHarper.txt 
java FindSequenceMatches AhpE.3mers.txt ../../data/sequences/harper_SFLD_95/AhpE.fasta AhpE.3mers.in95HarperSFLD.txt 
java FindMatchesAgainstAll AhpE.3mers.txt ../../data/sequences/harper/AhpE.fasta AhpE.3mers.inFullHarper.allIn.txt 
java FindMatchesAgainstAll AhpE.3mers.txt ../../data/sequences/harper_SFLD_95/AhpE.fasta AhpE.3mers.in95HarperSFLD.allIn.txt 
```

The file AhpE.3mers.txt contains a list of 3-mers:
```
WPH
PHG
DFW
FWP
```

The first program, *FindSequenceMatches*, computes, for each 3-mer separately, in how many sequences in the FASTA file being 
searched each 3-mer is found. The program will print *to the screen* the number of sequences in which each 3-mer was found, and
will dump to the output file lines like the following:
```
0 WPH 1 2 5 16 21 24 25 28 31 32 34 38 41 42 43 48 49 50 51 52 53 54 55 56 57 58 59 60 61
62 63 64 65 ...
```
where each line has an index for a 3-mer (0..n), the 3-mer iteslf, and then a list of indices for each sequence the 3-mer appears in.

The second program, *FindMatchesAgainstAll*, computes, for the entire set of 3-mers, in how many sequences in the FASTA file being 
searched all of the 3-mers are found. The program will dump to the output file one line like the following
```
1055 of 1489
```
indicating that 1055 of the 1489 sequences searched contained all of the set of 3-mers searched for.

For this work, both the *harper* and *harper_SFLD_95* data sets are searched.

Different 3-mers are desired to be searched in the different subgroup-specific FASTA files, leading to the six different scripts.

For some subgroups, different sets are searched for, leading to mulitple instances of the four lines above being employed, switching
out the file describing the 3-mer sets.

