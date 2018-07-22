## Weblogo generation

This folder contains data, scripts, and code to extract and align sequence regions around 3-mers of interest. 

The results of this analysis relate to Figures 2, 3, 4, 5, and 6 and the corresponding discussions in the *Discussion* 
section of the manuscript, as well as the figures and corresponding discussion in the supplementary file *Additional file 2*.

---
### Auxiliary programs needed
The *clustalo* executable needs to be copied into the folder where these programs and scripts are located (see the auxiliary 
programs section in the main README.md)

### Compiling source code (if available)
If you have access to the source code only, then the Java programs can be compiled using the following commands:
```
javac ExtractSequencesWithMatch.java
javac MapBackKmer.java
```

---
### Executing programs
The scripts to run are:
```
./mapBackAndAlign.sh
```
---
### Description of *mapBackAndAlign.sh*
This script contains multiple instances of the following program uses:
```
java ExtractSequencesWithMatch AhpE.3mers.txt ../../data/sequences/harper/AhpE.fasta AhpE.with43mers.fasta
java MapBackKmer FWP AhpE.with43mers.fasta FWP.AhpE.mb
./clustalo -i FWP.AhpE.mb -o FWP.AhpE.aln
```
Each instance is searching for, within a subgroup-specific FASTA file, and analyzing a set of one or more 3-mers of interest.

For the example above, the file AhpE.3mers.txt contains the following list of 3-mers:
```
WPH
PHG
DFW
FWP
```
and the sequence file being searched is for the *harper* data set.

The first program, *ExtractSequencesWithMatch*, extracts from the given FASTA file the sequences for those proteins in which
all of the set of 3-mers searched for are found.  The output is another FASTA formatted file.

The second program, *MapBackKmer*, takes one 3-mer and extracts the sequences that contain the 3-mer and residues +/-8 residues 
in either direction.  For cases where the previous program *ExtractSequencesWithMatch* step looked for multiple 3-mers, the use case
for this 2nd program is to only use one of those as the center, under the assumption that the 3-mers appear within close proximity
to each other.  For example, the four 3-mers above - WPH, PHG, DFW, FWP - almost always appear together as a run of residues - DFWPHG.

The  output of this program is a FASTA formatted file, but where the sequences are only made up of the extracted 19-residue regions. 
An example of the first few lines of output from the analysis shown above is: 
```
>pdb|1XVW|A Chain A, Crystal Structure Of Ahpe From Mycobacterium Tuberculosis, A 1-Cys Peroxiredoxin
FTFPLLSDFWPHGAVSQAY
>EAP99412.1 putative thiol-specific antioxidant protein [Janibacter sp. HTCC2649]
YFFPLLSDFWPHGEVARAY
>ABK03841.1 Redoxin domain protein [Arthrobacter sp. FB24]
YGFDLLADFWPHGAVAAQY
>CAQ01715.1 hypothetical protein CMS1605 [Clavibacter michiganensis subsp. sepedonicus]
IDFQLLADFWPHGQVAKEY
```

Finally, the program *clustalo* aligns the sequences in the FASTA file generated from the *MapBackKmer* program.
For the example above, the alignmet is very clean, with the first few lines of output being:
```
>pdb|1XVW|A Chain A, Crystal Structure Of Ahpe From Mycobacterium Tuberculosis, A 1-Cys Peroxiredoxin
FTFPLLSDFWPHGAVSQAY
>EAP99412.1 putative thiol-specific antioxidant protein [Janibacter sp. HTCC2649]
YFFPLLSDFWPHGEVARAY
>ABK03841.1 Redoxin domain protein [Arthrobacter sp. FB24]
YGFDLLADFWPHGAVAAQY
>CAQ01715.1 hypothetical protein CMS1605 [Clavibacter michiganensis subsp. sepedonicus]
IDFQLLADFWPHGQVAKEY
```

In many cases, gaps, indicated by a dash (-), will be present in the alignments.  For these data sets, the gaps are often not 
within 19-mers, but before or after, based on the fact that sometimes the center 3-mer of interest occurs more than
once in a few sequences. These occasional extra 19-mers, that do not align well with the broadly conserved pattern, end up causing 
gaps to the left or the right of the broadly conserved part of the alignment.


After the scripts are executed, the alignments are then used as manual input to the WebLogo webserver, and the weblogos are trimmed
to just highlight the broadly conserved pattern.

The script can be added to in order to handle the processing of additional 3-mers of interest.
