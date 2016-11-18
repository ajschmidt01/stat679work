 Overview
 ========
 Contains data, work, and results for homework 2 for stat679. These are located in the following subdirectories:
   1. data
   2. scripts
   3. results
   4. figures
   5. manuscript
   6. binaries

 Goal of study from homework description:
 On the same roof, two different solar collector systems are installed, one to heat water and the other to provide electricity. Data are collected every month from each system:

 * hot water: hourly data on the hot water temperature
 * electricity: daily data on the energy produced by a photovoltaic system.

 Merging data files from these 2 data loggers is necessary for downstream analyses, such as correlation between the 2 systems. Doing any downstream analysis is not the goal of the exercise.

 The goal of the exercise is to produce a script that could be used monthly to merge the 2 data files of the month, where the energy value from each day is matched to the temperature value at the nearest time, with no need for any manual copy-paste operation. The script is meant to be used repeatedly, so it should accept 2 file names as arguments: the names of the temperature file and of the energy file.

 Data
 ----
 In order to preserve the original files, I copied the original data into this folder.
 The files were most recently copied over on November 7, 2016.
 The data were copied using the following command (while pwd is the data folder):
  `cp -R  ~/Documents/stat679/hw1/coursedata/hw2-datamerge/ ./`

 The original files are found in ~/Documents/stat679/hw1/coursedata/hw2-datamerge
 They were copied there from Github using the following command on November 7, 2016:
 `git clone git@github.com:UWMadison-computingtools/coursedata.git`

 **Data Assumptions to Check**
 For the module to run correctly, the data files must be in the following formats:

  1. Energy file has header starting with "Date/Time", and footer starting with "Total"

  2. The water temperature file has a two line header, where the first line does not start with a digit, and the second line starts with a  quotation mark (containing comma separated variable names in quotation marks).

  3. Water temperature data in the format: index number,date (%m/%d/%y %I:%M:%S %p),water temperature

  4. Energy data in the format: date (%Y-%m-%d %H:%M:%S %z),energy value (Wh)

  5. Energy recordings taken at midnight. (Checked by module.)

  6. Data files are sorted by date/time (ascending). (Checked by module.)

  7. Every energy reading date is matched to a water reading date. (Checked by module.)

 Scripts
 -------
 **Description**
 The module **temp_energy_merge** merges energy readings from solar panels to water temperature readings taken throughout the day. To do so, the energy reading taken at midnight is matched to the water temperature reading taken at the nearest time on the same day.

 **Instructions**
 Start python and import **temp_energy_merge**. (`import temp_energy_merge`) Then move into the data directory. (To do this, import the os module: `import os`, and then use the following command: `os.chdir("../data")`). The module can be used to merge the data: `temp_energy_merge.merge()`. Consult the help file for more information on how to run the module: `help(temp_energy_merge)`. Also note that the module can be run in succession to merge additional dates onto the csv file. See the help section of the module for more information on how to append data. Finally, also note that instead of exporting the merge to the csv file, it can be printed to the screen using the stdout option. Again, see the help file for more information.

 This module/script was most recently run on November 17, 2016.

 Results
 -------
 **temp_energy_merge.csv** contains the output from the temp_energy_merge module. Specifically, it contains:

   1. index number
   2. date
   3. Water temperature (F)
   4. Energy reading (KWh)

 Note that the first row of the csv file is a header with a title, and the second row is a header with column names.

 This csv file was last updated on November 17, 2016.

 Figures
 -------
 Contains figure outputs from the analysis. None, currently.

 Manuscript
 ----------
 Contains manuscript of the analysis. None, currently.

 Binaries
 --------
 Contains binaries necessary to run the analysis. None, currently.
