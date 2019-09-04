#!/bin/bash

## set the site variable here
projectname='myproject'
SCRATCH=/Bioinformatics/Bmax_neuro/data/Neuroimaging
NIIDIR=${SCRATCH}/Connectivity/inputs/

#load the ciftify enviroment
MYBASEDIR=${HOME}/code ## change this to the directory you want to clone/download the ciftify code into dementix

export PATH=$PATH:${MYBASEDIR}/ciftify/ciftify/bin
export PYTHONPATH=$PYTHONPATH:${MYBASEDIR}/ciftify
export CIFTIFY_TEMPLATES=${MYBASEDIR}/ciftify/data

#freesurfer installation
export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

#module load python ## you need any version of python loaded for qbatch to work
module load qbatch ## pip install qbatch in dementix
export SUBJECTS_DIR=${SCRATCH}/Functional_Connectivity/FSout/

## make the $SUBJECTS_DIR if it does not already exist
mkdir -p $SUBJECTS_DIR

## get the session 1 subjects list from the NIIDIR
Session1Files=`cd ${NIIDIR}; ls -1d 002????/session_1/anat_1/anat.nii.gz`
Session1Subjects=""
for file in ${Session1Files}; 
do 
  sub=$(dirname $(dirname $(dirname ${file}))) 
  Session1Subjects="${Session1Subjects} ${sub}" 
done

## submit the files to the queue
cd $SUBJECTS_DIR
parallel "echo recon-all -subject {} -i ${NIIDIR}/{}/session_1/anat_1/anat.nii.gz -sd ${SUBJECTS_DIR} -all" ::: ${Session1Subjects} | \
  qbatch --walltime 24:00:00 -c 4 -j 4 --ppj 8 -N fss1${projectname} -
