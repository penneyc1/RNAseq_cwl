#!/bin/bash
#SBATCH --mem=50G
#SBATCH --cpus-per-task=8


 python  /mnt/isilon/choi_lab/users/penneyc/miniconda3/envs/eclip/rMATS/rmats.py --s1 /mnt/isilon/choi_lab/users/penneyc/experiments/CP218_RNASeq_Pipeline/rmatstest/s1.txt --s2 /mnt/isilon/choi_lab/users/penneyc/experiments/CP218_RNASeq_Pipeline/rmatstest/s2.txt --gtf /mnt/isilon/choi_lab/users/penneyc/reference/GRCh38.gencode.v28/gencode.v28.primary_assembly.annotation.gtf --readLength 50 --od /mnt/isilon/choi_lab/users/penneyc/experiments/CP219_RNASeq_Pipeline/rmatsout --tmp /mnt/isilon/choi_lab/users/penneyc/experiments/CP219_RNASeq_Pipeline/rmatstmp --bi /mnt/isilon/choi_lab/users/penneyc/reference/GRCh38.gencode.v28/star_index
