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
(This csv file was last updated on October 11, 2016.)

  1. "analysis"-the analysis name
  2. "h"-the number of hybridizations allowed during analysis
  3. "CPUtime"-total CPU/elapsed time for analysis in *seconds*
  4. "number of runs" (Nruns),
  5. "Nfail" (max number of failed proposals
  6. "fabs" (tolerated difference in the absolute value of the score function, to stop the search),
  7. "frel" (ftolRel)
  8. "xabs" (xtolAbs)
  9. "xrel" (xtolRel)
  10. "seed" (main seed)
  11. "under3460" (number of runs that returned a network with a score (-loglik value) better than (below) 3460)
  12. "under3450" (number of runs with a network score under 3450)
  13. "under3440" (number of runs with a network score under 3440)

Note that the first row of the csv file is a header with these column names.

This script was most recently run on October 11, 2016.
