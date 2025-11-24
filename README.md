# scw-comp

Python project for the weekly competition of [Senior Cubers Worldwide](https://www.facebook.com/groups/1604105099735401).

Reports are published at [https://logiqx.github.io/scw-comp/](https://logiqx.github.io/scw-comp/)



Instructions
------------

Initial Install:
 - Download Docker and install WSL on you machine
 - Clone the repo and run *bin/docker_build.sh* to crea the Docker containers
 

Process results for current competition
 - Create a new *data/[date]* folder, where *[date]* is the YYYY-MM-DD date of the current competition
 - Save the current [Responses Sheet][https://logiqx.github.io/scw-comp/responses.html] to this new folder (as .xlsx)
 - Run *bin/convert_spreadsheets.sh* to pre-process these results
 - Check for "ERROR" lines in the output, manually correct these in the downloaded XLSX file and rerun *bin/convert_spreadsheets.sh*
 - Repeat the above step until all "ERROR" lines are cleared
 - Run *bin/weekly_results.sh* to process the final results
 - Make note of the prizewinners and copy to the [Prizes Sheet][https://logiqx.github.io/scw-comp/prizes/winners.html]
 
 
Generate scrambles for new competition
 - Generate the scrambles using TNoodle and extract the resulting zip to the *scrambles/* folder (should create *scrambles/Scrambles for [New Date]/*")
 - Run *bin/weekly_scrambles.sh* to process the new scrambles
 - Delete the zip and extracted contents
 - Edit *docs/scrambles.html* to use the new date at the end of the URL
  

Create Google Form/Sheet for new competition
New Sheet:
 - In Google drive open the current Responses sheet and do *File->Make a Copy*
 - In the popup that appears change the name to use the new competition date and remove the "Copy of"
 - Ensure "*Share it with the same people*" is selected and then click "*Make a Copy*"
 - When the new form appears, delete all the existing content except for the header row
 - Click the "*Share*" button and then click "*Copy Link*" to get the URL of the new Sheet
 - Edit *docs/responses.hml* to use this new link
 
New Form:
 - Back in Google drive it will have created a new "Copy of ..." Form when you copied the Sheet
 - Rename this Form to use the new competition date and remove the "Copy of"
 - Open the Form and change the title to use the new competition date
 - Click the "*Published"* button and then click "*Copy Responder Link*" to get the URL of the new Form
 - Edit *docs/submit.html* to use this new link
 - Edit *docs/analytics.html* to use the same link but with "/viewanalytics" at the end instead of "/viewform"

 
 