ls */* | sed -E 's/(.*)\/(.*)\.(.*)/mkdir \2/' | sort -u
ls */* | sed -E 's/(.*)\/(.*)\.(.*)/chmod 755 \2/' | sort -u
