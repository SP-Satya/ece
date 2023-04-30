hex_convert() {
   mcc_mnc=$mcc_mnc
   first=`echo $mcc_mnc | cut -b 1`
   second=`echo $mcc_mnc | cut -b 2`
   third=`echo $mcc_mnc | cut -b 3`
   fourth=`echo $mcc_mnc | cut -b 4`
   fifth=`echo $mcc_mnc | cut -b 5`
   
   hex_mcc_mnc="$second${first}F$third$fifth$fourth"
   echo $hex_mcc_mnc
}

runBatchCPAIECUsageTypeTest () {

    MSISDN=$1
    TIME=$2
    CPAAmount=$3
    cpaServiceType=$4


   if [ "$CPAAmount" == "" ] ; then
      CPAAmount="1"
   fi
   
   scenario_file=./usage_files/CPAIECUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/SERVICE_TYPE/$cpaServiceType/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file}_tmp3 > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
   
}

runCPAECURCommitUsageTypeTest () {
    MSISDN=$1
    TIME=$2
    CPAAmount=$3
    cpaServiceType=$4

   if [ "$CPAAmount" == "" ] ; then
      CPAAmount="1"
   fi

   scenario_file=./usage_files/CPAECURCommitUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/SERVICE_TYPE/$cpaServiceType/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file}_tmp3 > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
   
}

runCPAECURCancelUsageTypeTest () {
    MSISDN=$1
    TIME=$2
    CPAAmount=$3
    cpaServiceType=$4

   if [ "$CPAAmount" == "" ] ; then
      CPAAmount="1"
   fi

   scenario_file=./usage_files/CPAECURCommitUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/SERVICE_TYPE/$cpaServiceType/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file}_tmp3 > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
   
}

runBatchLocalMMSTest () {
   echo "CALLED_NUMBER is 6011111"
   
   MSISDN=$1
	TIME=$2
   
   scenario_file=./usage_files/mmsLocalUsage.xml
   sed "s/TIMESTAMP/$TIME/" $scenario_file > ${scenario_file}_tmp
   sed "s/MSISDN/$MSISDN/" ${scenario_file}_tmp > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchIDDMMSTest () {

   MSISDN=$1
	TIME=$2
	iddMMSDestination=$3

   if [ "$iddMMSDestination" == "" ] ; then
      iddMMSDestination="611234567"
   fi
   
   scenario_file=./usage_files/mmsIDDUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DESTINATION/$iddMMSDestination/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchRoamingMMSTest () {
   
   MSISDN=$1
	TIME=$2
	roamingMMSDestination=$3
	mcc_mnc=$4
   
   location_info=""
   hex_convert mcc_mnc 
   
   if [ "$roamingMMSDestination" == "" ] ; then
      roamingMMSDestination="611234567"
   fi
   
   scenario_file=./usage_files/mmsRoamingUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/LOCATION_INFO/${hex_mcc_mnc}/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/DESTINATION/$roamingMMSDestination/" ${scenario_file}_tmp3 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalSMSTest () {
   echo "CALLED_NUMBER is 6011111"
   
   	MSISDN=$1
	TIME=$2
   
   scenario_file=./usage_files/smsLocaUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchIDDSMSTest () {
  
   	MSISDN=$1
	TIME=$2
	iddSMSDestination=$3

   if [ "$iddSMSDestination" == "" ] ; then
      iddSMSDestination="611234567"
   fi
   
   scenario_file=./usage_files/smsIDDUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DESTINATION/$iddSMSDestination/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchRoamingSMSTest () {
   
   	MSISDN=$1
	TIME=$2
	roamingSMSDestination=$3
	mcc_mnc=$4

   hex_convert mcc_mnc 
   
   if [ "$roamingSMSDestination" == "" ] ; then
      roamingSMSDestination="611234567"
   fi
   
   scenario_file=./usage_files/smsRoamingUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/CELL_ID/${hex_mcc_mnc}/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/DESTINATION/$roamingSMSDestination/" ${scenario_file}_tmp3 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalDataTest () {
   
	MSISDN=$1
	TIME=$2
	ratingGroup=$3
	volume_used=$4
	mcc_mnc=$5
   
   if [ "$volume_used" == "" ] ; then
      volume_used="1024000"
   fi
   
   if [ "$ratingGroup" == "" ] ; then
      ratingGroup="400070001"
   fi
   
   if [ "$mcc_mnc" == "" ] ; then
      mcc_mnc="50216"
   fi
   
   scenario_file=./usage_files/dataLocalUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/RATING_GROUP/${ratingGroup}/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/TOTAL_VOLUME/${volume_used}/" ${scenario_file}_tmp3 > ${scenario_file}_tmp4
   sed "s/MCCMNC/$mcc_mnc/" ${scenario_file}_tmp4 > ${scenario_file}_new
      
   ./run.sh ${scenario_file}_new
   
}

runBatchRoamingDataTest () {
   
	MSISDN=$1
	TIME=$2
	ratingGroup=$3
	volume_used=$4
	mcc_mnc=$5
	
   if [ "$ratingGroup" == "" ] ; then
      ratingGroup="400050001"
   fi
   
   if [ "$volume_used" == "" ] ; then
      volume_used="1024000"
   fi
   
   scenario_file=./usage_files/dataRoamingUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/RATING_GROUP/${ratingGroup}/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/TOTAL_VOLUME/${volume_used}/" ${scenario_file}_tmp3 > ${scenario_file}_tmp4
   sed "s/MCCMNC/$mcc_mnc/" ${scenario_file}_tmp4 > ${scenario_file}_new
      
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalOnNetVoiceTest () {
   echo "CALLED_NUMBER is 6011111"
	MSISDN=$1
	TIME=$2
	onNetDuration=$3

   if [ "$onNetDuration" == "" ] ; then
      onNetDuration=300
   fi
   
   scenario_file=./usage_files/voiceLocaOnNetlUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DURATION/$onNetDuration/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalOffNetVoiceTest () {
   echo "CALLED_NUMBER is 6011111"
	MSISDN=$1
	TIME=$2
	offNetDuration=$3

   if [ "$offNetDuration" == "" ] ; then
      offNetDuration=300
   fi
   
   scenario_file=./usage_files/voiceLocaOffNetlUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DURATION/$offNetDuration/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchIDDVoiceTest () {
   	MSISDN=$1
	TIME=$2
	iddDuration=$3
	iddDestination=$4
   
   if [ "$iddDuration" == "" ] ; then
      iddDuration=300
   fi
   
   if [ "$iddDestination" == "" ] ; then
      iddDestination="611234567"
   fi
   
   scenario_file=./usage_files/voiceIDDUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DURATION/$iddDuration/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/DESTINATION/$iddDestination/" ${scenario_file}_tmp3 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchRoamingVoiceTest () {
	MSISDN=$1
	TIME=$2
	roamingDuration=$3
	roamingDestination=$4
	roamingVLRid=$5
	

	if [ "$roamingDuration" == "" ] ; then
      roamingDuration="300"
   fi
   
   if [ "$roamingDestination" == "" ] ; then
      roamingDestination="601234567"
   fi
   
   if [ "$roamingVLRid" == "" ] ; then
      roamingVLRid="611234567"
   fi
   
   scenario_file=./usage_files/voiceRoamingUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DURATION/$iddDuration/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/VLR_ID/$roamingVLRid/" ${scenario_file}_tmp3 > ${scenario_file}_tmp4
   sed "s/DESTINATION/$iddDestination/" ${scenario_file}_tmp4 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

for line in `cat batch_usage |grep -v "^#" |grep -v "^ "`
do
	test_scenario=`echo $line | awk -F"," '{print $1}'`
	
	case "$test_scenario" in
		"VoiceOnNet") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			runBatchLocalOffNetVoiceTest $A1 $A2 $A3
			;;
		"VoiceOffNet") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			runBatchLocalOffNetVoiceTest $A1 $A2 $A3
			;;
		"VoiceIDD") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			runBatchIDDVoiceTest $A1 $A2 $A3 $A4
			;;
		"VoiceRoam") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			A6=`echo $line | awk -F"," '{print $6}'`
			runBatchRoamingVoiceTest $A1 $A2 $A3 $A4 $A5
			;;
		"DataLocal") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			A5=`echo $line | awk -F"," '{print $6}'`
			runBatchLocalDataTest $A1 $A2 $A3 $A4 $A5
			;;
		"DataRoaming") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			A5=`echo $line | awk -F"," '{print $6}'`
			runBatchRoamingDataTest $A1 $A2 $A3 $A4 $A5
			;;
		"SMSLocal") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			runBatchLocalSMSTest $A1 $A2
			;;
		"SMSIDD") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			runBatchIDDSMSTest $A1 $A2 $A3
			;;
		"SMSRoam") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			runBatchRoamingSMSTest $A1 $A2 $A3 $A4
			;;
		"MMSLocal") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			runBatchLocalMMSTest $A1 $A2
			;;
		"MMSIDD") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			runBatchIDDMMSTest $A1 $A2 $A3
			;;
		"MMSRoam") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			runBatchRoamingMMSTest $A1 $A2 $A3 $A4
			;;
		"CPAIEC") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			runBatchCPAIECUsageTypeTest $A1 $A2 $A3 $A4
			;;
		"CPAECURCommit") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			runCPAECURCommitUsageTypeTest $A1 $A2 $A3 $A4
			;;
		"CPAECURCancel") A1=`echo $line | awk -F"," '{print $2}'`
			A2=`echo $line | awk -F"," '{print $3}'`
			A3=`echo $line | awk -F"," '{print $4}'`
			A4=`echo $line | awk -F"," '{print $5}'`
			runCPAECURCancelUsageTypeTest $A1 $A2 $A3 $A4
			;;
		 default) "echo Invalid option"
	        	 ;;
   	esac

done
