#!/bin/sh

OCOMC_HOME="/scratch/ri-user-1/opt/OracleCommunications/ocomc/ocomc"
BACKUP_DIR="$OCOMC_HOME/delivery/$1"


if [ ! -d $BACKUP_DIR ] ; then
	mkdir $BACKUP_DIR
fi


mkdir -p $BACKUP_DIR/3rdparty_jars/
mkdir -p $BACKUP_DIR/bin/tools/
mkdir -p $BACKUP_DIR/customization/rules/Wireless/OI/OCECE/
mkdir -p $BACKUP_DIR/customization/rules/CartridgeKit/Processor/Recycle/
mkdir -p $BACKUP_DIR/customization/rules/CartridgeKit/Processor/NPL/
mkdir -p $BACKUP_DIR/customization/rules/CartridgeKit/EI/RecycleAQ/
mkdir -p $BACKUP_DIR/customization/rules/CartridgeKit/EI/FlatFileEI/
mkdir -p $BACKUP_DIR/customization/rules/CartridgeKit/EI/NAR/
mkdir -p $BACKUP_DIR/customization/rules/CartridgeKit/EI/FileEI/
mkdir -p $BACKUP_DIR/customization/rules/CartridgeKit/OI/Suspense/
mkdir -p $BACKUP_DIR/web/htdocs/sql/

cp $OCOMC_HOME/3rdparty_jars/ojdbc8.jar $BACKUP_DIR/3rdparty_jars/
cp $OCOMC_HOME/bin/tools/export.xml $BACKUP_DIR/bin/tools/
cp $OCOMC_HOME/bin/tools/export.nmx $BACKUP_DIR/bin/tools/
cp $OCOMC_HOME/customization/rules/Wireless/OI/OCECE/NM_Voice_ECEDC.npl $BACKUP_DIR/customization/rules/Wireless/OI/OCECE/
cp $OCOMC_HOME/customization/rules/Wireless/OI/OCECE/NM_SMS_ECEDC.npl $BACKUP_DIR/customization/rules/Wireless/OI/OCECE/
cp $OCOMC_HOME/customization/rules/Wireless/OI/OCECE/OC3C_ECEDC.npl $BACKUP_DIR/customization/rules/Wireless/OI/OCECE/
cp $OCOMC_HOME/customization/rules/CartridgeKit/Processor/Recycle/Recycle_EP.npl $BACKUP_DIR/customization/rules/CartridgeKit/Processor/Recycle/
cp $OCOMC_HOME/customization/rules/CartridgeKit/Processor/NPL/OC3C_Formatter.npl $BACKUP_DIR/customization/rules/CartridgeKit/Processor/NPL/
cp $OCOMC_HOME/customization/rules/CartridgeKit/Processor/NPL/NM_Voice_EP.npl $BACKUP_DIR/customization/rules/CartridgeKit/Processor/NPL/
cp $OCOMC_HOME/customization/rules/CartridgeKit/Processor/NPL/NM_SMS_EP.npl $BACKUP_DIR/customization/rules/CartridgeKit/Processor/NPL/
cp $OCOMC_HOME/customization/rules/CartridgeKit/EI/RecycleAQ/RecycleAQCC.npl $BACKUP_DIR/customization/rules/CartridgeKit/EI/RecycleAQ/
cp $OCOMC_HOME/customization/rules/CartridgeKit/EI/FlatFileEI/NM_Voice_CC.npl $BACKUP_DIR/customization/rules/CartridgeKit/EI/FlatFileEI/
cp $OCOMC_HOME/customization/rules/CartridgeKit/EI/NAR/Suspended_NAR_CC.npl $BACKUP_DIR/customization/rules/CartridgeKit/EI/NAR/
cp $OCOMC_HOME/customization/rules/CartridgeKit/EI/FileEI/OC3C_CC.npl $BACKUP_DIR/customization/rules/CartridgeKit/EI/FileEI/
cp $OCOMC_HOME/customization/rules/CartridgeKit/EI/FileEI/NM_Voice_CC.npl $BACKUP_DIR/customization/rules/CartridgeKit/EI/FileEI/
cp $OCOMC_HOME/customization/rules/CartridgeKit/EI/FileEI/NM_SMS_CC.npl $BACKUP_DIR/customization/rules/CartridgeKit/EI/FileEI/
cp $OCOMC_HOME/customization/rules/CartridgeKit/OI/Suspense/Suspense_DC.npl $BACKUP_DIR/customization/rules/CartridgeKit/OI/Suspense/
cp $OCOMC_HOME/web/htdocs/sql/RecycleHeader.sql $BACKUP_DIR/web/htdocs/sql/
cp $OCOMC_HOME/web/htdocs/sql/RecycleDetail.sql $BACKUP_DIR/web/htdocs/sql/

count=`find $BACKUP_DIR -type f | wc -l`
echo "Total files backed up = $count"

tar -cvf $1.tar $BACKUP_DIR
