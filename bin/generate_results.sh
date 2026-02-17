### generate_results.sh
## Download current XLSX and process
## Created Toby 26/10/2025


# Project Env
. $(dirname $0)/env.sh
set +x

# Check we have dates
if [ -z "$OldDate" ]; then
	cd bin
	. generate_compdates.sh
fi


# Get current sheet id
URL=$(grep URL= docs/responses.html | sed 's/.*URL=\(.*\)".*/\1/' | sed 's:/view:/export\?format=xlsx:')

if [ -z "$URL" ]; then
	echo Failed to get the current Sheet URL from docs/responses.html
	exit 1
fi	

# Create new folder for current comp
cd data
mkdir -p $OldDate

# There can be errors in the XLSX that need to be manually fixed, so we loop and allow [R]eload until it's all good
Reload=true
while $Reload == "true"; do 
	cd $PROJ_Dir/data/$OldDate
	rm -f *.xlsx

	# Get the XLSX
	echo
	echo -n Getting responses XLSX...
	wget -q --content-disposition $URL
	echo Done

	# Run convert_spreadsheet scripts to extract results into CSVs for Python
	echo Processing results
	echo
	cd $PROJ_DIR

	cd bin
	. convert_spreadsheets.sh
	set +x
	echo
	echo
	echo "Are there any ERRORS above that need to be fixed in the XLSX? If so edit it in Google Drive and enter 'R' to reload the spreadsheet before continuing."
	echo 
	read -p "Enter R to [R]eload any manual changes to the XLSX, or [Enter] to continue processing when there are no issues: " UserSel

	case "$UserSel" in
		"R"|"r") Reload=true;;
		*) Reload=false;;
	esac
done


## Generate/updated the results pages with weekly_results.sh
echo
cd bin
. weekly_results.sh

# weekly-results outputs 4 prizewinners from when we used to give out $10 vouchers, I still add to the Prizes spreadsheet just in case
set +x
echo
echo
echo "** Take note of the prizewinners above! **"
echo

# Generate list of PBs for Facebook page in lieu of prizewinners
cd bin
. generate_records.sh


## Commit and continue
read -p "Take note of the prizewinners/PBs above and enter 'Y' to commit changes to git (anything else will skip the commit): " DoCommit

if [ "$DoCommit" == "Y" ]; then
	echo
	echo "Committing changes, please wait..."
	echo
	git add . 
	git commit -m "Results for $OldDate"
fi

