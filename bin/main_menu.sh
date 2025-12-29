### main_menu.sh
## Menu for SCW Comp operations
## Created Toby 26/10/2025

# Project Env
. $(dirname $0)/env.sh
set +x

# Get dates - do out of loop as the generate_newform can change them, this way they stay the same until the menu is closed and rerun
cd bin
. generate_compdates.sh
	
## Main menu
while true; do
	set +x
	
	clear
	echo
	echo
	echo "############################################"
	echo "## Senior Cubers Worldwide Video Competition"
	echo "############################################"
	echo
	echo
	echo Main Menu
	echo 
	echo -e "\t1. Download and Process Results for $OldDate"
	echo -e "\t2. Generate Scrambles for $NewDate"
	echo -e "\t3. Create new Google Form for $NewDate"
	echo -e "\t4. Push committed changes to GitHub"
	echo
	echo -e "\t0. All of the above in order"
	echo
	echo "Press [Enter] to exit"

	echo
	read -p "Enter selection: " UserSel

	cd bin
		
	case "$UserSel" in
		""|"Q"|"q") exit 0;;
		"1") . generate_results.sh;;
		"2") . generate_scrambles.sh;;
		"3") . generate_newform.sh;;
		"4") git push;;
		"0") . generate_all.sh;;		
	esac
	
	set +x
	echo
	echo
	read -n1 -p "Press any key to return to the main menu"
done
