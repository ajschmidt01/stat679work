#This script normalizes the timetest file names in the snaq data
#Specifically, it takes the timetest## data names and ensures that a two-digit
#structure is used. For example timetest8.log is changed to timetest08.log
#This process is repeated for both the .log and .out files.

#Set working directory as root directory (move up one directory first)
cd ..
wd=$(pwd)

#loop over the .log and .out directories
for dir in log out
  do
    #Move into the log or out directory
    cd ${wd}/data/hw1-snaqTimeTests/$dir

    #Loop over the single digits
    for i in {1..9}
    do

      #Check to ensure correct file names are being selected and changed
      echo timetest${i}_snaq.${dir}
      echo timetest0${i}_snaq.${dir}

      #Replace old single digit name with two digit name
      mv timetest${i}_snaq.${dir} timetest0${i}_snaq.${dir}
    done
  done

#Return to the scripts directory
cd ${wd}/scripts
