### generate_records.sh
## Scan results summary for new PBs/age records
## Created Toby 17/2/2026


# Project Env
. $(dirname $0)/env.sh
set +x

# Check we have dates
if [ -z "$OldDate" ]; then
	cd bin
	. generate_compdates.sh
fi



echo 
echo "##############################"
echo "##  New PBs for $OldDate  ##"

gawk 'BEGIN {
    map["🔥"] = "average"
    map["⚡"] = "single"
    map["💥"] = "age record"

    emap["222"] = "2x2"
    emap["333"] = "3x3"
    emap["444"] = "4x4"
    emap["555"] = "5x5"
    emap["666"] = "6x6"
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
/(🔥|⚡|💥) x / {
  s = $0
  t = ($1 in map) ? map[$1] : "ERROR! "s

  while (match(s, /\[([^\]]*)\][^\)]+\/([^\.]*)\.md/, m)) {
    e = (m[2] in emap) ? emap[m[2]] : m[2]	
    print m[1]" "e" "t
    s = substr(s, RSTART + RLENGTH)
  }
}' docs/results/$OldDate/README.md | sort

echo