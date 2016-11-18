#!/usr/bin/env python
"""temp_energy_merge: module to merge water temperature
and solar energy data together into one file.
"""

def merge(temp, energy, stdout=True, append=False):
    """Merge a water temperature (temp) and solar energy data (energy) into one file by
    matching energy data reading to the preceeding water temperature reading.

    optional arguments:
    stdout (default True) outputs the merged file to
    STDOUT unless otherwise specified.

    append (default True) appends the merged data to the previous merged
    file unless otherwise specified.

    Assumptions:
    Energy file has header starting with "Date/Time", and footer starting
    with "Total"

    Water_temp file has a two line header, where the first line does not start
    with a digit, and the second line starts with a quotation mark

    Temperature dates in format:#,%m/%d/%y %I:%M:%S %p,water_temp

    Energy dates in format: %Y-%m-%d %H:%M:%S %z,energy_value

    Energy recordings taken at midnight.

    Files are sorted by date/time (ascending).

    Every energy reading date is matched to a water reading date.

    """
    #Preliminaries: Import modules
    from datetime import datetime #import datetime module to compare dates
    import sys #allows to output to standard output
    import os #allows to check file location

    outfile = "../results/temp_energy_merge.csv" #location for exporting csv file

    #Assertions and preliminary option settings
    ## Make sure module being run from the data directory
    dir = os.getcwd() #grab path to current directory
    dir=dir.split('/') #split by directory
    dir=dir[len(dir)-1] #grab current directory
    assert dir == "data", "Please run module from the data directory."

    ## Does merge file already exist if append chosen?
    if append==True and not os.path.isfile(outfile):
        raise Exception("Attempting to append to a file that does not exist. Set append=False")

    ## Delete file first if want to write new file, and file already exists
    if append == False and stdout == False and os.path.isfile(outfile):
        raise Exception("Attempting to overwrite previous merge file. Delete previous temp_energy_merge.csv file before proceeding.")

    ## set output option (append/write)
    if append == True:
        out_opt = 'a'
    else:
        out_opt = 'w'

    ## Set output locations (stdout or to file)
    if stdout == True:
        out = sys.stdout
        append = False #force write if sent to standard out
    else:
        out = open(outfile, out_opt) #open a writable file for the merge

    # This section creates two vectors of energy data: date collected and energy value
    energy_date_list=[] #create empty list for energy dates (full dates, inc. time)
    energy_value_list=[]    #create empty list for energy values
    with open(energy, 'r') as f:  #open energy.csv file to read
        for line in f:                  #loop over lines
            line = line.strip()         #strip extra char. from lines
            if not line:                #if empty/blank line, then skip
                continue
            data = line.split(',')      #break up columns by ","
            if data[0] == 'Date/Time' or data[0] == 'Total':    #skip header and tail (i.e., variable names and total)
                continue
            date = datetime.strptime(data[0], '%Y-%m-%d %H:%M:%S %z')
            midnight = datetime.strptime('00:00:00', '%H:%M:%S').time() #create midnight time to check if readings taken at midnight
            assert date.time() == midnight, "Energy readings should all be taken at 00:00:00" #check to make sure time is midnight
            energy_date_list.append(date)  #add the next date to the vector
            kw = str(float(data[1])/1000) #create kilowatt variable (divide wh by 1000)
            energy_value_list.append(kw)     #add the next energy value to the vector

    # This section creates a vector of water dates to check sorting and overlap with energy dates
    water_date_list=[] #create empty list for water temp. dates (full dates, inc. time)
    with open(temp, 'r') as f:  #open waterTemperature.csv file to read
        for line in f:                  #loop over lines
            line = line.strip()         #strip extra char. from lines
            if not line:                #if empty/blank line, then skip
                continue
            data = line.split(',')      #break up columns by ","
            if not data[0].isdigit():    #skip 2 headers (lines that don't start with a digit)
                continue
            date = datetime.strptime(data[1], '%m/%d/%y %I:%M:%S %p') #create date.time variable
            water_date_list.append(date)  #add the next date to the vector

    # Additional assertion checks
    ## Check energy and water dates sorted (ascending)
    data_types = [energy_date_list, water_date_list]
    for d in data_types: #loop over energy dates, and then water temp. dates
        for i in range(1, len(d)):
            assert d[i]>d[i-1], d + " dates are not sorted in ascending order"

    ## Check every energy date found in water temp. dates
    water_dates_only = []
    for i in range(0, len(water_date_list)):  #creates list of water temp. dates (dates only, no times)
        water_dates_only.append(water_date_list[i].date())
    for i in range(0, len(energy_date_list)): #check that energy dates all in water reading dates
        assert energy_date_list[i].date() in water_dates_only, "Not all energy dates are found in the water reading dates"

    # This section merges the energy readings to the water temperature readings
    n_energy = 1 #set counter of energy observation
    currentEnergyDay = energy_date_list[n_energy-1] #set date to date of current energy observation

    with open(temp, 'r') as f:    #read in the waterTemperature file
        for line in f:            #loop over lines in waterTemperature.csv
            line = line.strip()   #strip off extra characters from line
            if not line:          #skip if blank line
                continue
            first_char = list(line)[0]  #store the first character from line in order to distinguish header from data
            if first_char == '"':       #if first character is ' " ', then it is the variable names line.
                if append == True: #don't add variable name line if appending
                    continue
                else:
                    out.write(line + ', "Energy (KWh)"' + "\n")  #Write variable names to header, add comma and variable name for Energy column, new line
                    continue                    #skip back to beginning of loop
            elif not first_char.isdigit():  #if first character is not a digit, and not quotation, then it is the title header. Don't print.
                continue
            else:                           #if not first or second line (header or variable names), then...
                water_data = line.split(',')      #create list called data, of each column (date=column #1)
                currentWaterDay = datetime.strptime(water_data[1], '%m/%d/%y %I:%M:%S %p')
            #if currentEnergyDay is a date, and currentWaterDay>=currentEnergyDay, then...
            if isinstance(currentEnergyDay, datetime) and currentWaterDay.date() >= currentEnergyDay.date():
                assert currentWaterDay.date() == currentEnergyDay.date(), "At least one energy date not found in water date" #assertion check
                out.write(line + "," + energy_value_list[n_energy-1] + "\n") #otherwise write the water data, comma, energy reading from date, new line
                if n_energy < len(energy_date_list): #if energy observation is less than length of energy data then...
                    n_energy += 1       #move to next energy observation
                    currentEnergyDay = energy_date_list[n_energy-1] #set currentEnergyDay to date of next obs.
                else: #if reached last energy observation, then set currentEnergyDay to the following string (i.e., no longer a date var.)
                    currentEnergyDay = "past last observation"
            else:   #if currentEnergyDay is not a date, or currentEnergyDay is after currentWaterDay, then...
                out.write(line + "," + "\n") #print water data, comma to separate Energy variable, new line

    if out is not sys.stdout:
        out.close() #close out file
