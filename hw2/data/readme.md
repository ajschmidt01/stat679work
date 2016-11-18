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
