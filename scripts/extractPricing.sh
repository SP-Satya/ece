#!/usr/bin/sh


input_file=$1
interval=2

export_bundle=' '
export_CO=' -expRefs'
export_DO=' -expRefs'

if [ ! -d export_file ] ; then
	mkdir export_file
fi

if [ "$input_file" == "" ]; then
	input_file=pricing_export_list
fi

remove_timeModel_genericSelector(){
	time_model=0
	triggerSpec=0
	genericSelector=0
	file=$1

	grep "timeModel xmlns" $file >/dev/null
	if [ $? -eq 0 ] ; then
		time_model=1
	fi

	grep "triggerSpec xmlns" $file >/dev/null
	if [ $? -eq 0 ] ; then
		triggerSpec=1
	fi

	grep "genericSelector xmlns" $file >/dev/null
	if [ $? -eq 0 ] ; then
		genericSelector=1
	fi
	
	if [ "$mode" != 'skip' ] ; then
		if [ $time_model -eq 1 -a $triggerSpec -eq 0 ] ; then
			cat $file | sed '2,/chargeRatePlan/ d' | sed '1 s/timeModel/chargeRatePlan/' > ${file}_tmp
			mv ${file}_tmp $file
		elif [ $time_model -eq 1 -a $triggerSpec -eq 1 ] ; then
			cat $file | sed '2,/triggerSpec/ d' | sed '1 s/timeModel/triggerSpec/' > ${file}_tmp
			mv ${file}_tmp $file
		elif [ $genericSelector -eq 1 -a $triggerSpec -eq 0 ] ; then
			cat $file | sed '2,/chargeRatePlan/ d' | sed '1 s/genericSelector/chargeRatePlan/' > ${file}_tmp
			mv ${file}_tmp $file
		elif [ $genericSelector -eq 1 -a $triggerSpec -eq 1  ] ; then
			cat $file | sed '2,/triggerSpec/ d' | sed '1 s/genericSelector/triggerSpec/' > ${file}_tmp
			mv ${file}_tmp $file
		fi
	fi

}

checkSpace() {
	pecentUsed=`df -hT | grep "/dev/mapper/ocivolume-root" | awk '{print $6}' | sed 's/%//'`
}

timestamp=`date +%Y%m%d-%H%M%S`

oldIDS=$IFS
IFS="
"
for name in `cat $input_file`
do
	IFS=$oldIFS

	checkSpace
	if [ $pecentUsed -gt 97 ]; then
		echo "No space on device"
		break;
	fi

	echo "Started extracting $name"
	name_mod=`echo $name | sed -e 's/ /_/g' -e 's/(/_/g' -e 's/)/_/g'`
	name=`echo $name | sed 's/ /\\ /g'`
	echo "--pricing object name = $name"
	echo "--pricing file name = ${name_mod}_pricing.xml"

	if [ -e ${name_mod}_pricing.xml ] ; then
		mv ${name_mod}_pricing.xml ${name_mod}_pricing.xml_$timestamp
	fi

	if [[ "$name" =~ '_CO' ]] ; then
		echo C1g2b3u4# | ./ImportExportPricing -export ${name_mod}  -pricing -n $name  $export_CO
		status=$?
		pricing_file=${name_mod}_pricing.xml
		remove_timeModel_genericSelector ${pricing_file}

	elif [[ $name = '_DO' ]] ; then
		echo C1g2b3u4# | ./ImportExportPricing -export ${name_mod}  -pricing -n $name $export_DO
		status=$?
	else
		echo C1g2b3u4# | ./ImportExportPricing -export ${name_mod}  -pricing -n $name $export_bundle
		status=$?
	fi

	if [ $status -ne 0 ] ; then
		echo "pricing export failed for $name"
	else
		echo "--pricing export successfully for $name"
		mv ${name_mod}_pricing.xml ./export_file/
	fi

	echo ""

	sleep $interval

done

#mv pricing_export_list pricing_export_list_done
