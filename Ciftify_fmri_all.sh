# Load modules

# Load libraries


export FREESURFER_HOME=/opt/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export freesurfer_license=/opt/freesurfer/license.txt

# Now create a SUBJECTS_DIR where you have FSL filtered_func_data_clean.nii.gz files
# you can name that SUBJECTS_DIR by any name
# I name it as Timeseries
# mkdir Timeseries
# Each filtered_func_data_clean.nii.gz file should be stored in directory with subject name like R011 or R013, any subject name of your choice
# If you have a name like  fsl003.ica or R003.ica .. rename the file without .ica

# you do it in bash : rename rename 's/.ica//gi' *

# make sure the SUBJECTS name matches the name of HCP_DATA directory subjects

export SUBJECTS_DIR=/sk-home/vasudev/Music/Subjects/HCP/Timeseries
mkdir -p ${SUBJECTS_DATA}
SUBJECTS=`cd $SUBJECTS_DIR; ls -1d *`

# Now we create a new folder where results of ciftify_recon_all will be populated
# I call this folder as HCP_DATA, you can use any name, i create this folder in Jahn/HCP_DATA

export HCP_DATA=/sk-home/vasudev/Music/Subjects/HCP
mkdir -p ${HCP_DATA}
HCP=`cd $HCP_DATA; ls -1d *`

# Here i check whether SUBJECTS_DIR names and HCP_DATA direcory names match
# if [[ $i == $j ]], where $i is names of $SUBJECTS and $j names of HCP_DATA
# This is important so that filtered_func_data_clean.nii.gz is registered to same structural data which is in HCP format

for i in $SUBJECTS;
 do 
  for j in $HCP;
    do
    if [[ $i == $j ]];
    then 
    echo ciftify_subject_fmri --ciftify-work-dir /scratch/HCP_DATA --surf-reg FS /SUBJECTS_DIR/$i/filtered_func_data_clean.nii.gz $j Timeseries;
    fi; 
    done; 
    done | qbatch --walltime '02:00:00' --ppj 8 -c 4 -j 4 -N mb_votin -

# In the above nested for loop " /SUBJECTS_DIR/$i/filtered_func_data_clean.nii.gz $j Timeseries "

# Timeseries is a name that i have given , you can provide any name as you choose, results will be populated in them


# If you have confusion mail me


# IMPORTANT * - if you running ciftify_subject_fmri for multiple scans,make sure to keep each subject.ica scan in different folder or change the for loop accordingly so that i accurately points to the time scan for which you want time series

# any doubt here please ask me 


