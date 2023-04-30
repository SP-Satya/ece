#!/bin/bash
oldIFW=$IFS
IFS=$'\n'

##################
# Modify start
##################

#Mandatory --  START  --

input_file=indv_names

## search tag from where lookup will begin
#start_tag=chargeOffering

## search tag to be replaced 
#value_tag=priority

modified_file_directory="temp"

#Mandatory --  END  -- 


###### OPTIONAL -  only for logging purpose
#key_name=CO_name
#value_name=CO_priority
###### OPTIONAL - END 

##################
# Modify End
##################

if [ "$input_file" == "" ]; then
	input_file=input_file
fi

#if [ "$key_name" == "" ]; then
#	key_name="$start_tag"
#fi

#if [ "$value_name" == "" ]; then
#	value_name="$value_tag"
#fi

if [ ! -d "$modified_file_directory" ]; then
	mkdir $modified_file_directory
fi

if [ -e "stats" ]; then
	rm stats
fi

#if [ "$start_tag" == "" -o "$value_tag" == "" ]; then
#       echo "-- 'search_tag' and 'value_tag' are mandatory"
#       exit 1
#elif [ ! -e $input_file ]; then
if [ ! -e $input_file ]; then
        echo "-- File '$input_file' doesn't exist"
	exit 1
fi

echo "-- Process Start"
#echo "-- Start tag '$start_tag'"
#echo "-- Replacement tag '$value_tag'"

for key_value_input in `cat $input_file`
do
	#echo "print line $key_value"
    target_file_name=`echo "${key_value_input}" | cut -d "," -f 1`
	start_tag=`echo "${key_value_input}" | cut -d "," -f 2`
    start_tag="<$start_tag xmlns"
	value_tag=`echo "${key_value_input}" | cut -d "," -f 3`
	search_key=`echo "${key_value_input}" | cut -d "," -f 4`
	key_value=`echo "${key_value_input}" | cut -d "," -f 5`
	

	echo "-- -- $key_name = '$search_key' and $value_name = '$key_value' and target_file_name = $target_file_name"

	if [ "$target_file_name" == "" ]; then
		echo "-- -- -- Missing target file_name"
		exit 1
	fi

	export key_value

	export start_tag
	export value_tag
	export search_key
	export key_value

	echo "-- -- -- Modifying ${target_file_name}"

	awk '
	BEGIN {
		count = 0;
	}
	{
		line=$0
		if ( $0 ~ ENVIRON["start_tag"] ){
			flag=1;
		}

		if ( flag == 1 && $0 ~ ENVIRON["search_key"]){
			flag=2;
		}

		if (flag == 2 && $0 ~ ENVIRON["value_tag"] ){
			OFS=""	
			print "<",ENVIRON["value_tag"],">",ENVIRON["key_value"],"</",ENVIRON["value_tag"],">";
			count++;
			flag=0;
			OFS=" "	
		}else{
			print $i
		}

	}
	END {
			print "-- -- -- ", ENVIRON["value_tag"], "modified in ", count ," place"  > "stats"  ;
	} ' FS="|" < "$target_file_name" > ${modified_file_directory}/${target_file_name}
		
		cat stats
		if [ -e "stats" ]; then
			rm stats
		fi
done

echo "-- Process End"
