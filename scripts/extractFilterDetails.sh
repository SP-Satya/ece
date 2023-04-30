if [ -e filter_result.csv ] ; then
	echo "" > filter_result.csv 
else
	touch filter_result.csv
fi

echo "pricingFile","name","rumName","balanceElementNumCode"," genericSelectorResult"," impactCategory","zoneResult","timeModelTagName","USAGE_TYPE","USAGE_CLASS","SERVICE_CODE","SERVICE_CLASS" > "filter_result.csv"
	
	
for file in  ` ls ../*.xml | awk -F":" {'print $1'} | grep -v B-DIGI`
do
	

		
	#echo $file
	awk '
		BEGIN {
			count = 0;
			flag = 0;
			#print FILENAME >> "result";
			OFS=",";
		}
		{
			line=$0
			if ( flag == 1 && $0 ~ "name" ){
				name=$0; 
			}
			else if ( flag == 1 && $0 ~ "rumName" ){
				rumName=$0; 
			}else if ( flag == 1 && $0 ~ "balanceElementNumCode" ){
				balanceElementNumCode=$0; 
			}else if ( flag == 1 && $0 ~ "genericSelectorResult" ){
				genericSelectorResult=$0; 
			}else if ( flag == 1 && $0 ~ "impact" ){
				impactCategory=$0; 
			}else if ( flag == 1 && $0 ~ "zoneResult" ){
				zoneResult=$0; 
			}else if ( flag == 1 && $0 ~ "timeModelTagName" ){
				timeModelTagName=$0; 
			}else if ( flag == 1 && $0 ~ "<eventField>AnyEvent.USAGE_TYPE</eventField>" ){
				eventField=1
			}else if ( flag == 1 && $0 ~ "eventValue" && eventField == 1 ){
				USAGE_TYPE=$0; 
			}else if ( flag == 1 && $0 ~ "<eventField>AnyEvent.USAGE_CLASS</eventField>" ){
				eventField=2
			}else if ( flag == 1 && $0 ~ "eventValue" && eventField == 2 ){
				USAGE_CLASS=$0; 
			}else if ( flag == 1 && $0 ~ "<eventField>AnyEvent.SERVICE_CODE</eventField>" ){
				eventField=3
			}else if ( flag == 1 && $0 ~ "eventValue" && eventField == 3 ){
				SERVICE_CODE=$0; 
			}else if ( flag == 1 && $0 ~ "<eventField>AnyEvent.SERVICE_CLASS</eventField>" ){
				eventField=4
			}else if ( flag == 1 && $0 ~ "eventValue" && eventField == 4 ){
				SERVICE_CLASS=$0; 
			}else if ( flag == 1 && $0 ~ "</chargeSelectorSpec>" && $0 ~ "chargeSelectorSpec xmlns" ) {
				print pricingFile,name,rumName,balanceElementNumCode, genericSelectorResult, impactCategory,zoneResult,timeModelTagName,USAGE_TYPE,USAGE_CLASS,SERVICE_CODE,SERVICE_CLASS;
				name="";
				rumName="";
				balanceElementNumCode="";
				genericSelectorResult="";
				impactCategory="";
				zoneResult="";
				timeModelTagName="";
				USAGE_TYPE="";
				USAGE_CLASS="";
				SERVICE_CODE="";
				SERVICE_CLASS="";
				eventField=0
				pricingFile=ARGV[2];
				count++;
			}else if ( flag == 1 && $0 ~ "</chargeSelectorSpec>" && $0 ~ "<chargeRatePlan"  ) {
				flag=0;
				print pricingFile,name,rumName,balanceElementNumCode, genericSelectorResult, impactCategory,zoneResult,timeModelTagName,USAGE_TYPE,USAGE_CLASS,SERVICE_CODE,SERVICE_CLASS;
			}else if ( $0 ~ "<chargeSelectorSpec xmlns" ){
				flag=1;
				name="";
				rumName="";
				balanceElementNumCode="";
				genericSelectorResult="";
				impactCategory="";
				zoneResult="";
				timeModelTagName="";
				USAGE_TYPE="";
				USAGE_CLASS="";
				SERVICE_CODE="";
				SERVICE_CLASS="";
				eventField=0
				pricingFile=ARGV[2];
				count++;
			}

		}
		END {
				print ARGV[2], " - ", "found in ", count ," place"  >> "stats";
		}
		' FS="|" "$file" >> filter_result.csv
		
done

if [ -e filter_result.csv ] ; then
	sed -e 's/<name>//' \
		-e 's/<\/name>//' \
		-e 's/<rumName>//' \
		-e 's/<\/rumName>//' \
		-e 's/<balanceElementNumCode>//' \
		-e 's/<\/balanceElementNumCode>//' \
		-e 's/<genericSelectorResult>//' \
		-e 's/<\/genericSelectorResult>//' \
		-e 's/<impactCategory>//' \
		-e 's/<\/impactCategory>//' \
		-e 's/<zoneResult>//' \
		-e 's/<\/zoneResult>//' \
		-e 's/<timeModelTagName>//' \
		-e 's/<\/timeModelTagName>//' \
		-e 's/<eventValue>//g' \
		-e 's/<\/eventValue>//g' filter_result.csv > filter_result_final.csv
fi