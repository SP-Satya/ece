BKP_DIR=D:/digi-repo/tab-digi-cn-ece/development/bkp/
GIT_DIR=D:/digi-repo/tab-digi-cn-ece/development/

compare=$2

if [ $# -lt 1 ] ; then
	echo Usage $0 backup_folder
else
	cd  $BKP_DIR
        bkp_folder=$1	
	if [ ! -e $bkp_folder ] ; then
		echo "$bkp_folder doesn't exist"
		exit
	fi
	
	if [ "$compare" == "full" ] ; then
		cksum $GIT_DIR/oceceserver/config/management/diameter_mediation.spec ./$bkp_folder/diameter_mediation.spec 
		cksum $GIT_DIR/oceceserver/config/diameter/dictionary_main.xml  ./$bkp_folder/dictionary_main.xml
		
		
		cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CDRGeneratorForContent.java ./$bkp_folder/CDRGeneratorForContent.java
		cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CDRGeneratorForData.java ./$bkp_folder/CDRGeneratorForData.java
		cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CDRGeneratorForGSM.java ./$bkp_folder/CDRGeneratorForGSM.java
		cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CommonService.java ./$bkp_folder/CommonService.java
		cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CustomCDRGeneratorPluginJdbc.java ./$bkp_folder/CustomCDRGeneratorPluginJdbc.java
		cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/ServiceCDR.java ./$bkp_folder/ServiceCDR.java
		
		cksum $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/special_numbers.spec  ./$bkp_folder/special_numbers.spec
		cksum $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/vlr_addresses.spec  ./$bkp_folder/vlr_addresses.spec
		cksum $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/special_numbers.csv  ./$bkp_folder/special_numbers.csv
		cksum $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/vlr_addresses.csv  ./$bkp_folder/vlr_addresses.csv
		
		cksum $GIT_DIR/ocecesdk/ECEExtensions/lib/ece-extensions.jar  ./$bkp_folder/ece-extensions.jar
		cksum $GIT_DIR/ocecesdk/ECEExtensions/lib/custom_cdr_plugin.jar  ./$bkp_folder/custom_cdr_plugin.jar
	
	fi

		cksum $GIT_DIR/oceceserver/config/management/diameter_mediation.spec ./$bkp_folder/diameter_mediation.spec 
	cksum $GIT_DIR/ocecesdk/ECEExtensions/lib/ece.extensions.jar   ./$bkp_folder/ece.extensions.jar 
	cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiDiameterGyExtension.java ./$bkp_folder/TelenorDigiDiameterGyExtension.java
	cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiExtensionsDataLoader.java ./$bkp_folder/TelenorDigiExtensionsDataLoader.java
	cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPostChargingExtension.java ./$bkp_folder/TelenorDigiPostChargingExtension.java
	cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPostRatingExtension.java ./$bkp_folder/TelenorDigiPostRatingExtension.java
	cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPostUpdateExtension.java ./$bkp_folder/TelenorDigiPostUpdateExtension.java
	cksum $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPreRatingExtension.java ./$bkp_folder/TelenorDigiPreRatingExtension.java


cksum $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/tab_environment.sh  ./$bkp_folder/tab_environment.sh
cksum $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/tab_launcher.sh  ./$bkp_folder/tab_launcher.sh
cksum $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/TelenorDigiExtensionsDataLoader.sh  ./$bkp_folder/TelenorDigiExtensionsDataLoader.sh
cksum $GIT_DIR/oceceserver/bin/ExtensionCompile.sh ./$bkp_folder/ExtensionCompile.sh

fi
