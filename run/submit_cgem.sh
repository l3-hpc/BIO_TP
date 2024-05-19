#!/bin/bash
#SBATCH --job-name="lecgem"
#SBATCH --output="qlecgem-out.%j"
#SBATCH --error="qlecgem-err.%j"
##SBATCH --nodes=1
##SBATCH --ntasks-per-node=128
##SBATCH --partition=compute
##SBATCH --nodes=2
##SBATCH --ntasks-per-node=128
##SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
##SBATCH --nodes=1
##SBATCH --ntasks-per-node=16
##SBATCH --partition=shared
#SBATCH --account=ncs126
##SBATCH -t 24:00:00
#SBATCH -t 00:20:00

module load intel/19.1.3.304/6pv46so
module load intel-mpi/2019.10.317/ezrfjne
module load netcdf-c/4.8.1/ej3w5cy
module load netcdf-fortran/4.5.3/vqnicf7
#1node
#/usr/bin/time -v mpirun -n 128 ./fvcom_cgem --casename=lecgem > lecgem.out
#2nodes
#/usr/bin/time -v mpirun -n 256 ./fvcom_cgem --casename=lecgem > lecgem.out
mpirun -n 1 ./fvcom_cgem --dbg=7 --casename=lecgem > lecgem.out
#mpirun -n 1 ./fvcom_cgem --casename=lecgem > lecgem.out
echo "seff"
seff $SLURM_JOB_ID 
echo "sacct"
sacct --jobs=$SLURM_JOB_ID --format=nnodes,ncpu,ntasks,maxrss,cputime,avecpu,maxdiskread,maxdiskwrite,maxpages
