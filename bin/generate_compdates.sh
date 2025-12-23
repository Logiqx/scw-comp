### generate_compdates.sh
## Gets the DATE= value from responses.html and sets $OldDate and $NewDate
## Created Toby 26/10/2025

# Project Env
. $(dirname $0)/env.sh
set +x

# Get current date
OldDate=$(grep DATE= docs/responses.html | sed 's/.*DATE=\(\S*\).*/\1/')

if [ -z "$OldDate" ]; then
	echo "Failed to get the current Comp date from docs/responses.html"
	exit 1
fi	

NewDate=$(date -d "$OldDate + 2 weeks" +%F)
