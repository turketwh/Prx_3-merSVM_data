## SVM cross validation

This folder contains scripts, code, and auxiliary data files to perform 10-fold cross validation on the data in the the 
*harper_SFLD_95 data set*, including reformatting sequences to SVM format, training and testing 10-fold, and analyzing the accuracy of the models. 

These relate to the discussion at the start of *the Results/Classifier perfomance* section of the manuscript (which ends
up as a one sentence statement of the cross-validation performance).

---

The most general instructions are to make sure that the following auxiliary programs are available in this folder:
* svm_learn (from the SVM-Light distribution; see the auxiliary programs section in the main README.md)
* svm_classify (from the SVM-Light distribution; see the auxiliary programs section in the main README.md)

and then to copy over the following Java files from the *analysis/svmModeling* folder:
* CombineScores.java
* GenerateKmerMap.java
* GenerateLabel.java
* GenerateSVMFeatures.java
* JoinActualPredicted.java
* KmerCount.java
* KmerMap.java
* LabelTrainSVM.java
* LabelWithNoLabel.java
* Sequence.java
* SequenceReader.java

and then to compile all of the Java files: *javac \*.java*

If you want to exactly replicate the work in the manuscript (using the same data in each fold as used in the manuscript),
* Copy into this folder all of the files from the folder *data/svmCrossValidationInputs*.  There should be 10 for each subgroup (e.g. AhpE.0, AhpE.1, ..., AhpE.9, Prx1.0, Prx1.1, ..., Tpx.8, Tpx.9)
* Run the following script: *./doCVAnalysis.sh*

Else, if you want to use a different distribution of sequences in each fold, read the comments in and uncomment the appropriate
lines in the file *doCVAnaysis.sh* and then run the script as: *./doCVAnalysis.sh*


The results, printed in a confusion matrix, will be in the file: *crossValidationConfusionMatrix.txt*

More detailed instructions are below.

---
### Auxiliary programs needed
* svm_learn (from the SVM-Light distribution; see the auxiliary programs section in the main README.md)
* svm_classify (from the SVM-Light distribution; see the auxiliary programs section in the main README.md)

### Compiling source code (if available)
If you have access to the source code only, then the Java programs can be compiled using the following commands:
```
javac CombineScores.java
javac GenerateKmerMap.java
javac GenerateLabel.java
javac GenerateSVMFeatures.java
javac JoinActualPredicted.java
javac KmerCount.java
javac KmerMap.java
javac LabelTrainSVM.java
javac LabelWithNoLabel.java
javac Sequence.java
javac SequenceReader.java
javac GenerateIndexedFasta.java
javac GenerateRandomGroups.java
```

(alternatively, execute *javac \*.java*)

---
### Executing programs
The script to run is:
```
./doCVAnalysis.sh
```

---
### Description of *doCVAnalysis.sh*

The script *doCVAnalysis.sh* executes fifteen other scripts, in the following order:
```
./1_generateRandomGroup.sh
./2_generateFastaForGroups.sh
./3_generateLabels.sh
./4_makeDirectories.sh
./5_generateTestData.sh
./6_generateTrainData.sh
./7_generateKmerMap.sh
./8_convertToSVMFeatureRepresentations.sh
./9_generateSVMTrainingInput.sh
./10_generateSVMTestingInput.sh
./11_train.sh
./12_test.sh
./13_setupScoring.sh
./14_doScoring.sh
./15_combineActualPredicted.sh > crossValidationConfusionMatrix.txt
```

The models are built from the *harper_SFLD_95* data set.  Ten-fold cross validation is performed, meaning that the data set needs to be split into 10 folds, and then, iteratively, trained on the annotated sequences in nine of the folds and tested on the sequences in the remaining fold.  This is done 10 times, with the fold left out for testing different each time.  

For a given iteration (with one fold left out), each Prx subgroup is modeled by learning from the sequences in the other nine folds, where the sequences that belong to the subgroup being learned have the positive class label and the other sequences have a negative class label.

The first script *1_generateRandomGroup.sh* determines, through the use of random selection, indices used to break apart each subgroup data set into 10 folds.  

**NOTE**: The line calling the execution of the *1_generateRandomGroup.sh* script in *doCVAnalysis.sh* is currently commented out. That is to allow the work in the manuscript to be replicated exactly.  If you wish to replicate the work in the manuscript, leave the *doCVAnalysis.sh* script as it is and copy into this folder all of the files from the folder *data/svmCrossValidationInputs*. There should be 10 files for each subgroup (e.g. AhpE.0, AhpE.1, ..., AhpE.9, Prx1.0, Prx1.1, ..., Tpx.8, Tpx.9).  This allows you to use the same division of protein sequences into folds as used in the manuscript.  If you wish to generate new folds, do NOT copy over the files from *data/svmCrossValidationInputs*; instead, uncomment this line in the *doCVAnalysis.sh* script.

The second script *2_generateFastaForGroups.sh* uses the indices from the previous step and the FASTA files for the *harper_SFLD_95* data set to generate FASTA-formatted files containing the sequences for each fold.  This is done separately for each subgroup.

The third script *3_generateLabels.sh* generates files for each fold, for each subgroup, that contain the actual label (the label from Harper *et al*.) for each protein sequence in that fold.

The fourth script *4_makeDirectories.sh* creates 10 subfolders, one per fold to handle the training and testing for that fold.  These are named *ds0, ds1, ds2, ..., ds8, ds9*.

The fifth script *5_generateTestData.sh* creates in the appropriate subfolders the FASTA file that contains all instances of protein sequences that will be *tested* (classified) for the fold represented in that subfolder. In addition, a file containing the set of Harper labels for the protein sequences in that fold is also created in that subfolder. For example, all of the sequences associated with fold 0 are concatenated into a *test.fasta file* in the folder *ds0* and all of the labels associated with fold 0 are concatenated into a *test.label* file in the folder *ds0* by these commands:
```bash
# data
cat AhpE.fasta.0 Prx1.fasta.0 Prx5.fasta.0 Prx6.fasta.0 PrxQ.fasta.0 Tpx.fasta.0 > ds0/test.fasta
# labels
cat AhpE.label.0 Prx1.label.0 Prx5.label.0 Prx6.label.0 PrxQ.label.0 Tpx.label.0 > ds0/test.label
```

The sixth script *6_generateTrainData.sh* is similar in purpose to the previous script, exccept it generates the FASTA and label files for the sequences used for *training* (learning) for a given fold in the appropriate subfolders.  As an example, the data used for training fold 0 is created through the following two commands: 
```bash
# data
cat ds1/test.fasta ds2/test.fasta ds3/test.fasta ds4/test.fasta ds5/test.fasta ds6/test.fasta ds7/test.fasta ds8/test.fasta ds9/test.fasta > ds0/train.fasta
# labels
cat ds1/test.label ds2/test.label ds3/test.label ds4/test.label ds5/test.label ds6/test.label ds7/test.label ds8/test.label ds9/test.label > ds0/train.label
```
Note that the data used for *training* in a given fold is a concatenation of the data used for *testing* in all of the other folds.

The seventh script *7_generateKmerMap.sh* iterates over the training sequences in a fold and generates a k-mer map, a listing of all unique 3-mers found in the training sequences and a unique id for each. This is later used in encoding the sequences to an SVM-Light compatible format.  A separate k-mer map is generated for the training data in each fold subfolder.

The eighth script *8_convertToSVMFeatureRepresentations.sh* converts the FASTA equences used for training and testing in each fold to a representation where the count of each 3-mer is recorded.  For each sequence, if a k-mer occurs > 0 times, the numerical id for the k-mer (from the k-mer map) is recorded along with how many times it was present. 

The ninth script *9_generateSVMTrainingInput.sh* uses the label files generated in the previous steps to prepend a +1 (positive class) or -1 (negative class) label to the SVM-Light compatible *training* data files generated in the immediately previous step.  This is done individually for each subgroup, so that there are now appropriately SVM-labeled and SVM-formatted inputs for each fold for each Prx subgroup.  This allows six different classifiers (one per subgroup) to be learned for each fold. 

The tenth script *10_generateSVMTestingInput.sh* associates a 0 (unknown class) label to the to the SVM-Light compatible *testing* data files generated by the 8th script.  

The eleventh script *11_train.sh* calls the auxiliary program *svm_learn* to build, for each fold, a linear SVM model for each subgroup based on the training data for each subgroup generated in the previous steps.  An example of the execution for the first fold is below:
```
#ds0
./svm_learn -t 0 ds0/train.svm.AhpE ds0/linearModel.AhpE
./svm_learn -t 0 ds0/train.svm.Prx1 ds0/linearModel.Prx1
./svm_learn -t 0 ds0/train.svm.Prx5 ds0/linearModel.Prx5
./svm_learn -t 0 ds0/train.svm.Prx6 ds0/linearModel.Prx6
./svm_learn -t 0 ds0/train.svm.PrxQ ds0/linearModel.PrxQ
./svm_learn -t 0 ds0/train.svm.Tpx  ds0/linearModel.Tpx
```

The twelfth script *12_test.sh* uses, for each fold, the auxiliary program *svm_classify* and the six linear models learned (via the previous step) to compute six subgroup-specific SVM scores for each testing sequence in a given fold.  An example of the execution for the first fold is below:
```
#ds0
./svm_classify ds0/test.svmInput ds0/linearModel.AhpE ds0/scores.AhpE
./svm_classify ds0/test.svmInput ds0/linearModel.Prx1 ds0/scores.Prx1
./svm_classify ds0/test.svmInput ds0/linearModel.Prx5 ds0/scores.Prx5
./svm_classify ds0/test.svmInput ds0/linearModel.Prx6 ds0/scores.Prx6
./svm_classify ds0/test.svmInput ds0/linearModel.PrxQ ds0/scores.PrxQ
./svm_classify ds0/test.svmInput ds0/linearModel.Tpx  ds0/scores.Tpx
```

The thirteenth script *13_setupScoring.sh* copies two files - a file named *scoreDB.txt* containing filenames of where to look for scores and a Java program named *CombineScores* which combines the scores from each subgroup classifier - into the subfolders for each fold.  

The fourteenth script *14_doScoring.sh* goes into the subfolder for each fold and combines, for each sequence in the *testing* data, the scores from each classifier and finds the maximum score. Each sequence in the testing data is then annotated with the subgroup which is associated with that maximum score. 

The fifteenth (and final) script *15_combineActualPredicted.sh* joins, for each fold, the Prx_3-merSVM annotations for each protein sequence in the *testing data* with the labels for those sequences from Harper *et al*.  The Unix *grep* command is then used to extract a confusion matrix highlighting how often a given sequence was annotated with a given Harper/Prx_3merSVM pair.  Ideally, the Harper/Prx_3-merSVM pair would be the same annotation (such as AhpE:Ahpe); cases where they do not match were further analyzed. 

The final output is in the file *crossValidationConfusionMatrix.txt* which has a format similar to the following:
```
AhpE:AhpE
138
AhpE:Prx1
0
AhpE:Prx5
0
AhpE:Prx6
0
AhpE:PrxQ
0
AhpE:Tpx
0
Prx1:AhpE
0
Prx1:Prx1
1310
Prx1:Prx5
0
```

Each pair of lines should be interpreted as the number of protein sequences which had a given Harper and a given Prx_3-merSVM annotation.  For each line *X:Y* the string X represents the Harper annotation and the string Y represents the Prx_3-merSVM annotation.  The number below that line is how many protein sequences had that pair of annotations.  Since there are six possible subgroup annotations, the file will have 72 lines (2 each for the 36 pairs of annotations).

Interpreting the lines above, there were 138 proteins annotated as AhpE by both Harper and Prx_3-merSVM.  The rest of the AhpE:Y pairs indicate there were no mismatches in annotations between Harper and Prx_3-merSVM on this data for the AhpE proteins.  This is indicated by the 0 value for all other AhpE:Y pairs.  The data also shows there were 1310 proteins annotated as Prx1 by both Harper and Prx_3-merSVM.  

