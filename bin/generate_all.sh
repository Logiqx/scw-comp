### generate_all.sh
## Run results, scrambles, forms and push scripts
## Created Toby 26/10/2025

# Results
. generate_results.sh

# Scrambles
cd $PROJ_DIR/bin
. generate_scrambles.sh

# Links
cd $PROJ_DIR/bin
. generate_newform.sh

# Push
echo
echo
read -p "Process complete, enter 'Y' to push commits to GitHub (anything else will skip the push): " DoCommit

if [ "$DoCommit" == "Y" ]; then
	echo
	echo "Pushing changes to GitHub, please wait..."
	echo

	set +e
	git push
fi