#!/bin/bash
oldIFS=$IFS
IFS=$'\n'

##################
# Modify start
##################

#Mandatory --  START  --

input_file=names

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
        start_tag=`echo "${key_value_input}" | cut -d "," -f 1`
        start_tag="<$start_tag xmlns"
        value_tag=`echo "${key_value_input}" | cut -d "," -f 2`
        search_key=`echo "${key_value_input}" | cut -d "," -f 3`
        key_value=`echo "${key_value_input}" | cut -d "," -f 4`
        echo "-- -- Start Tag = '$start_tag' and End Tag = '$value_tag'"
        echo "-- -- Search key = '$search_key' and new Value = '$key_value'"

	for file in  ` grep -l "$search_key" *.xml /dev/null | awk -F":" {'print $1'}`
	do

		export start_tag
		export value_tag
        export search_key
        export key_value

		if [ "$file" == $input_file ] ; then
			#echo "-- -- Skipping $file"
			continue
		fi 

		echo "-- -- -- Modifying ${file}"

		awk '
		BEGIN {
			count = 0;
			flag = 0;
			print FILENAME >> "result";
		}
		{
			line=$0
			if ( $0 ~ ENVIRON["start_tag"] ){
				print "flag = ",flag >> "result" ;
				flag=1;
			}

			if ( flag == 1 && $0 ~ ENVIRON["search_key"]){
				print "flag = ",flag >> "result" ;
				flag=2;
			}

			if (flag == 2 && $0 ~ ENVIRON["value_tag"] ){
				print "flag = ",flag >> "result" ;
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
		}
		' FS="|" < "$file" > ${modified_file_directory}/${file}

		if [ -e ${modified_file_directory}/${file} ]; then
			mv  ${modified_file_directory}/${file} $file
		fi
		
		cat stats

		if [ -e "stats" ]; then
			rm stats
		fi

	done


done

echo "-- Process End"
