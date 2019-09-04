 # Using ROI-ROI parcellation using wb_command

SUBJECTS_DIR=~/Music/Subjects
TIME_Series=  $SUBJECTS_DIR/HCP/M001/MNINonLinear/Results
SUBJECT_ID=$SUBJECTS_DIR/M001 # can be any subject id
 
# Provide HCP or any atlas label file
# Directory where atlas was situated

LABEL_DIR=/sk-home/vasudev/Documents/SUBJECTS_DIR
LABEL_NAME=$LABEL_DIR/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii

wb_command -cifti-parcellate $SUBJECTS_DIR/$TIME_Series/*.dt.series $LABEL_DIR/$LABEL_NAME COLUMN $SUBJECTS_DIR/$TIME_Series/$SUBJECT_ID.ptseries.nii

# Generate parcellated connectivity file pconn for corresponding ptseries file

wb_command -cifti-correlation $SUBJECTS_DIR/$TIME_Series/$SUBJECT_ID.ptseries.nii $SUBJECTS_DIR/$TIME_Series/$SUBJECT_ID.pconn.nii

# Generate .txt file of connectivity

wb_command  -cifti-convert  $SUBJECTS_DIR/$TIME_Series/$SUBJECT_ID.pconn.nii -to-text  $SUBJECTS_DIR/$TIME_Series/$SUBJECT_ID.connectome.txt

# Transform the text file to csv file and execute the table generation script


