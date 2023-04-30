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

getEventTime() {
	epochTime=`date +%s`
	echo "$epochTime"
	let eventTime=$epochTime+2208988500
	echo "$eventTime"
}

runBatchCPAIECUsageTypeTest () {

    MSISDN=$1
    TIME=$2
    CPAAmount=$3
    cpaServiceType=$4


   if [ "$CPAAmount" == "" ] ; then
      CPAAmount="100"
   fi
   
   scenario_file=./usage_files/CPAIECUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/SERVICE_TYPE/$cpaServiceType/" \
       -e "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file} > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
   
}

runCPAECURCommitUsageTypeTest () {
   MSISDN=$1
   TIME=$2
   CPAAmount=$3
   cpaServiceType=$4
   let endTime=$TIME+600

   if [ "$CPAAmount" == "" ] ; then
      CPAAmount="100"
   fi

   scenario_file=./usage_files/CPAECURCommitUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/SERVICE_TYPE/$cpaServiceType/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file} > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
   
}

runCPAECURCancelUsageTypeTest () {
   MSISDN=$1
   TIME=$2
   CPAAmount=$3
   cpaServiceType=$4
   let endTime=$TIME+3600

   if [ "$CPAAmount" == "" ] ; then
      CPAAmount="100"
   fi

   scenario_file=./usage_files/CPAECURCancelUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/SERVICE_TYPE/$cpaServiceType/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file} > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
   
}

runCPARefundTypeTest () {
    MSISDN=$1
    TIME=$2
    Messsage_Id=$3
    CPAAmount=$4

   if [ "$CPAAmount" == "" ] ; then
      CPAAmount="1"
   fi

   scenario_file=./usage_files/CPARefundUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/OLD_MESSAGE_ID/$Messsage_Id/" \
       -e "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file} > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
   
}

runBatchLocalMMSTest () {
   echo "CALLED_NUMBER is 6011111"
   
   MSISDN=$1
   TIME=$2
   
   scenario_file=./usage_files/mmsLocalUsage.xml
   sed -e "s/TIMESTAMP/$TIME/" \
       -e "s/MSISDN/$MSISDN/" ${scenario_file} > ${scenario_file}_new
   
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
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/DESTINATION/$iddMMSDestination/" ${scenario_file} > ${scenario_file}_new
   
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
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/LOCATION_INFO/${hex_mcc_mnc}/" \
       -e "s/DESTINATION/$roamingMMSDestination/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalSMSTest () {
   echo "CALLED_NUMBER is 6011111"
   
   MSISDN=$1
   TIME=$2
   
   scenario_file=./usage_files/smsLocaUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" ${scenario_file} > ${scenario_file}_new
   
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
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/DESTINATION/$iddSMSDestination/" ${scenario_file} > ${scenario_file}_new
   
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
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/CELL_ID/${hex_mcc_mnc}/" \
       -e "s/DESTINATION/$roamingSMSDestination/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalDataTest () {
   
   MSISDN=$1
   TIME=$2
   ratingGroup=$3
   volume_used=$4
   mcc_mnc=$5
   let endTime=$TIME+3000
   
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
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/RATING_GROUP/${ratingGroup}/" \
       -e "s/TOTAL_VOLUME/${volume_used}/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/MCCMNC/$mcc_mnc/" ${scenario_file} > ${scenario_file}_new
      
   ./run.sh ${scenario_file}_new
   
}


runBatchMidSessionDataLocalTest () {
   
   MSISDN=$1
   TIME_INITIATE=$2
   let TIME_UPDATE1=$2+86400
   let TIME_UPDATE2=$2+86400+86400
   let TIME_TERMINATE=$2+86400+86400+86400
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
   
   scenario_file=./usage_files/MidSessionDataLocalUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP_INITIATE/$TIME_INITIATE/" \
       -e "s/TIMESTAMP_UPDATE1/$TIME_UPDATE1/" \
       -e "s/TIMESTAMP_UPDATE2/$TIME_UPDATE2/" \
       -e "s/TIMESTAMP_TERMINATE/$TIME_TERMINATE/" \
       -e "s/RATING_GROUP/${ratingGroup}/" \
       -e "s/TOTAL_VOLUME/${volume_used}/" \
       -e "s/MCCMNC/$mcc_mnc/" ${scenario_file} > ${scenario_file}_new
      
   ./run.sh ${scenario_file}_new
   
}

runBatchRoamingDataTest () {
   
   MSISDN=$1
   TIME=$2
   ratingGroup=$3
   volume_used=$4
   mcc_mnc=$5
   let endTime=$TIME+3000
   hex_convert mcc_mnc 
   
   if [ "$ratingGroup" == "" ] ; then
      ratingGroup="400050001"
   fi
   
   if [ "$volume_used" == "" ] ; then
      volume_used="1024000"
   fi
   
   scenario_file=./usage_files/dataRoamingUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/RATING_GROUP/${ratingGroup}/" \
       -e "s/TOTAL_VOLUME/${volume_used}/" \
       -e "s/LOCATION_INFO/${hex_mcc_mnc}/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/MCCMNC/$mcc_mnc/" ${scenario_file} > ${scenario_file}_new
      
   ./run.sh ${scenario_file}_new
   
}

runSLR () {
   MSISDN=$1
   TIME=$2

   scenario_file=./usage_files/slr-sla.xml
   sed -e "s/MSISDN/$MSISDN/" ${scenario_file} > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
}

runSTR () {
   SESSION_ID=$1

   scenario_file=./usage_files/str.xml
   sed -e "s/SESSION_ID/$SESSION_ID/" ${scenario_file} > ${scenario_file}_new

   ./run.sh ${scenario_file}_new
}

runBatchLocalOnNetVoiceTest () {
   echo "CALLED_NUMBER is 6011111"
   MSISDN=$1
   TIME=$2
   onNetDuration=$3
   callType=$4
   let endTime=$TIME+$onNetDuration

   if [ "$onNetDuration" == "" ] ; then
      onNetDuration=300
   fi
   
   scenario_file=./usage_files/voiceLocaOnNetlUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/CALLTYPE/$callType/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/DURATION/$onNetDuration/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalOffNetVoiceTest () {
   echo "CALLED_NUMBER is 6011111"
   MSISDN=$1
   TIME=$2
   offNetDuration=$3
   callType=$4
   let endTime=$TIME+$offNetDuration

   if [ "$offNetDuration" == "" ] ; then
      offNetDuration=300
   fi
   
   scenario_file=./usage_files/voiceLocaOffNetlUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/CALLTYPE/$callType/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/DURATION/$offNetDuration/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchIDDVoiceTest () {
   MSISDN=$1
   TIME=$2
   iddDuration=$3
   iddDestination=$4
   callType=$5
   let endTime=$TIME+$iddDuration
   
   if [ "$iddDuration" == "" ] ; then
      iddDuration=300
   fi
   
   if [ "$iddDestination" == "" ] ; then
      iddDestination="611234567"
   fi
   
   scenario_file=./usage_files/voiceIDDUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/DURATION/$iddDuration/" \
       -e "s/CALLTYPE/$callType/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/DESTINATION/$iddDestination/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchRoamingVoiceTest () {
   MSISDN=$1
   TIME=$2
   roamingDuration=$3
   roamingDestination=$4
   roamingVLRid=$5
   callType=$6
   let endTime=$TIME+$roamingDuration
   

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
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/DURATION/$roamingDuration/" \
       -e "s/VLR_ID/$roamingVLRid/" \
       -e "s/CALLTYPE/$callType/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/DESTINATION/$roamingDestination/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchSpecialNumberTest () {
   MSISDN=$1
   TIME=$2
   duration=$3
   specialNumber=$4
   let endTime=$TIME+$duration
   
   if [ "$iddDuration" == "" ] ; then
      iddDuration=300
   fi
   
   if [ "$specialNumber" == "" ] ; then
      iddDestination="60100"
   fi
   
   scenario_file=./usage_files/specialNumber.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/DURATION/$duration/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/DESTINATION/$specialNumber/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

runBatchLocalOnNetImsTest () {
   echo "CALLED_NUMBER is 6011111"
   MSISDN=$1
   TIME=$2
   onNetDuration=$3
   callType=$4
   let endTime=$TIME+$onNetDuration

   if [ "$onNetDuration" == "" ] ; then
      onNetDuration=300
   fi
   
   scenario_file=./usage_files/imsLocaOnNetlUsage.xml
   sed -e "s/MSISDN/$MSISDN/" \
       -e "s/TIMESTAMP/$TIME/" \
       -e "s/CALLTYPE/$callType/" \
       -e "s/ENDTIME/$endTime/" \
       -e "s/DURATION/$onNetDuration/" ${scenario_file} > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

input_file=$1

if [ "$input_file" == "" ] ; then
   input_file=usage_batch
fi

for line in `cat "$input_file" |grep -v "^#" |grep -v "^ "`
do
   test_scenario=`echo $line | awk -F"," '{print $1}'`
   A1=`echo $line | awk -F"," '{print $2}'`
   A2=`echo $line | awk -F"," '{print $3}'`
#   if [ "$A2" == "" ] ;then
#      getEventTime
#      A2=$eventTime
#   fi
   
   case "$test_scenario" in
      "VoiceOnNet") 
         A3=`echo $line | awk -F"," '{print $4}'`
         runBatchLocalOnNetVoiceTest $A1 $A2 $A3 0
         ;;
      "VoiceOffNet") 
         A3=`echo $line | awk -F"," '{print $4}'`
         runBatchLocalOffNetVoiceTest $A1 $A2 $A3 0
         ;;
      "VoiceIDD") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runBatchIDDVoiceTest $A1 $A2 $A3 $A4 0
         ;;
      "VoiceRoam") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         A5=`echo $line | awk -F"," '{print $6}'`
         runBatchRoamingVoiceTest $A1 $A2 $A3 $A4 $A5 0
         ;;
      "SpecialNumber") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runBatchSpecialNumberTest $A1 $A2 $A3 $A4
         ;;
      "VideoOnNet") 
         A3=`echo $line | awk -F"," '{print $4}'`
         runBatchLocalOnNetVoiceTest $A1 $A2 $A3 8
         ;;
      "VideoOffNet") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=Video
         runBatchLocalOffNetVoiceTest $A1 $A2 $A3 8
         ;;
      "VideoIDD") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         A5=Video
         runBatchIDDVoiceTest $A1 $A2 $A3 $A4 8
         ;;
      # Invalid scenario for Digi
      #"VideoRoam") A1=`echo $line | awk -F"," '{print $2}'`
      #   A2=`echo $line | awk -F"," '{print $3}'`
      #   A3=`echo $line | awk -F"," '{print $4}'`
      #   A4=`echo $line | awk -F"," '{print $5}'`
      #   A5=`echo $line | awk -F"," '{print $6}'`
      #   A6=Video
      #   runBatchRoamingVoiceTest $A1 $A2 $A3 $A4 $A5 8
      #   ;;
      "DataLocal") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         A5=`echo $line | awk -F"," '{print $6}'`
         runBatchLocalDataTest $A1 $A2 $A3 $A4 $A5
         ;;
      "MidSessionDataLocal") A1=`echo $line | awk -F"," '{print $2}'`
         A2=`echo $line | awk -F"," '{print $3}'`
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         A5=`echo $line | awk -F"," '{print $6}'`
         runBatchMidSessionDataLocalTest $A1 $A2 $A3 $A4 $A5
         ;;
      "DataRoaming") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         A5=`echo $line | awk -F"," '{print $6}'`
         runBatchRoamingDataTest $A1 $A2 $A3 $A4 $A5
         ;;
      "SMSLocal") 
         runBatchLocalSMSTest $A1 $A2
         ;;
      "SMSIDD") 
         A3=`echo $line | awk -F"," '{print $4}'`
         runBatchIDDSMSTest $A1 $A2 $A3
         ;;
      "SMSRoam") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runBatchRoamingSMSTest $A1 $A2 $A3 $A4
         ;;
      "MMSLocal") 
         runBatchLocalMMSTest $A1 $A2
         ;;
      "MMSIDD") 
         A3=`echo $line | awk -F"," '{print $4}'`
         runBatchIDDMMSTest $A1 $A2 $A3
         ;;
      "MMSRoam") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runBatchRoamingMMSTest $A1 $A2 $A3 $A4
         ;;
      "CPAIEC") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runBatchCPAIECUsageTypeTest $A1 $A2 $A3 $A4
         ;;
      "CPAECURCommit") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runCPAECURCommitUsageTypeTest $A1 $A2 $A3 $A4
         ;;
      "CPAECURCancel") 
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runCPAECURCancelUsageTypeTest $A1 $A2 $A3 $A4
         ;;
      "CPARefund")
         A3=`echo $line | awk -F"," '{print $4}'`
         A4=`echo $line | awk -F"," '{print $5}'`
         runCPARefundTypeTest $A1 $A2 $A3 $A4
         ;;
      "SLR")
         runSLR $A1 $A2
         ;;
      "STR")
         runSTR $A1
         ;;
      "ImsOnNet") 
         A3=`echo $line | awk -F"," '{print $4}'`
         runBatchLocalOnNetImsTest $A1 $A2 $A3 0
         ;;
         
       default) echo "Invalid Digi Rating scenario"
               ;;
      esac

done
