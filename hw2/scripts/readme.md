Scripts
-------
**Description**
The module **temp_energy_merge** merges energy readings from solar panels to water temperature readings taken throughout the day. To do so, the energy reading taken at midnight is matched to the water temperature reading taken at the nearest time on the same day.

**Instructions**
Start python and import **temp_energy_merge**. (`import temp_energy_merge`) Then move into the data directory. (To do this, import the os module: `import os`, and then use the following command: `os.chdir("../data")`). The module can be used to merge the data: `temp_energy_merge.merge()`. Consult the help file for more information on how to run the module: `help(temp_energy_merge)`. Also note that the module can be run in succession to merge additional dates onto the csv file. See the help section of the module for more information on how to append data. Finally, also note that instead of exporting the merge to the csv file, it can be printed to the screen using the stdout option. Again, see the help file for more information.

This module/script was most recently run on November 17, 2016.
