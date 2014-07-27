gettingandcleaningdata
======================

for project submission for Coursera's "Getting and Cleaning Data" course

This submission on GITHUB contains the following files:

run_analysis.R = script for loading project data and constructing and saving two tidy data sets as per project instructions.
code_book.txt = code book for the tidy data sets
README.md = this read me file


Description of run_analysis.R script

The script does the following:

1. Load data files
My script assumes that the project data archive file "getdata_projectfiles_UCI HAR Dataset.zip" 
was unzipped in the R working directory.  

2. Combines test and training data sets.
The test and training data for the sensor data, subject IDs, and activity IDs are each 
combined to create three final combined data frames. The three data frames are then combined
to create a single data frame with subject, activity, and sensor data.  Each row of the data
frame comprises a single set of sensor observations for a given subjectID and acitvityID

3. Create initial names
The data frame is modified to create a more useful set of descriptive names for subject, activity and feature
data. The feature names are taken from the features.txt data

4. Restrict features to just "mean" and "std" features.
Manual inspection of the feature names determined that feature names with had matches within them to 
"mean" and "std" were most likely to be the features that should be maintained (Note that some features
which contained string like 'Mean' were not true mean measurements). The data frame was abridged to only 
retain the subjectID and activityID columns, plus features that were of mean or std measurements.

5. Cleanup feature names
The feature names were then cleaned up to remove non-tidyness in the names; e.g.
"()", and "-" were removed.  The resulting feature names have only alphabetic characters.

6. Decode trainingLabelID
merge function was used to add in a column that showed the activity label corresponding to the
activityID for each record in the data frame.  Finally, the activityID column was removed as redundant.


The resulting data frame, mean_std_data, represented a tidy data set which was then written to tidydata.csv and
submitted to the project page.

7. Create aggregated data set (average of all mesurements over subject and activity)

data frame agg_mean_std_data was constructed using aggregate() function on mean_std_data to calculate the
average of feature values over each subject and activity.

The feature names in the data frame were modified by appending "avgBySubjectActivity" to the beginning of 
name to reflect their new meaning.

This data was written to agg_tidydata.csv and submitted to the project page along with the tidydata.csv.

