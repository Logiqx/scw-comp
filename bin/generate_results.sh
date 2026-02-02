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

cd $OldDate
rm -f *.xlsx

# Get the XLSX
echo
echo -n Getting responses XLSX...
wget -q --content-disposition $URL
echo Done

# Run convert_spreadsheet/weekly_results scripts
echo Processing results
echo
cd $PROJ_DIR

Reload=true
while $Reload == "true"; do 
	cd bin
	. convert_spreadsheets.sh
	set +x
	echo
	echo
	echo "Are there any ERRORS above that need to be fixed in the XLSX? If so edit it in data/$OldDate and reload the data before continuing."
	echo 
	read -p "Enter R to [R]eload any manual changes to the XLSX, or [Enter] to continue processing when there are no issues: " UserSel

	case "$UserSel" in
		"R"|"r") Reload=true;;
		*) Reload=false;;
	esac
done

echo
cd bin
. weekly_results.sh

set +x
echo
echo
echo "** Take note of the prizewinners above! **"
echo
read -p "Take note of the prizewinners above and enter 'Y' to commit changes to git (anything else will skip the commit): " DoCommit

if [ "$DoCommit" == "Y" ]; then
	echo
	echo "Committing changes, please wait..."
	echo
	git add . 
	git commit -m "Results for $OldDate"
fi