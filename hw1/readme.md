Overview
========
Contains data, work, and results for homework 1 for stat679. These are located in the following subdirectories:
  1. data
  2. scripts
  3. results
  4. figures
  5. manuscript
  6. binaries

Goal of study from homework description:
Several SNaQ analyses were performed, always on the same input data, with varying values of tuning parameters. These parameters control how the search is done and when it is stopped. The goal of this study was to find a combination of tuning parameters that makes the analyses faster but as accurate, compared to the default parameters.

Data
----
In order to preserve the original files, I copied the original data into this folder.
The files were most recently copied over on September 29, 2016.
The data were copied using the following command (while pwd is the data folder):
 `cp -r ~/Documents/stat679/hw1/coursedata/hw1-snaqTimeTests .``

The original files are found in ~/Documents/stat679/hw1/coursedata/hw1-snaqTimeTests
They were copied there from Github using the following command in the first two weeks of September, 2016:
`git clone git@github.com:UWMadison-computingtools/coursedata.git`

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

Results
-------
**snaqResSummary.csv** contains the output from summarizeSNaQres.sh. Specifically, it contains:
  1."analysis"-the analysis name (column 1)
  2. "h"-the number of hybridizations allowed during analysis (column 2)
  3. "CPUtime"-total CPU/elapsed time for analysis in *seconds* (column 3)

Note that the first row of the csv file is a header with these column names.

This csv file was last updated on September 29, 2016.

Figures
-------
Contains figure outputs from the analysis. None, currently.

Manuscript
----------
Contains manuscript of the analysis. None, currently.

Binaries
--------
Contains binaries necessary to run the analysis. None, currently.
