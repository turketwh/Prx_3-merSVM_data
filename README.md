# Prx_3-merSVM_data
Data and documentation for Prx_3merSVM project - a Prx subgroup annotation tool based on whole sequence 3-mer representation and SVM classifier

These files are associated with the manuscript:
K-mer based classifiers extract functionally relevant features to support accurate Peroxiredoxin subgroup distinction
by Jiajie Xiao and William Turkett, Jr.

The manuscript was submitted to BMC Bioinformatics on DATE.

A preprint is available on BioArxiv at: 

The appropriate point of contact is William Turkett.  Email is turketwh at my insitution's domain, wfu.edu.
***
A cloud-based (Amazon Web Services) implementation of the classifier is available [here](http://prxsubfamilyclassif-env.us-east-1.elasticbeanstalk.com/).
***

The organization of this repository includes data:
* data/harperOriginal - Information on and links to the Harper *et al.* Excel file that contained the information on which this work built.
* data/sequences/harper - FASTA sequences for the full Harper dataset.  Each file contains instances of one subgroup.
* data/sequences/harper_SFLD - FASTA sequences for the data set representing the intersection of the Harper data set and the annotated Prx in SFLD.  Each file contains instances of one subgroup. 
* data/sequences/harper_SFLD_95 - A subset of the FASTA sequences for the harperSFLD data set, after 95% similarity filtering using CD-Hit. The similarity filtering was performed independently for each subgroup.  Each file contains instances of one subgroup.  Also contains negative set files, which contain, for each subgroup, the sequences of the proteins not in that subgroup.  These negative set files are used in the support vector machine modeling. 
* data/activeSiteSignatures - Raw active site signature information extracted from the Excel file referenced in the data/harperOriginal folder.  These are futher transformed and then searched by tools in the analysis/activeSiteSignatures folder.
* data/modelsSVM - The SVM-Light models for each subgroup, generated from training on the harper_SFLD_95 data.  These models were used for the classification of the full Harper data set, which directly leads to the results and discussion surrounding Table 2 and Table 7 in the manuscript, and indirectly to the results and discussion surrounding Table 3, Table 6, Table 8, and Figure 1.  They also are the models described as "3-mer SVM (Version 1.0)" in the publicly available cloud-based implementation of the classifier.
* data/svmCoreOutputs - Outputs from classifying the Harper data set.  Includes a list, for the full Harper data set, of the Harper annotation and the 3-merSVM annotation.  This information is directly tied to Table 6 and Table 7 and Figure 1 in the manuscript.
* data/svmCrossValidationInputs - The indices of proteins in each of the subgroup specific FASTA files in the harper_SFLD_95 data set that are assigned to each cross-validation fold data set.  These are used in conjunction with the cross validation analysis and relate to the discussion at the start of the *Results/Classifier perfomance* section of the manuscript.
* data/permutationTestingOutput - Links to Google Drive with the actual data used for the permutationTesting analysis.  The files are too large to include in the Github repository.

as well as documentation for the code:
* analysis/canonicalMotifSearch - Search subgroup specific FASTA files for subgroup-specific motifs, returning stats on motif hits (Table 5 in the manuscript when applied to the harper data set).
* analysis/sequenceCounts - Search subgroup specific FASTA files for 3-mers and sets of 3-mers, returning counts on how many 3-mer hits there are (Tables 9, 10, and 11 and the corresponding discussions in the Discussion section of the manuscript; Additional information in supplemetnary *Additional file 2*).
* analysis/weblogoGeneration - Extraction and alignment of sequence regions around 3-mers of interest (Figures 2, 3, 4, 5, and 6 and the corresponding discussions in the Discussion section of the manuscript)
* analysis/svmErrorAnalysis - Determination and extraction of the protein sequences for which there was a difference in annotation between the Harper approach and the 3-merSVM classifier
* analysis/permutationTesting - Implementation of permutation testing to determine a significance for a given 3-mer's weight for a given subgroup; based on repeatedly shuffling labels and re-training, and counting how often weights >= the original weight are seen
* analysis/activeSiteSignatures - Re-format active site signatures from Harper *et al.* and search for 3-mers within those signatures.  Relates to the AS% column of Table 3 in the manuscript.
* analysis/svmModeling - Format the harper_SFLD_95 data set in SVM format, learn subgroup-specific models from the harper_SFLD_95 data set, format the harper data set in SVM format, use the learned models on the harper data set, and analyze the accuracy of the models.  These processes directly relate to Tables 2, 3, 7, and 8, and Figure 1 in the manuscript.
* analysis/svmCrossValidation - Perform 10-fold cross validation on the data in the the harper_SFLD_95 data set, including reformatting sequences to SVM format, training and testing 10-fold, and analyzing the accuracy of the models.  Used in conjunction with the cross validation analysis and relate to the discussion at the start of the *Results/Classifier perfomance* section of the manuscript.  

***
The actual software is available from this link.  The software is shared through that mechanism instead of through Github due to University requirements relating to software intellectual property and export control. 

The software structure assumes execution on a Unix-style operating system.  The main program components are written in Java, so they should be executable anywhere, but the additional scripts, as well as references to directories, make use of Unix syntax.  
***
The following programs are not included in the repository, but were used in the analyses.  Links to their source are provided below:
* Implementation of support vector machine: SVM-Light, version 6.0.1 - [Source code for version 6.0.1](http://download.joachims.org/svm_light/v6.01/svm_light.tar.gz), [General documentation](http://svmlight.joachims.org/)
* Extraction of linear hyperplane weight vector from SVM-Light models: svm2weight.py - [Source code](http://www.cs.cornell.edu/people/tj/svm_light/svm2weight.py.txt), [FAQ where discussed](http://www.cs.cornell.edu/people/tj/svm_light/svm_light_faq.html)
* Alignment of sequence fragments: Clustal Omega, version 1.2.4 (using the pre-compiled 32-bit Linux binary) - [Precompiled 32-bit Linux binary for version 1.2.4](http://www.clustal.org/omega/clustalo-1.2.4-Ubuntu-32-bit), [Source code for version 1.2.4](http://www.clustal.org/omega/clustal-omega-1.2.4.tar.gz), [General documentation](http://www.clustal.org/omega/)
* Generation of weblogos: WebLogo 3, version 3.6 (online version) - [Online version](http://weblogo.threeplusone.com/create.cgi), [General documentation](http://weblogo.threeplusone.com/manual.html)
* Sequence similarity filtering: CD-HIT, Github master branch as of Nov 3, 2017 (should be effectively equivalent to release 4.6.8) - [Source code for version 4.6.8](https://github.com/weizhongli/cdhit/archive/V4.6.8.tar.gz), [Current Github master branch](https://github.com/weizhongli/cdhit), [General documentation](http://weizhongli-lab.org/cd-hit/)

Any non-Weblogo images were generated with gnuplot, a plotting package that is common on Unix systems.  Specifically, version 4.2, patchlevel 6 was used.  More information on gnuplot can be found at the following links: [Homepage](http://www.gnuplot.info/), [Downloads of different versions](https://sourceforge.net/projects/gnuplot/files/gnuplot/), [General documentation](http://www.gnuplot.info/documentation.html)

*** 
The following other Prx annotation tools were referenced in the manuscript and are linked here for easy access:
* Structure-Function Linkage Database - [Homepage](http://sfld.rbvi.ucsf.edu/django/), [Search page](http://sfld.rbvi.ucsf.edu/django/search/), [Prx-specific information](http://sfld.rbvi.ucsf.edu/django/superfamily/24/)
* PREX Database - [Homepage](http://csb.wfu.edu/prex/), [Search page](http://csb.wfu.edu/prex.test/search.php)
* MISST/DASP3 - [Github repository](https://github.com/RBVI/dasp3)
* Conserved Domain Database - [Homepage](https://www.ncbi.nlm.nih.gov/Structure/cdd/cdd.shtml), [Search page](https://www.ncbi.nlm.nih.gov/Structure/bwrpsb/bwrpsb.cgi)
