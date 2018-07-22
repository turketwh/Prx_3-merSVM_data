## SVM error analyis

This folder contains scripts and code to determine and extract the protein sequences for which there was a difference
in annotation between the Harper approach and the Prx_3-merSVM classifier

The results of this analysis relate to Tables 6 and 7 and the corresponding discussions in the manuscript.

---
### Compiling source code (if available)
If you have access to the source code only, then the Java programs can be compiled using the following commands:
```
javac ExtractErrorInformation.java
javac ExtractErrorSequences.java 
```
---
### Executing programs
The scripts to run are:
```
./findAndExtractErrorSequences.sh
```
---
### Description of *findAndExtractErrorSequences.sh*

This script relies on the output from the classification process in the *svmModeing* folder.  The needed file is: 
*harper_actual_predicted.all*.    The file from the actual analysis is stored in the folder *data/svmCoreOutputs/* 
in this repository and could also be regenerated if desired.  The file contains, for each sample classified, 
the haper label and the Prx_3-merSVM label separated by a semi-colon.  As an example, the first four lines are:
```
AhpE:AhpE
AhpE:AhpE
AhpE:AhpE
AhpE:AhpE
```

The program *ExtractErrorInformation* searches that file for any lines where the two labels aren't the same and prints that 
there was an error, followed by the two labels, and then in which sequence in which subgroup data set the error was on.  
The four errors in the actual analysis are shown below:
```
Error: AhpE:Prx5 AhpE sample# 47
Error: AhpE:PrxQ AhpE sample# 1193
Error: AhpE:PrxQ AhpE sample# 1296
Error: Prx6:PrxQ Prx6 sample# 2865
```

The Unix utility *grep* is then used to extract, for each subgroup, the indices relevant to that subgroup. For example:
```bash
grep "AhpE sample" svmErrorInformation.txt | awk '{print $5}' > AhpE.errorIndices.txt
```

creates a file with the following indices:
```
47
1193
1296
```

The program *ExtractErrorSequences* then is passed as input a sequence data set and the indices for which there was an
error by the Prx_3-merSVM classifer.  It outputs a FASTA-formatted file of the relevant sequences.  The output for
the AhpE data used as the examples above is:
```
>ELY63016.1 bacterioferritin comigrating protein [Natronococcus jeotgali DSM 18795]
MVALQERLDELQDAGATFFPGAFTPPCSNEMVALQERLDELQDAGATLFGISADSSFSLGAFADEYDLEFDLISDMGGEAIPEYDLSIDIPDLGLYGVAN
RAVIVLDEDRTVTYRWVAEDPTNEPDYDELIEAVEAV
>WP_051670221.1 hypothetical protein [Bryobacter aggregatus]
MTQGVNMKRRDVVLTAGAVGAAAMLQGQTPAAPPKTHLKVGDTAPDFKVPTTTASKSFQLSDYKGKSGVVVAFFPAAFTGGCTKEMTAYGNEIKKFQDMG
FEVIGISTDNTPSLAYWAEHMLKVNAPLGSDFATRKTAEAYGVLMKDRGIANRATFVIDKEGKIVHIEEGSAAVDISGAANACARVKGKS
>WP_055763280.1 peroxiredoxin [Geodermatophilus sp. Leaf369]
MKRGDVAPDFELPDQDGTPRRLSTMLQDGPVVLFFYPLASSGGCTTEMCSVRDEQARFAAVGAQRVGISRDSVQKQKAFAEGNGFDYPLLADVDGGVCEA
YGTKRNMNAAPVKRHTYVIGTDGLVKDVIKSEFRFAKHADKALAALSPS
```

Since only errors existed in AhpE- and Prx6-labeled proteins, analyses are only done on those two data sets.  If
there were other erors, the associated lines in this script could be uncommented to find the relevant error sequences.
