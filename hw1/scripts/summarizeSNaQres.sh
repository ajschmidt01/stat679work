#This file summarizes the result of the snaqTimeTests (log and out files) and
#places them in a .csv file. Specifically, it locates and exports the following
#information: 1) the file/analysis name (analysis), 2) the number of
#hybridizations (h), and 3) the CPUtime in seconds (CPUtime).

#Set working directory as root directory (move up one directory first)
cd ..
wd=$(pwd)

#Create output csv file with three columns (analysis, h and CPUtime)
  #First check if the file already exists
    echo Check if csv file already exists
    ls ${wd}/results/snaqResSummary.csv
  #Create/replace csv file
    echo analysis,h,CPUtime >  ${wd}/results/snaqResSummary.csv

#Loop over all files in the log/out directories
  #To do so, move into the log directory to first grab the file/analysis names
  #and then loop over them, grabbing/saving analysis name, number of
  #hybridizations, and CPUtime, and then appending to the csv file
  cd ${wd}/data/hw1-snaqTimeTests/log/

  for filename in *
    do
      #Add space before each loop to make output easier to read
        echo ""

      #pull analysis name and save (first check)
        echo $filename | grep -oE "^\w+"
        analysis=$(echo $filename | grep -oE "^\w+")

      #pull number of hybridizations and save (first check)
        grep "hmax" $filename | head -n 1 | grep -oE "\d+"
        h=$(grep "hmax" $filename | head -n 1 | grep -oE "\d+")

      #pull CPUtime and save (first check)
        grep "Elapsed" ${wd}/data/hw1-snaqTimeTests/out/${analysis}.out | grep -oE "\d+\.\d+"
        CPUtime=$(grep "Elapsed" ${wd}/data/hw1-snaqTimeTests/out/${analysis}.out | grep -oE "\d+\.\d+")

      #append analysis name, number of hybridizations and CPUtime to csv file
        echo $analysis,$h,$CPUtime >>  ${wd}/results/snaqResSummary.csv
    done

#Return to the scripts directory
cd ${wd}/scripts
