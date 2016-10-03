Scripts
-------
**Instructions**
Run each script (using the bash command) while the pwd is the scripts directory. The scripts should be run in the following order:

**1.**
**NormalizeFileNames.sh** normalizes the file names from the hw1-snaqTimeTests data so that the numbers are in a standardized format (i.e., two digits).
For example, Filename1 will become Filename01.  The program accomplishes this through looping.

This script was most recently run on September 29, 2016.

**2.**
**summarizeSNaQres.sh** pulls the following info from the log and out files and places it in a csv file (snaqResSummary):
(This csv file was last updated on September 29, 2016.)
1."analysis"-the analysis name (column 1)
2. "h"-the number of hybridizations allowed during analysis (column 2)
3. "CPUtime"-total CPU/elapsed time for analysis in *seconds* (column 3)
Note that the first row of the csv file is a header with these column names.

This script was most recently run on September 29, 2016.
