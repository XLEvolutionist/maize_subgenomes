#!/bin/bash -l
#SBATCH -D /group/jrigrp4/cnvwin/AHTP/subgenomes/relationshipMatrix
#SBATCH -o /group/jrigrp4/cnvwin/AHTP/logs/matrix_out_log-%j.txt
#SBATCH -e /group/jrigrp4/cnvwin/AHTP/logs/matrix_err_log-%j.txt
#SBATCH -J matrix
#SBATCH --mem-per-cpu=65000
#SBATCH --cpus-per-task=1
#SBATCH --array=1-2
##Simon Renny-Byfield, UC Davis, November 2015

# load in the files from ls
cd ../bedFiles
file=$(head -n $SLURM_ARRAY_TASK_ID ../bedFiles/bed.file.list | tail -n1 )
cd ../relationshipMatrix

echo "Starting Job: $file"
date

module load java

cmd="run_pipeline.pl -Xmx64g -importGuess ../../genotypes/namrils_projected_hmp31_MAF02mnCnt2500.hmp.txt.gz -FilterSiteBuilderPlugin -bedFile ../bedFiles/$file -endPlugin -KinshipPlugin -method Scaled_IBS -endPlugin -RemoveNaNFromDistanceMatrixPlugin -endPlugin -export kinship_$file -exportType SqrMatrixBin"

echo $cmd
eval $cmd

#sleep 60

echo "Ending Job: "
date