#!/bin/bash
#SBATCH -D /group/jrigrp4/cnvwin/AHTP/subgenomes/relationshipMatrix
#SBATCH -o /group/jrigrp4/cnvwin/AHTP/logs/LDAK_out_log-%j.txt
#SBATCH -e /group/jrigrp4/cnvwin/AHTP/logs/LDAK_err_log-%j.txt
#SBATCH -J LDAK
#SBATCH --mem-per-cpu=10000
#SBATCH --cpus-per-task=1
#SBATCH --array=1-45

##Simon Renny-Byfield, UC Davis, December  2015

pheno=$(head -n $SLURM_ARRAY_TASK_ID ../../phenotypes/file_list | tail -n1)

echo "Starting Job: "
date

cmd="ldak.4.9 --reml ../results/results_m1_vs_m2_$pheno --mgrm m1_vs_m2_list --pheno ../../phenotypes/$pheno --kinship-details NO"
echo $cmd
eval $cmd

echo "Ending Job: "
date