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

getCPAIECUsageType () {
   echo "Please select the CPA usage details"
         MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "Please select the CPA usage amount"
   CPAAmount=0
   while [ "$CPAAmount" -eq 0 ]
   do
      echo "Please Enter Amount"
      read CPAAmount
   done
   
   echo "please provide Service Type, defualt CPA08_InsNonGST"
   read cpaServiceType
   if [ "$cpaServiceType" == "" ] ; then
      cpaServiceType="CPA08_InsNonGST"
   fi
   
   scenario_file=./usage_files/CPAIECUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/SERVICE_TYPE/$cpaServiceType/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file}_tmp3 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getCPAECURCommitUsageType () {
   echo "Please select the CPA usage details"
         MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "Please select the CPA usage amount"
         CPAAmount=0
   while [ "$CPAAmount" -eq 0 ]
   do
      echo "Please Enter Amount"
      read CPAAmount
   done
   
   echo "please provide Service Type, defualt CPA08_InsNonGST"
   read cpaServiceType
   if [ "$cpaServiceType" == "" ] ; then
      cpaServiceType="CPA08_InsNonGST"
   fi
   
   scenario_file=./usage_files/CPAECURCommitUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/SERVICE_TYPE/$cpaServiceType/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file}_tmp3 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getCPAECURCancelUsageType () {
   echo "Please select the CPA usage details"
         MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "Please select the CPA usage amount"
         CPAAmount=0
   while [ "$CPAAmount" -eq 0 ]
   do
      echo "Please Enter Amount"
      read CPAAmount
   done
   
   scenario_file=./usage_files/CPAECURCancelUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/SERVICE_TYPE/$cpaServiceType/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/CPA_AMOUNT/$CPAAmount/" ${scenario_file}_tmp3 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getLocalMMSDetails () {
   echo "CALLED_NUMBER is 6011111"
   
   MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done

   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   echo "please provide Service Type, defualt CPA08_InsNonGST"
   read cpaServiceType
   if [ "$cpaServiceType" == "" ] ; then
      cpaServiceType="CPA08_InsNonGST"
   fi
   
   scenario_file=./usage_files/mmsLocalUsage.xml
   sed "s/TIMESTAMP/$TIME/" $scenario_file > ${scenario_file}_tmp
   sed "s/MSISDN/$MSISDN/" ${scenario_file}_tmp > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getIDDMMSDetails () {
   echo "CALLED_NUMBER is 6011111"
   
      MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   

   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "please provide Destination Number, defualt 611234567"
   read iddMMSDestination
   if [ "$iddMMSDestination" == "" ] ; then
      iddMMSDestination="611234567"
   fi
   
   scenario_file=./usage_files/mmsIDDUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DESTINATION/$iddMMSDestination/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getRoamingMMSDetails () {
   
         MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   mcc_mnc=""
   while [ "$mcc_mnc" == "" ]
   do
      echo "please provide MCC-MNC"
      read mcc_mnc
   done
   
   location_info=""
   hex_convert mcc_mnc 
   
   echo "please provide Destination Number, defualt 611234567"
   read roamingMMSDestination
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

getLocalSMSDetails () {
   echo "CALLED_NUMBER is 6011111"
   
   MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   scenario_file=./usage_files/smsLocaUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getIDDSMSDetails () {
   echo "CALLED_NUMBER is 6011111"
   
      MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   

   echo "please provide Destination Number, defualt 611234567"
   read iddSMSDestination
   if [ "$iddSMSDestination" == "" ] ; then
      iddSMSDestination="611234567"
   fi
   
   scenario_file=./usage_files/smsIDDUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DESTINATION/$iddSMSDestination/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getRoamingSMSDetails () {
   
         MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   mcc_mnc=""
   while [ "$mcc_mnc" == "" ]
   do
      echo "please provide MCC-MNC"
      read mcc_mnc
   done
   
   hex_convert mcc_mnc 
   
   echo "please provide Destination Number, defualt 611234567"
   read roamingSMSDestination
   if [ "$roamingSMSDestination" == "" ] ; then
      roamingSMSDestination="611234567"
   fi
   
   scenario_file=./usage_files/smsRoamingUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/CELL_ID/${hex_mcc_mnc}/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/DESTINATION/$roamingSMSDestination/" ${scenario_file}_tmpr3 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getLocalDataDetails () {
   
   MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "please provide MCCMNC, defualt 50216"
   read mcc_mnc
   if [ "$mcc_mnc" == "" ] ; then
      mcc_mnc="50216"
   fi
   
   echo "please provide Rating-Group, defualt  400070001"
   read ratingGroup
   if [ "$ratingGroup" == "" ] ; then
      ratingGroup="400070001"
   fi
   
   echo "please provide used volume, defualt  1024000"
   read volume_used
   if [ "$volume_used" == "" ] ; then
      volume_used="1024000"
   fi

   scenario_file=./usage_files/dataLocalUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/RATING_GROUP/${ratingGroup}/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/TOTAL_VOLUME/${volume_used}/" ${scenario_file}_tmp3 > ${scenario_file}_tmp4
   sed "s/MCCMNC/$mcc_mnc/" ${scenario_file}_tmp4 > ${scenario_file}_new
      
   ./run.sh ${scenario_file}_new
   
}

getRoamingDataDetails () {
   
   MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   mcc_mnc=""
   while [ "$mcc_mnc" == "" ]
   do
      echo "please provide MCC-MNC"
      read mcc_mnc
   done   
   
   echo "please provide Rating-Group, defualt  400050001"
   read ratingGroup
   if [ "$ratingGroup" == "" ] ; then
      ratingGroup="400050001"
   fi
   
   echo "please provide used volume, defualt  1024000"
   read volume_used
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

getLocalOnNetVoiceDetails () {
   echo "CALLED_NUMBER is 6011111"
   
      MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "please provide DURATION, defualt 300 Sec"
   read onNetDuration
   if [ "$onNetDuration" == "" ] ; then
      onNetDuration=300
   fi
   
   scenario_file=./usage_files/voiceLocaOnNetlUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DURATION/$onNetDuration/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getLocalOffNetVoiceDetails () {
   echo "CALLED_NUMBER is 6011111"
   
   MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "please provide DURATION, defualt 300 Sec"
   read offNetDuration
   if [ "$offNetDuration" == "" ] ; then
      offNetDuration=300
   fi
   
   scenario_file=./usage_files/voiceLocaOffNetlUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DURATION/$offNetDuration/" ${scenario_file}_tmp2 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getIDDVoiceDetails () {
   echo "CALLED_NUMBER is 6011111"
   
      MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   echo "please provide DURATION, defualt 300 Sec"
   read iddDuration
   if [ "$iddDuration" == "" ] ; then
      iddDuration=300
   fi
   
   echo "please provide Destination Number, defualt 611234567"
   read iddDestination
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

getRoamingVoiceDetails () {
   echo "please provide DURATION, defualt 300 Sec"
   read roamingDuration
   if [ "$roamingDuration" == "" ] ; then
      roamingDuration=300
   fi
   
         MSISDN=""
   while [ "$MSISDN" == "" ]
   do
      echo "Please Enter MSISDN"
      read MSISDN
   done
   
   TIME=""
   while [ "$TIME" == "" ]
   do
      echo "Please Enter Event-Timestamp"
      read TIME
   done

   
   roamingVLRid=""
   while [ "$roamingVLRid" == "" ]
   do
      echo "please provide Roaming VLR Id"
      read roamingVLRid
   done   
   
   echo "please provide Destination Number, defualt 611234567"
   read roamingDestination
   if [ "$roamingDestination" == "" ] ; then
      roamingDestination="611234567"
   fi
   
   scenario_file=./usage_files/voiceRoamingUsage.xml
   sed "s/MSISDN/$MSISDN/" $scenario_file > ${scenario_file}_tmp
   sed "s/TIMESTAMP/$TIME/" ${scenario_file}_tmp > ${scenario_file}_tmp2
   sed "s/DURATION/$iddDuration/" ${scenario_file}_tmp2 > ${scenario_file}_tmp3
   sed "s/VLR_ID/$roamingVLRid/" ${scenario_file}_tmp3 > ${scenario_file}_tmp4
   sed "s/DESTINATION/$iddDestination/" ${scenario_file}_tmp4 > ${scenario_file}_new
   
   ./run.sh ${scenario_file}_new
   
}

getVoiceUsageType () {

   echo "Please select the Voice usage_type"
   echo "1: OnNet,2: OffNet, 3: IDD, 4:Roaming"
   read optionVoiceUsageType
   case "$optionVoiceUsageType" in
      "1") getLocalOnNetVoiceDetails
         break;;
      "2") getLocalOffNetVoiceDetails
         break;;
      "3") getIDDVoiceDetails
         break;;
      "4") getRoamingVoiceDetails
         break;;
      default) "echo Invalid option"
         break;;
   esac
}

getDataUsageType () {
   echo "Please select the Data usage_type"
   echo "1: Local, 2: Roaming"
   read optionDataUsageType
   case "$optionDataUsageType" in
      "1") getLocalDataDetails
         break;;
      "2") getRoamingDataDetails
         break;;
      default) "echo Invalid option"
         break;;
   esac
}

getSMSUsageType () {
   echo "Please select the SMS usage_type"
   echo "1: Local, 2: IDD, 3:Roaming"
   read optionSMSUsageType
   case "$optionSMSUsageType" in
      "1") getLocalSMSDetails
         break;;
      "2") getIDDSMSDetails
         break;;
      "3") getRoamingSMSDetails
         break;;
      default) "echo Invalid option"
         break;;
   esac
}

getMMSUsageType () {
   echo "Please select the MMS usage_type"
   echo "1: Local, 2: IDD, 3:Roaming"
   read optionMMSUsageType
   case "$optionMMSUsageType" in
      "1") getLocalMMSDetails
         break;;
      "2") getIDDMMSDetails
         break;;
      "3") getRoamingMMSDetails
         break;;
      default) "echo Invalid option"
         break;;
   esac
}

getCPAUsageType () {
   echo "Please select the CPA usage_type"
   echo "1: IEC, 2: ECUR"
   read optionCPAUsageType
   case "$optionCPAUsageType" in
      "1") getCPAIECUsageType
         break;;
      "2") getCPAECURCommitUsageType
         break;;
      "3") getCPAECURCancelUsageType
         break;;
      default) "echo Invalid option"
         break;;
   esac
   
}

getUsageType () {
   echo "Please select the usage_type"
   echo "1. Voice, 2. Data, 3. SMS, 4.MMS, 5. CPA"
   read optionUsageType
   case "$optionUsageType" in
      "1") getVoiceUsageType
         break;;
      "2") getDataUsageType
         break;;
      "3") getSMSUsageType
         break;;
      "4") getMMSUsageType
         break;;
      "5") getCPAUsageType
         break;;
      default) "echo Invalid option"
         break;;
   esac
}


###################
# Main Subroutine
###################
getUsageType



