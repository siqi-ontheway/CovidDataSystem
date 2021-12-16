#!/bin/bash
#
#SBATCH --mail-user=siqili@cs.uchicago.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=proj3_benchmark 
#SBATCH --output=./slurm/out/%j.%N.stdout
#SBATCH --error=./slurm/out/%j.%N.stderr
#SBATCH --chdir=/home/siqili/Desktop/proj3-siqi-ontheway/proj3
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=300
#SBATCH --time=200:00 

module load golang/1.16.2 

go run proj3/covid 1 60660 7 2021 small --exclusive
go run proj3/covid 1 60660 7 2021 small --exclusive
go run proj3/covid 1 60660 7 2021 small --exclusive
go run proj3/covid 1 60660 7 2021 small --exclusive
go run proj3/covid 1 60660 7 2021 small --exclusive

go run proj3/covid 1 60660 7 2021 medium --exclusive
go run proj3/covid 1 60660 7 2021 medium --exclusive
go run proj3/covid 1 60660 7 2021 medium --exclusive
go run proj3/covid 1 60660 7 2021 medium --exclusive
go run proj3/covid 1 60660 7 2021 medium --exclusive


go run proj3/covid 1 60660 7 2021 big  --exclusive
go run proj3/covid 1 60660 7 2021 big  --exclusive
go run proj3/covid 1 60660 7 2021 big  --exclusive
go run proj3/covid 1 60660 7 2021 big  --exclusive
go run proj3/covid 1 60660 7 2021 big  --exclusive

go run proj3/covid 2 60660 7 2021 small  --exclusive
go run proj3/covid 2 60660 7 2021 small  --exclusive
go run proj3/covid 2 60660 7 2021 small  --exclusive
go run proj3/covid 2 60660 7 2021 small  --exclusive
go run proj3/covid 2 60660 7 2021 small  --exclusive

go run proj3/covid 4 60660 7 2021 small  --exclusive
go run proj3/covid 4 60660 7 2021 small  --exclusive
go run proj3/covid 4 60660 7 2021 small  --exclusive
go run proj3/covid 4 60660 7 2021 small  --exclusive
go run proj3/covid 4 60660 7 2021 small  --exclusive

go run proj3/covid 6 60660 7 2021 small  --exclusive
go run proj3/covid 6 60660 7 2021 small  --exclusive
go run proj3/covid 6 60660 7 2021 small  --exclusive
go run proj3/covid 6 60660 7 2021 small  --exclusive
go run proj3/covid 6 60660 7 2021 small  --exclusive

go run proj3/covid 8 60660 7 2021 small  --exclusive
go run proj3/covid 8 60660 7 2021 small  --exclusive
go run proj3/covid 8 60660 7 2021 small  --exclusive
go run proj3/covid 8 60660 7 2021 small  --exclusive
go run proj3/covid 8 60660 7 2021 small  --exclusive

go run proj3/covid 12 60660 7 2021 small  --exclusive
go run proj3/covid 12 60660 7 2021 small  --exclusive
go run proj3/covid 12 60660 7 2021 small  --exclusive
go run proj3/covid 12 60660 7 2021 small  --exclusive
go run proj3/covid 12 60660 7 2021 small  --exclusive



go run proj3/covid 2 60660 7 2021 medium  --exclusive
go run proj3/covid 2 60660 7 2021 medium  --exclusive
go run proj3/covid 2 60660 7 2021 medium  --exclusive
go run proj3/covid 2 60660 7 2021 medium  --exclusive
go run proj3/covid 2 60660 7 2021 medium  --exclusive

go run proj3/covid 4 60660 7 2021 medium  --exclusive
go run proj3/covid 4 60660 7 2021 medium  --exclusive
go run proj3/covid 4 60660 7 2021 medium  --exclusive
go run proj3/covid 4 60660 7 2021 medium  --exclusive
go run proj3/covid 4 60660 7 2021 medium  --exclusive

go run proj3/covid 6 60660 7 2021 medium  --exclusive
go run proj3/covid 6 60660 7 2021 medium  --exclusive
go run proj3/covid 6 60660 7 2021 medium  --exclusive
go run proj3/covid 6 60660 7 2021 medium  --exclusive
go run proj3/covid 6 60660 7 2021 medium  --exclusive

go run proj3/covid 8 60660 7 2021 medium  --exclusive
go run proj3/covid 8 60660 7 2021 medium  --exclusive
go run proj3/covid 8 60660 7 2021 medium  --exclusive
go run proj3/covid 8 60660 7 2021 medium  --exclusive
go run proj3/covid 8 60660 7 2021 medium  --exclusive

go run proj3/covid 12 60660 7 2021 medium  --exclusive
go run proj3/covid 12 60660 7 2021 medium  --exclusive
go run proj3/covid 12 60660 7 2021 medium  --exclusive
go run proj3/covid 12 60660 7 2021 medium  --exclusive
go run proj3/covid 12 60660 7 2021 medium  --exclusive

go run proj3/covid 2 60660 7 2021 big  --exclusive
go run proj3/covid 2 60660 7 2021 big  --exclusive
go run proj3/covid 2 60660 7 2021 big  --exclusive
go run proj3/covid 2 60660 7 2021 big  --exclusive
go run proj3/covid 2 60660 7 2021 big  --exclusive

go run proj3/covid 4 60660 7 2021 big  --exclusive
go run proj3/covid 4 60660 7 2021 big  --exclusive
go run proj3/covid 4 60660 7 2021 big  --exclusive
go run proj3/covid 4 60660 7 2021 big  --exclusive
go run proj3/covid 4 60660 7 2021 big  --exclusive

go run proj3/covid 6 60660 7 2021 big  --exclusive
go run proj3/covid 6 60660 7 2021 big  --exclusive
go run proj3/covid 6 60660 7 2021 big  --exclusive
go run proj3/covid 6 60660 7 2021 big  --exclusive
go run proj3/covid 6 60660 7 2021 big  --exclusive

go run proj3/covid 8 60660 7 2021 big  --exclusive
go run proj3/covid 8 60660 7 2021 big  --exclusive
go run proj3/covid 8 60660 7 2021 big  --exclusive
go run proj3/covid 8 60660 7 2021 big  --exclusive
go run proj3/covid 8 60660 7 2021 big  --exclusive

go run proj3/covid 12 60660 7 2021 big  --exclusive
go run proj3/covid 12 60660 7 2021 big  --exclusive
go run proj3/covid 12 60660 7 2021 big  --exclusive
go run proj3/covid 12 60660 7 2021 big  --exclusive
go run proj3/covid 12 60660 7 2021 big  --exclusive


python3 plot.py
