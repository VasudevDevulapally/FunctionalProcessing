##-------2: Cifitify_recon_all ---------------------


# Once you finished with recon-all
# Transform freesurfer based images into HCP format using Ciftify_recon_all

# Load libraries
export FREESURFER_HOME=/opt/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
export freesurfer_license=/opt/freesurfer/license.txt


# Once we finish with recon-all we are doing transformation of freesurfer outputs 
# into HCP format , so the outputs of recon-all will be the input for Ciftify_recon_all 

# In the earlier case recon-all outputs were populated in Results folder

# Now this Jahn/Results will become input for ciftify_recon_all

export SUBJECTS_DIR=/sk-home/vasudev/Music/Subjects
SUBJECTS=`cd $SUBJECTS_DIR; ls -1d *`

# Now we create a new folder where results of ciftify_recon_all will be populated
# I call this folder as HCP_DATA, you can use any name, i create this folder in Jahn/HCP_DATA

export HCP_DATA=/sk-home/vasudev/Music/Subjects/HCP
mkdir -p ${HCP_DATA}
HCP=`cd $HCP_DATA; ls -1d *`

# Then run 
# please read how to use gnu-parallel works along with qbatch processing

# It will take 3 hours maximum to run all subjects

#---------------------------------------


parallel ciftify_recon_all --ciftify-work-dir /scratch/HCP_DATA --fs-subjects-dir /scratch/Results {}" ::: $SUBJECTS | qbatch --walltime '03:00:00' --ppj 8 -c 4 -j 4 -N mb_votin -


