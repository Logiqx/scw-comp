### generate_records.sh
## Scan results summary for new PBs/age records
## Created Toby 17/2/2026


# Project Env
. $(dirname $0)/env.sh
set +x

# Check we have dates
if [ -z "$OldDate" ]; then
	cd bin
	. ./generate_compdates.sh
fi



echo 
echo "##############################"
echo "##  New PBs for $OldDate  ##"

# Read Results (from README.md) and extract new records
gawk 'BEGIN {
    # Record types
    map["🔥"] = "average"
    map["⚡"] = "single"
    map["💥"] = "age record"

    # Event types
    emap["222"] = "2x2"
    emap["333"] = "3x3"
    emap["444"] = "4x4"
    emap["555"] = "5x5"
    emap["666"] = "6x6"
    emap["777"] = "7x7"
    emap["minx"] = "mega"
    emap["pyram"] = "pyra"
    emap["333bf"] = "3BLD"
    emap["444bf"] = "4BLD"
    emap["555bf"] = "5BLD"
    emap["333mbf"] = "MBLD"
    emap["sq1"] = "Sq1"
    emap["333fm"] = "FMC"
    emap["333oh"] = "OH"
}
/(🔥|⚡|💥) x / {						# Match a new record indicator
  s = $0						# s = full line matched, we trim the matched portions off as we go
  t = ($1 in map) ? map[$1] : "ERROR! "s		# t = record type

  while (match(s, /\[([^\]]*)\][^\)]+\/([^\.]*)\.md\) ([^<]*)<\/span>/, m)) {   # m[1] is name (text in []), m[2] is event (text between final "/" and ".md)"), m[3] is time/age group (text before "</span>")
    e = (m[2] in emap) ? emap[m[2]] : m[2]					# e = event	
    t == "age record" && t = "new "m[3]" "t"!"			        	# prefix age to age records	
    print m[1]" "e" "t							 	# display name event type
    s = substr(s, RSTART + RLENGTH)						# move to next record on this line
  }
}' docs/results/$OldDate/README.md | sort

echo