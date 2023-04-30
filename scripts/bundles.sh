#!/bin/bash
oldIFW=$IFS
IFS=$'\n'

##################
# Modify start
##################


##################
# Modify End
##################



for file in `ls *.xml`
do

	awk '
	BEGIN {
		flag = 0;
	}
	{
		if ( $0 ~  "<bundledProductOffering xmlns"){
			flag=1;
		}

		if ( flag == 1){
			print $0;
			flag =0;
		}
	}

	END {
	} ' FS="|" < $file
		
done

echo "-- Process End"
