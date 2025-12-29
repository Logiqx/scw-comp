### generate_newform.sh
## Call Google AppScript to create new files and update the links in our HTML files
## Created Toby 26/10/2025


# Project Env
. $(dirname $0)/env.sh
set +x

# Check we have dates
if [ -z "$NewDate" ]; then
	cd bin
	. generate_compdates.sh
fi

# Get Google AppKey
AppKey=$(cat bin/GoogleAppKey.txt)

if [ -z "$AppKey" ]; then
	echo "Failed to get the Google AppKey from bin/GoogleAppKey.txt"
	exit 1
fi	

# Get current sheet id
CurrentID=$(grep URL= docs/responses.html | awk -F'/' '{print $6}')

if [ -z "$CurrentID" ]; then
	echo "Failed to get the current Sheet ID from docs/responses.html"
	exit 1
fi	

# Call Google script to create to create new vars, returns "FormURL=xxx SheetID=xxx"
echo
echo -n Creating new forms for $NewDate, please wait ...
NewIDs=$(wget -qO- "https://script.google.com/macros/s/$AppKey/exec?SheetID=$CurrentID&ForDate=$NewDate")
echo Done

# Extracts new Ids
echo -n Updating HTML links... 
FormURL=$(echo $NewIDs | sed 's/.*FormID=\(\S*\).*/\1/')
SheetID=$(echo $NewIDs | sed 's/.*SheetID=\(\S*\).*/\1/')
AnalURL=$(echo $FormURL | sed 's:/viewform:/viewanalytics:')

# Replace in HTML files
sed -i "s,URL=.*\",URL=$FormURL\"," docs/submit.html 
sed -i "s,URL=.*\",URL=$AnalURL\"," docs/analytics.html
sed -i "s:spreadsheets/d/[^/]*/:spreadsheets/d/$SheetID/:" docs/responses.html
sed -i "s/DATE=\S*/DATE=$NewDate/" docs/responses.html
sed -i "s/$OldDate/$NewDate/" docs/scrambles.html

echo Done


read -p "Enter 'Y' to commit changes to git (anything else will skip the commit): " DoCommit

if [ "$DoCommit" == "Y" ]; then
	echo
	echo "Committing changes, please wait..."
	echo

	git add . 
	git commit -m "Scrambles/links for $NewDate"
fi