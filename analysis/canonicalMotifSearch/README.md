## Canonical motif search

This folder contains documentation and input files for the scripts and code to search subgroup-specific FASTA files for subgroup-specific motifs, returning stats on motif hits.

The results of this analysis relate to Table 5 of the manuscript.

---
### Needed Java classes

The following Java programs are needed:
```
DegnenerateMotif.class
LabelViaDegenerateMotif.class
ShowLabelGroups.class
ComputeLabelGroupStatistics.class
```

---
### Executing programs
The order of running scripts is 
```
./analyzeCanonicalMotifs.sh
```
---
### Description of *analyzeCanonicalMotifs.sh*
A degenerate motif is a motif which can contain, for a given position in the motif, 
individual amino acid residue characters, wildcard characters ('X'), and sets of characters.

A simple example from the analysis is 
```
PXDF[TS]FVC
``` 
which is part of line 3 of the *atlasMotifs.txt* file.

For a sequence fragment to match that mofit, it would have to have a 
P in the 1st position, D in the 3rd, F in the 4th, F in the 6th, V in the 7th, and C in the 8th.
It would have to have either a T or S in the 5th position, and could have any character in the 2nd position.

The *atlasMotifs.txt* file is formatted as follows:
```
PrxSubgroup DegenerateMotif
```
such as
```
Prx5 P[GA]A[FY][TS][PG]XC
Tpx PS[ILV]DTX[VTI]C
Prx1 PXDF[TS]FVC
Prx6 PX[DN][FY]TPVC
PrxQ P[KAR][DA]XTXGC
AhpE PXAF[TS]XXC
```
#### LabelViaDegenerateMotif 
The program *LabelViaDegenerateMotif* looks for matches to any degenerate motifs listed in the *atlasMotifs.txt* file
within a subgroup-specific FASTA file containing proteins sequences for a given Prx subgroup.  

The output of *LabelViaDegenerateMotif* is formatted similar to as follows (this is the first four lines of output for 
a search of the motifs in the *atlasMotifs.txt* file against the AhpE sequences):
```
0 AhpE PXAF[TS]XXC PGAFTSVC
1 NONE
2 AhpE PXAF[TS]XXC PWAFSGIC
3 Prx5 P[GA]A[FY][TS][PG]XC PAAFSPVC
3 AhpE PXAF[TS]XXC PAAFSPVC
```
The first column represents an index for a sequence.  The second represents the subgroup for which there was a match against a motif.
The third represents the motif matched.  The fourth represents the actual sequence fragment matching the motif.
If a sequence matches more than one motif, that is represented with each match on a different line.  There are two lines
with sequence index 3 in the output shown above, indicating that the associated protein has sequence fragments that
matched both the Prx5 and AhpE motif.  

#### ShowLabelGroups
The program *ShowLabelGroups* parses the output for each subgroup analysis from the previous step (*LabelViaDegenerateMotifs*)
to provide a report of how often different sets of motif matches were found.  As an example, the output from continuing the AhpE analysis above would be:
```
AhpE 2
NONE 1
Prx5:AhpE 1
```
indicating that, out of the four protein sequences, two had matches against just the AhpE motif, one had a match against both the 
Prx5 and AhpE motif, and one matched none of the motifs. 

#### ComputeLabelGroupStatistics
One would expect that, for AhpE proteins, the protein sequences would contain hits (matches) against the AhpE motif only.  The
*ComputeLabelGroupStatistics* program takes as input an expected subgroup string and the label groups output from the previous step.
Counts and percentages of how many of the motif matches contained the expected subgroup only, contained the expected subgroup 
as well as other matches, and did not contain the expected subgroup are provided.

As an example, the output from the AhpE analysis used above would be, assuming we were using AhpE as the expected subgroup,
```
AhpE
Total Count: 4
Label Hit: 3,0.75
Exact Hit: 2,0.50
Hit Plus Others: 1,0.25
Miss: 1,0.25
```
This indicates that four sequences were examined.  Three of the four sequences had a match against the AhpE motif (*Label Hit*).
Two of the four matched only the AhpE motif (*Exact Hit*). One of the four matched the AhpE motif and some other motif(s) 
(*Hit Plus Others*), and one sequence did not match the expected AhpE motif (*Miss*).

These analyses are performed for all six subgroups individually. 

To search for different motifs, one can edit the *atlasMotifs.txt* file and then re-run the script.
