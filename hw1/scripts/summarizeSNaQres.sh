#Created by: Alex Schmidt
#Updated: 10.11.2016

#This file summarizes the result of the snaqTimeTests (log and out files) and
#places them in a .csv file. Specifically, it locates and exports the following
#information: 1) the file/analysis name (analysis), 2) the number of
#hybridizations (h), 3) the CPUtime in seconds (CPUtime), 4) number of runs (Nruns),
#5) Nfail (max number of failed proposals, 6) fabs (tolerated difference in the
# absolute value of the score function, to stop the search),
#7)frel (ftolRel), 8)xabs (xtolAbs), 9)xrel (xtolRel), 10) seed (main seed),
#11) under3460 (number of runs that returned a network with a score
# (-loglik value) better than (below) 3460), 12) under3450 (number of runs with
#a network score under 3450), 13)under3440 (number of runs with a network score under 3440)

#Preliminary set-up
#!/bin/bash
set -e # script terminates if any command exits with non-zero status
set -u # terminates if any variable is unset
set -o pipefail # terminates if command within a pipes exits unsuccessfully

#Set working directory as root directory (move up one directory first)
cd ..
wd=$(pwd)

#Check if currently in "hw1" root directory, and exit if not
curDir=$(basename $wd)
if [ $curDir != hw1 ]
  then
    echo "error: must run script from 'script' directory"
    exit 1 # exit script with error code (1). 0 = successful exit
  fi

#Create output csv file with 13 variable columns
  #First check if the file already exists
  csvFile=$(basename $(ls ${wd}/results/snaqResSummary.csv))
  if [ $csvFile=snaqResSummary.csv ]
    then
      echo ""
      echo snaqResSummary.csv already existed. It was replaced.
      echo ""
    fi

  #Create/replace csv file
    echo analysis,h,CPUtime,Nruns,Nfail,fabs,frel,xabs,xrel,seed,under3460,under3450,under3440 >  ${wd}/results/snaqResSummary.csv

#Loop over all files in the log/out directories
  #To do so, move into the log directory to first grab the file/analysis names
  #and then loop over them, grabbing/saving 13 variable data then appending to
  #the csv file
  cd ${wd}/data/hw1-snaqTimeTests/log/

  for filename in *
    do
      #pull analysis name and save (first check)
        #Pulls letters prior to "." in file name
        analysis=$(echo $filename | grep -oE "^\w+")

      #pull number of hybridizations and save (first check)
        #Restrict to "hmax" lines, takes the first, and reports the number
        h=$(grep "hmax" $filename | head -n 1 | grep -oE "\d+")

      #pull CPUtime and save (first check)
        #Finds line with "Elapsed" and reports "number.number"
        CPUtime=$(grep "Elapsed" ${wd}/data/hw1-snaqTimeTests/out/${analysis}.out | grep -oE "\d+\.\d+")

      #pull Nruns name and save (first check)
        #Pulls number after "BEGIN:" at beginning of line
        Nruns=$(gsed -nE 's/^BEGIN:\s([0-9]+).*/\1/p ' $filename)

      #pull Nfail name and save (first check)
        #Pulls numbers after "...proposals = "
        Nfail=$(gsed -nE 's/.*proposals[^\s]=\s([0-9]+).*/\1/p' $filename)

      #pull fabs name and save (first check)
        #Pulls sequence of numbers, letters, . (e.g., 1.0e-5) after "ftolAbs="
        fabs=$(gsed -nE 's/.*ftolAbs=([0-9 a-z \. \-]+),.*/\1/p' $filename)

      #pull frel name and save (first check)
        #Pulls sequence of numbers, letters, . (e.g., 1.0e-5) after "ftolRel="
        frel=$(gsed -nE 's/.*ftolRel=([0-9 a-z \. \-]+),.*/\1/p' $filename)

      #pull xabs name and save (first check)
        #Pulls sequence of numbers, letters, . (e.g., 1.0e-5) after "xtolAbs="
        xabs=$(gsed -nE 's/.*xtolAbs=([0-9 a-z \. \-]+),.*/\1/p' $filename)

      #pull xrel name and save (first check)
        #Pulls sequence of numbers, letters, . (e.g., 1.0e-5) after "xtolRel="
        xrel=$(gsed -nE 's/.*xtolRel=([0-9 a-z \. \-]+)..*/\1/p' $filename)

      #pull seed name and save (first check)
        #Pulls numbers after "main seed"
        seed=$(gsed -nE 's/main[^\s]seed[^\s]([0-9]+).*/\1/p' $filename)

      #Create list of loglik values under 3500
        #Pulls numbers after "loglik=", removes decimals, then deletes lines with values greater than or equal to 3500
        under3500=$(gsed -nE 's/.*loglik=([0-9 \.]+).*/\1/p' $filename | gsed -E 's/\.[0-9]*//' | gsed -E '/[0-9]{5,}/d' | gsed -E '/[4-9][0-9]{3,}/d' | gsed -E '/3[5-9][0-9]{2,}/d' | column -t)

      #pull under3460 name and save (first check)
        #Inputs numbers under 3500, places on separate lines, removes blank lines, and deletes numbers greater than 3460
        under3460=$(echo $under3500 | gsed -E 's/\s/\n/g' | gsed -E '/^$/d' | gsed -E '/34[6-9][0-9]/d' | wc -l | column -t)

      #pull under3450 name and save (first check)
        #Inputs numbers under 3500, places on separate lines, removes blank lines, and deletes numbers greater than 3450
        under3450=$(echo $under3500 | gsed -E 's/\s/\n/g' | gsed -E '/^$/d' | gsed -E '/34[5-9][0-9]/d' | wc -l | column -t)

      #pull under3440 name and save (first check)
        #Inputs numbers under 3500, places on separate lines, removes blank lines, and deletes numbers greater than 3440
        under3440=$(echo $under3500 | gsed -E 's/\s/\n/g' | gsed -E '/^$/d' | gsed -E '/34[4-9][0-9]/d' | wc -l | column -t)

      #append data to new line of csv file
        echo $analysis,$h,$CPUtime,$Nruns,$Nfail,$fabs,$frel,$xabs,$xrel,$seed,$under3460,$under3450,$under3440 >>  ${wd}/results/snaqResSummary.csv
    done

#Display output in column format
column -t -s , ${wd}/results/snaqResSummary.csv

#Return to the scripts directory
cd ${wd}/scripts
