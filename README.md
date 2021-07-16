# Learning During Quiet Wakefulness Promotes Generalization

In the main folder you can find different files and subfolders:
- Results2B are the raw results for the active condition
- ResultsQ are the raw results for the offline condition
- sbj1 to sbj100 are the .mat file for all the participants. Inside the mat file you'll find 4 structures with the data from the training, pretest, posttest and offline/nback condition.
- ExcelToMatlabNBack and ExcelToMatlabQuiescence are scripts that transform the raw data into the subjects matrices.
- QuiescencePavloviaParticipants is an excel file with all the information about the participants
- In the Analysis subfolder you can find:
-- knn-smoothing folder with the scripts and function to run the analysis
-- DataMarix creates a big matrix with the relevant data for all the participants (DataStructure). See line 225 for a legend of the matrix. It also generates plots.
-- PaperPlot generates the plots we used in the paper, it requires the superbar toolbox
-- TwoWayQuieMem is the script of the ANOVA and the ttests.
