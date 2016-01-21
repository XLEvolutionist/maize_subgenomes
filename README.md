# maize_subgenomes

This respository stores scripts used in Renny-Byfield, Rosgers-Melnick and Ross-Ibarra 2016. 

The scripts deposited here are for illustrative purposes only, and are not intended to provide a working data analysis pipeline for others wishing to perform similar analysis. The scripts are provided as a transparent description of the code we used during the analyses, and are unlikely to work "out of the box" on any other machine. As such copying and use of these scripts comes with absolutely no warranty of any kind. However, we hope that others can use this as a base from which to develop their own code and analyses.  

The analysis uses genotype and phenotype data from the HapMap3 and [Panzea](http://www.panzea.org/) consortia and previously published [sub-genome designations](http://www.pnas.org/content/108/10/4069). Analysis relies heavily on RStudio, [TASSEL5](http://www.maizegenetics.net/#!tassel/c17q9) and a number of R packages, particularly GenomicRanges and ggplot2.


The deposited scripts are as follows:

**variance_subgenomes.Rmd** - written in Rmarkdown using RStudio. Details the overall workflow and contains the code use to make plots. Perhaps the best place to start in order to appreciate how the analysis was performed.

**MAFfromGenotype.pl** - perl script to assess MAF in the NAM lines. Takes input from genotype data generated by the Panzea consortium.

**relationhhipMatrix.sh** - A bash script. An example of how to generate relationship matrices from bedfiles. Will need to be modified to suit your needs (e.g. correct oaths and links to appropriate bedfiles).

**batch_runLDAK.sh** - a batch submission script to estimate hertitability over the 45 traits.

**collateVCAPoutput_m1_m2.pl** - perl script written to access heritability data for each of the phenotypes and collate into a single dataset. 

**collateVCAPoutput_up_down.pl** - a modified version of collateVCAPoutput_m1_m2.pl, but for paralogous gene sets seperated by expression level.
