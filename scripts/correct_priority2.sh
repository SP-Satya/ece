#!/bin/bash
oldIFW=$IFS
IFS=$'\n'

for CO_attribute in `cat names`
do
	#IFW=$old_IFS
	echo "print line $CO_attribute"
	CO_name=`echo "$CO_attribute" | cut -d "," -f 1`
	CO_priority=`echo "$CO_attribute" | cut -d "," -f 2`
	echo "CO NAME= $CO_name"
	echo "CO PRIORITY = $CO_priority"

	#echo "grep -l \"$CO_name\" * 2>/dev/null | awk -F"," {'print $1'}"

	for file in  ` grep -l "$CO_name" * 2>/dev/null | awk -F":" {'print $1'}`
	do

		export CO_priority
		export CO_name
		echo "$CO_name found in ${file}"
		awk '
		BEGIN {
			transaction_count = 0;
		}
		{
			line=$0
			if ( $0 ~ "chargeOffering"){
					flag=1;
			}

			if ( flag == 1 && $0 ~ ENVIRON["CO_name"]){
					flag=2;
			}

			if (flag == 2 && $0 ~ "priority" ){
					print "<priority>",ENVIRON["CO_priority"],"</priority>";
					flag=0;
			}else{
				print $i
			}

		}
		END {
		}
		' FS="|" < "$file" > ${file}_mod
		
	done

done

