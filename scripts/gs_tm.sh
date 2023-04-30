mode=$1

if [ "$mode" == "" ]; then
	mode=test
fi

for file in `ls *.xml | grep -v B-DIGI`
do
	time_model=0
	triggerSpec=0
	genericSelector=0

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
	
	if [ "$mode" = run ] ; then
		if [ $time_model -eq 1 -a $triggerSpec -eq 0 ] ; then
			cat $file | sed '2,/chargeRatePlan/ d' | sed '1 s/timeModel/chargeRatePlan/' > ${file}_tmp
			mv ${file}_tmp $file`
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
		

	else
		if [ $time_model -eq 1 -a $triggerSpec -eq 0 ] ; then
			echo "chage 1 for $file"
		elif [ $time_model -eq 1 -a $triggerSpec -eq 1 ] ; then
			echo "change 2 for $file"
		elif [ $genericSelector -eq 1 -a $triggerSpec -eq 0 ] ; then
			echo "change 3 for $file"
		elif [ $genericSelector -eq 1 -a $triggerSpec -eq 1 ] ; then
			echo "change 4 for $file"
		fi
	fi
done
