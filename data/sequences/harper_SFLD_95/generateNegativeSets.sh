## The SVM training needs "negative sets" 
## (e.g., all sequences that are NOT AhpE samples)
## This file generates those by concatenating the 
## subgroup specific sequence files as needed
## 
## Generate NOT AhpE
cat Prx1.fasta Prx5.fasta Prx6.fasta PrxQ.fasta Tpx.fasta > allButAhpE.fasta
## Generate NOT Prx1
cat AhpE.fasta Prx5.fasta Prx6.fasta PrxQ.fasta Tpx.fasta > allButPrx1.fasta
## Generate NOT Prx5
cat AhpE.fasta Prx1.fasta Prx6.fasta PrxQ.fasta Tpx.fasta > allButPrx5.fasta
## Generate NOT Prx6
cat AhpE.fasta Prx1.fasta Prx5.fasta PrxQ.fasta Tpx.fasta > allButPrx6.fasta
## Generate NOT PrxQ
cat AhpE.fasta Prx1.fasta Prx5.fasta Prx6.fasta Tpx.fasta > allButPrxQ.fasta
## Generate NOT Tpx
cat AhpE.fasta Prx1.fasta Prx5.fasta Prx6.fasta PrxQ.fasta > allButTpx.fasta
