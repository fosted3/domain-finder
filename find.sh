#!/bin/bash
for tld in `cat tlds-alpha-by-domain.txt | grep -v "^#" | xargs`; do
	#echo "$tld";
	tld=`echo $tld | tr '[:upper:]' '[:lower:]'`;
	#echo "Looking for $tld";
	domain=`grep "$tld$" words_alpha.txt | grep "^[a-z]\{8\}$" | sed "s/$tld/\.$tld/g"`;
	for hit in $domain; do
		#echo $hit;
		nslookup $hit | egrep -q "server can't find";
		if [ $? -eq 0 ]; then
			echo "$hit available";
		fi;
		usleep 100000;
	done;
done;
