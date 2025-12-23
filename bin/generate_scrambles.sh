### generate_scrambles.sh
## Wrapper around TNoodle and the weekly_scrambles.sh script
## Created Toby 24/10/2025


# Project Env
. $(dirname $0)/env.sh
set +x

# Start TNoodle - assumes the jar is in the bin folder, change path as needed
java -jar bin/TNoodle-WCA-1.2.2.jar >/dev/null &
JavaPID=$!

# Check we have dates
if [ -z "$NewDate" ]; then
	cd bin
	. generate_compdates.sh
fi

echo
echo Generating scrambles for $NewDate
echo

# Give TNoodle time to start (wget will retry 3 times anyway)
sleep 4

# Update WCIF to the new date
sed -e "s/%DATE%/$NewDate/g" scrambles/SCW_WCIF_Template.json > scrambles/Scrambles_$NewDate.json

# Send WCIF to TNoodle (localhost assumes running in Linux, use the Windows IP from ip route if running in Linux)
IP=localhost
#IP=$(ip route show | grep -i default | awk '{ print $3}')
wget --retry-connrefused $IP:2014/wcif/zip --post-file scrambles/Scrambles_$NewDate.json --header "Content-type: application/json" -O scrambles/Scrambles\ for\ $NewDate.zip

# Unzip TNoodle output
unzip scrambles/Scrambles\ for\ $NewDate.zip -d scrambles/Scrambles\ for\ $NewDate


# Call the weekly_scrambles script (it assumes we are in bin but changes to ../)
echo
echo Processing scrambles for $NewDate
echo

cd bin
. weekly_scrambles.sh


# Clean up
set +x
echo
echo -n Cleaning up....
kill -KILL $JavaPID
sleep 2
rm -rf scrambles/*$NewDate*
rm -f tnoodle.log
echo Done


