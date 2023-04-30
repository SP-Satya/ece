BKP_DIR=D:/digi-repo/tab-digi-cn-ece/development/bkp/
GIT_DIR=D:/digi-repo/tab-digi-cn-ece/development/
if [ $# -ne 1 ] ; then
	echo Usage $0 backup_folder
else
	cd  $BKP_DIR
        bkp_folder=$1	
	if [ ! -e $bkp_folder ] ; then
		mkdir $bkp_folder
	fi
	
	echo taking backup
	
	cp $GIT_DIR/oceceserver/config/management/diameter_mediation.spec ./$bkp_folder/
	cp $GIT_DIR/oceceserver/config/diameter/dictionary_main.xml  ./$bkp_folder/
	
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiDiameterGyExtension.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiExtensionsDataLoader.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPostChargingExtension.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPostRatingExtension.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPostUpdateExtension.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/TelenorDigiPreRatingExtension.java ./$bkp_folder/
	
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CDRGeneratorForContent.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CDRGeneratorForData.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CDRGeneratorForGSM.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CommonService.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/CustomCDRGeneratorPluginJdbc.java ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/ServiceCDR.java ./$bkp_folder/
	
	cp $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/special_numbers.spec  ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/vlr_addresses.spec  ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/special_numbers.csv  ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/vlr_addresses.csv  ./$bkp_folder/
	
	cp $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/tab_environment.sh  ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/tab_launcher.sh  ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/TelenorDigiExtensionsDataLoader.sh  ./$bkp_folder/
	cp $GIT_DIR/oceceserver/bin/ExtensionCompile.sh ./$bkp_folder/
		
	cp $GIT_DIR/ocecesdk/ECEExtensions/lib/ece.extensions.jar   ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/lib/ece-extensions.jar  ./$bkp_folder/
	cp $GIT_DIR/ocecesdk/ECEExtensions/lib/custom_cdr_plugin.jar  ./$bkp_folder/

fi
