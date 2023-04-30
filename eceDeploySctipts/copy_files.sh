BKP_DIR=D:/digi-repo/tab-digi-cn-ece/development/bkp/
GIT_DIR=D:/digi-repo/tab-digi-cn-ece/development/

copy=

if [ $# -ne 1 ] ; then
	echo Usage $0 backup_folder
else
        bkp_folder=$1	
	cd  $BKP_DIR

	echo copying from backup
	
	if [ "$copy" == "full" ] ; then
		cp $bkp_folder/diameter_mediation.spec $GIT_DIR/oceceserver/config/management/diameter_mediation.spec 
		cp $bkp_folder/dictionary_main.xml $GIT_DIR/oceceserver/config/diameter/dictionary_main.xml  
				
		cp $bkp_folder/CDRGenerator*.java $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/
		cp $bkp_folder/CustomCDRGenerator*.java $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/
		cp $bkp_folder/ServiceCDR.java $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/
		cp $bkp_folder/CommonService.java $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/plugin/
			
		cp $bkp_folder/*.csv $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/
		cp $bkp_folder/*.spec $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/
		rm $GIT_DIR/ocecesdk/ECEExtensions/config/extentions/diameter_mediation.spec
		
		cp $bkp_folder/tab_environment.sh $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/tab_environment.sh  
		cp $bkp_folder/tab_launcher.sh $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/tab_launcher.sh  
		cp $bkp_folder/TelenorDigiExtensionsDataLoader.sh $GIT_DIR/ocecesdk/ECEExtensions/bin/extenstions/TelenorDigiExtensionsDataLoader.sh  
		cp $bkp_folder/ExtensionCompile.sh $GIT_DIR/oceceserver/bin/ExtensionCompile.sh 
		
	  
		cp $bkp_folder/ece-extensions.jar $GIT_DIR/ocecesdk/ECEExtensions/lib/ece-extensions.jar  
		cp $bkp_folder/custom_cdr_plugin.jar $GIT_DIR/ocecesdk/ECEExtensions/lib/custom_cdr_plugin.jar 
	fi
	
	cp $bkp_folder/Telenor*.java $GIT_DIR/ocecesdk/ECEExtensions/src/main/java/com/tab/ece/charging/extensions/
	cp $bkp_folder/ece.extensions.jar $GIT_DIR/ocecesdk/ECEExtensions/lib/ece.extensions.jar 
fi
