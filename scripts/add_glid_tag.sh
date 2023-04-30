
if [ -e "stats" ]; then
	:> stats
fi

modified_file_directory="temp"

for file in  ` grep -l "<balanceElementNumCode>458</balanceElementNumCode>" *.xml /dev/null | awk -F":" {'print $1'} | grep -v B-DIGI`
#for file in `echo PreB_QTU_BB_5_Unltd_VoIP-30days_550031_pricing.xml`
do
	
#	echo $file
	awk '
		BEGIN {
			count = 0;
			flag = 0;
			print FILENAME >> "result";
		}
		{
			line=$0
			if ( $0 ~ "<oneTimeCharge>" ){
				print "flag = ",flag >> "result" ;
				flag=1;
			}else if ( $0 ~ "<recurringCharge>" ) {
				print "flag = ",flag >> "result" ;
				flag=1;
			}else if ( $0 ~ "</recurringCharge>" ) {
				flag=0;
			}else if ( $0 ~ "</oneTimeCharge>" ) {
				flag=0;
			}

			if ( flag == 1 && $0 ~ "<balanceElementNumCode>458" ){
				print "flag = ",flag >> "result" ;
				flag=2;
			}
			
			if ( flag == 2 && $0 ~ "priceType" ){
				print "flag = ",flag >> "result" ;
				flag=3;
			}

			if (flag == 3 && $0 ~ "impactType" ){
				flag=0;
				#print FILENAME, ": type 1 change";
				print "<glid>105</glid>";
				count++;
			}else if (flag == 3 && $0 ~ "priceValidity" ){
				flag=0;
				#print FILENAME, ": type 2 change";
				print "<glid>105</glid>";
				count++;
			}else if (flag == 3 && $0 ~ "glid" ){
				flag=0;
				#print "already has glid";
			}
			
			print $0

		}
		END {
			print "-- ", "modified in ", count ," place"  > "stats"  ;
		}
		' FS="|" < "$file" > ${modified_file_directory}/${file}
		
		grep "modified in  0  place"  stats > /dev/null
		if [ $? -ne 0 ] ;then
			echo $file
			#cat stats
		else
			rm  ${modified_file_directory}/${file}
		fi

		if [ -e "stats" ]; then
			:> stats
		fi
done
