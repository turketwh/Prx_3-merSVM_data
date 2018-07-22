## Active site signature analysis 

This folder contains documentation and input files for the scripts and code to re-format active site signatures provided in the supplementary information of Harper *et al*. and data, documentation, and input files for scripts and source code to search for 3-mers within those signatures.  The associated scripts and source code are available through the link provided in the main *README.md* file.

The results of this analysis relates to the AS% column of Table 3 of the manuscript.

---
### Needed Java classes
The following Java programs are needed
```
AddRegionMarkers.class
FilterOutReplicates.class
ActiveSiteAnalysis.class
```

---
### Executing programs
The order of running scripts is 
```
./reformatASRs.sh
./analyzeASRs.sh
```
---
### Description of *reformatASRs.sh*
The script *reformatASRs.sh* will first use the *AddRegionMarkers* program to convert the active site sequence signatures 
scraped from the supplementary information of Harper *et al*. ( which are found in the *data/activeSiteSignatures* 
folder of the repository) from their original format to a more parse-able format.

Active site sequence signatures are in their own per-subgroup files (so there are six files), and this is kept after conversion.


The original format is:
```
LFYPFAFTGVCTGELCEtlrvfaeqeLAVSNDSypllsAIQVG
```
where the change in case represents a distinct sequence fragment.

After conversion, the signature above will be stored as: 
```
LFYPFAFTGVCTGELCE-TLRVFAEQE-LAVSNDS-YPLLS-AIQVG
```
where each sequence fragment is in uppercase and fragments are separated by a dash.

The script will then remove, using the *FilterOutReplicates* program, any redundant active site 
sequence signatures for a subgroup.  Effectively, it only keeps unique instances of each signature 
present in a given subgroup file. 

---
### Description of *analyzeASRs.sh*
The script *analyzeASRs.sh* will use the *ActiveSiteAnalysis* program to search for a given set of k-mers 
within the re-formatted and filtered active site signatures for a given subgroup. An example of one step of 
the script is
```
java ActiveSiteAnalysis AhpE.kmersOfInterest.txt filteredMASRs.AhpE.txt asAnalysis.AhpE.txt
```
which will search for a set of 3-mers which have been indicated of interest for the subgroup AhpE within 
the re-formatted and filtered *AhpE* acstive site signatures.  A similar analysis is done for the other
five Prx subgroups.

The output file is formatted as follows:
```
FFP 434 975 0.4451282051282051
ELC 492 975 0.5046153846153846
LAF 303 975 0.31076923076923074
```
Each line represents a 3-mer, the number of active site signatures in the file searched that the 3-mer 
appeared in, the total number of active site signatures in the file searched and the percentage of active site 
signatures in the file searched that the 3-mer appeared in (effectively column2 / column 3).

To search for different k-mers, one can edit the files holding the k-mers of interest and re-run the programs
with the *analyzeASRs.sh* script, or one can run the analysis of each subgroup individually (extracting the relevant program use)
if not all six subgroups need to be analyzed again. 



