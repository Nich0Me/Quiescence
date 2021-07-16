# Learning During Quiet Wakefulness Promotes Generalization
Behavioural data and analysis from Learning During Quiet Wakefulness Promotes Generalization study

In the main folder you can find different files and subfolders:
- Raw contains the raw data for the 2Back and Offline condition
1. Results2B are the raw results for the active condition
2. ResultsQ are the raw results for the offline condition

- Subjects contain 100 subfolders, one per participant.
1. Inside the mat file, you'll find 4 structures with the data from the training, pretest, posttest and offline/nback condition.

- ExcelToMatlabNBack and ExcelToMatlabQuiescence are scripts that transform the raw data into the subjects matrices.

- QuiescencePavloviaParticipants is an excel file with all the information about the participants

- In the Analysis subfolder you can find:
1. knn-smoothing folder with the scripts and function to run the analysis
2. DataMatrix creates a big matrix with the relevant data for all the participants (DataStructure). See line 225 for a legend of the matrix. It also generates plots.
3. PaperPlot generates the plots we used in the paper, it requires the superbar toolbox
4. TwoWayQuieMem is the script of the ANOVA and the ttests.


Please email w.penny@uea.ac.uk or n.menghi@uea.ac.uk with any queries
