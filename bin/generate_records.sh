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
    map["🔥"] = " avg"
    map["⚡"] = " single"
    map["💥"] = " age record"
}
/(🔥|⚡|💥) x / {
  s = $0
  t = ($1 in map) ? map[$1] : "ERROR! "s

  while (match(s, /\[([^\]]*)\][^\)]+\/([^\.]*)\.md/, m)) {
    print m[1]" "m[2]" "t
    s = substr(s, RSTART + RLENGTH)
  }
}' docs/results/$OldDate/README.md | sort

echo