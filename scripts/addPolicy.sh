#!/bin/bash
oldIFS=$IFS
IFS=$'\n'

##################
# Modify start
##################

#Mandatory --  START  --

input_file=input.txt

modified_file_directory="temp"

#Mandatory --  END  -- 

##################
# Modify End
##################

if [ "$input_file" == "" ]; then
	input_file=input.txt
fi

cat ${input_file} | sort | uniq > ${input_file}_uniq

if [ ! -d "$modified_file_directory" ]; then
	mkdir $modified_file_directory
fi

if [ -e "stats" ]; then
	rm stats
fi


if [ ! -e ${input_file}_uniq ]; then
        echo "-- File '$input_file' doesn't exist"
	exit 1
fi

echo "-- Process Start"

for line in `cat $input_file`
do

    file=`echo "${line}" | cut -d "," -f 1`
    resource=`echo "${line}" | cut -d "," -f 2`
    quota=`echo "${line}" | cut -d "," -f 3`
	
	export resource
	export quota

	echo "Processing $file" >> "result" ;
	echo "Processing $file"
	
	awk '
	BEGIN {
		count = 0;
		flag = 0;
		#print FILENAME >> "result";
	}
	{
		line=$0
		print $0;
		if ( flag == 2 && $0 ~ "</recurringCharge>"){
			#print $0 >> "result" ;
			print "--Adding", ENVIRON["quota"] >> "result" ;
			oldIFS=OFS;
			OFS="";
			recurringChargeEnd=$0 ;
			print recurringChargeStart;
			print "                        <price>-1</price>";
			print "                        <unitOfMeasure>NONE</unitOfMeasure>";
			print "                        <balanceElementNumCode>",ENVIRON["quota"],"</balanceElementNumCode>";
			print discountable;
			print "                        <priceType>GRANT</priceType>";
			print priceValidityStart;
			print startValidityMode;
			print endValidityMode;
			print validityRange;
			print relativeStartOffset;
			print relativeEndOffset;
			print relativeEndOffsetUnit;
			print priceValidityEnd;
			print "                        <proratable>false</proratable>";
			print "                        <impactType>FIXED</impactType>";
			print recurringChargeEnd;
			count++;
			OFS=oldIFS;
			flag=0;
		}else if ( $0 ~ "recurringCharge>" ){
			#print $0 >> "result" ;
			flag=1;
			recurringChargeStart=$0;
			price="";
			unitOfMeasure="";
			balanceElementNumCode="";
			discountable="";
			priceType="";
			priceValidityStart="";
			startValidityMode="";
			endValidityMode="";
			validityRange="";
			relativeStartOffset="";
			relativeEndOffset="";
			relativeEndOffsetUnit="";
			priceValidityEnd="";
			proratable="";
			impactType="";
			recurringChargeEnd="";
		}else if ( flag == 1 && $0 ~ "<price>"){
			#print $0 >> "result" ;
			price=$0 ;
		}else if ( flag == 1 && $0 ~ "<unitOfMeasure>"){
			#print $0 >> "result" ;
			unitOfMeasure=$0 ;
		}else if ( flag == 1 && $0 ~ "<balanceElementNumCode>" && $0 ~ ENVIRON["resource"]){
			print "--Found", ENVIRON["resource"] >> "result" ;
			#print $0 >> "result" ;
			flag=2;
			balanceElementNumCode=$0 ;
		}else if ( flag == 1 && $0 ~ "<balanceElementNumCode>" && $0 !~ ENVIRON["resource"]){
			#print $0 >> "result" ;
			flag=0;
			price="";
			unitOfMeasure="";
			balanceElementNumCode="";
		}else if ( flag == 2 && $0 ~ "<discountable>"){
			#print $0 >> "result" ;
			discountable=$0 ;
		}else if ( flag == 2 && $0 ~ "<priceValidity>"){
			#print $0 >> "result" ;
			priceValidityStart=$0 ;
		}else if ( flag == 2 && $0 ~ "<startValidityMode>"){
			#print $0 >> "result" ;
			startValidityMode=$0 ;
		}else if ( flag == 2 && $0 ~ "<endValidityMode>"){
			#print $0 >> "result" ;
			endValidityMode=$0 ;
		}else if ( flag == 2 && $0 ~ "<validityRange>"){
			#print $0 >> "result" ;
			validityRange=$0 ;
		}else if ( flag == 2 && $0 ~ "<relativeStartOffset>"){
			#print $0 >> "result" ;
			relativeStartOffset=$0 ;
		}else if ( flag == 2 && $0 ~ "<relativeEndOffset>"){
			#print $0 >> "result" ;
			relativeEndOffset=$0 ;
		}else if ( flag == 2 && $0 ~ "<relativeEndOffsetUnit>"){
			#print $0 >> "result" ;
			relativeEndOffsetUnit=$0 ;
		}else if ( flag == 2 && $0 ~ "</priceValidity>"){
			#print $0 >> "result" ;
			priceValidityEnd=$0 ;
		}else if ( flag == 2 && $0 ~ "<proratable>"){
			#print $0 >> "result" ;
			proratable=$0 ;
		}else if ( flag == 2 && $0 ~ "<impactType>"){
			#print $0 >> "result" ;
			impactType=$0 ;
		}

	}
	END {
		print "-- -- ", ENVIRON["quota"], "added in ", count ," place"  >> "result"  ;
	}
	' FS="|" "$file" > ${modified_file_directory}/${file}

	if [ -e ${modified_file_directory}/${file} ]; then
		mv  ${modified_file_directory}/${file} $file
	fi

done

echo "-- Process End"
