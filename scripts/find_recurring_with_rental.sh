#!/bin/bash
oldIFS=$IFS
#IFS=$'\n'


echo "-- Process Start"


for file in `ls *.xml`
do

		echo "Processing $file"
		awk '
		BEGIN {
			count = 0;
			flag = 0;
			price = "";
			crp_name="";
		}
		{
			line=$0
			if ( $0 ~ "chargeRatePlan xmlns" ){
				#print "flag = ",flag >> "result" ;
				flag=1;
			} else if ( flag == 1 && $0 ~ "<name>" ){
				crp_name=$0;
				flag=2
			}else if ( flag == 2 && $0 ~ "<recurringCharge>" ){
				#print "flag = ",flag >> "result" ;
				flag=3;
			}else if ( flag == 3 && $0 ~ "</recurringCharge>" ){
				#print "flag = ",flag >> "result" ;
				flag=2;
			}else if ( flag == 3 && $0 ~ "<price>" ){
				price=$0;
				flag=4;
			}else if ( flag == 4 && $0 ~ "<balanceElementNumCode>458</balanceElementNumCode>" ){
				if ( price ~ "<price>0.0</price>" ){
					print "skipping", ARGV[2],crp_name >> "result";
				}else if ( price ~ "<price>0</price>" ){
					print "skipping", ARGV[2],crp_name >> "result";
				}else{
					flag=0;
					OFS=",";
					print ARGV[2],crp_name >> "result";
				}
			}else if ( $0 ~ "alterationRatePlan xmlns" ){
				flag=0;
			}

		}
		END {
			print "-- -- -- ", ENVIRON["value_tag"], "modified in ", count ," place"  > "stats"  ;
		}
		' FS="|" "$file"


done

echo "-- Process End"
