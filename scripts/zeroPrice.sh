for file in  ` grep -l "<balanceElementNumCode>458</balanceElementNumCode>" *.xml /dev/null | awk -F":" {'print $1'} | grep -v B-DIGI`
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

			if ( flag == 1 && $0 ~ "<price>0.0" ){
				print "flag = ",flag >> "result" ;
				flag=2;
			}
			
			if (flag == 2 && $0 ~ "<balanceElementNumCode>458" ){
				flag=0;
				#print FILENAME, ": type 1 change";
				count++;
			}

		}
		END {
				print "-- ", "found in ", count ," place"  > "stats";
		}
		' FS="|" < "$file" 
		
		grep "found in  0  place"  stats > /dev/null
		if [ $? -ne 0 ] ;then
			echo $file
		fi
done

