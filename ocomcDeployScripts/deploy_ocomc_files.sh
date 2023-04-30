#!/bin/sh

SOURCE_DIR=$1
ADMIN_SERVER_POD=$2


if [ "$SOURCE_DIR" == "" ] ; then
	echo "missing input SOURCE_DIR"
	exit
elif [ ! "$ADMIN_SERVER_POD" =~ "admin-server-app" ] ; then
	echo "missing ADMIN_SERVER_POD input"
	exit
fi

echo oc cp $SOURCE_DIR/customization/rules/Wireless/OI/OCECE/NM_Voice_ECEDC.npl $ADMIN_SERVER_POD:/tmp/NM_Voice_ECEDC.npl
echo oc cp $SOURCE_DIR/customization/rules/Wireless/OI/OCECE/NM_SMS_ECEDC.npl $ADMIN_SERVER_POD:/tmp/NM_SMS_ECEDC.npl
echo oc cp $SOURCE_DIR/customization/rules/Wireless/OI/OCECE/OC3C_ECEDC.npl $ADMIN_SERVER_POD:/tmp/OC3C_ECEDC.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/Processor/Recycle/Recycle_EP.npl $ADMIN_SERVER_POD:/tmp/Recycle_EP.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/Processor/NPL/OC3C_Formatter.npl $ADMIN_SERVER_POD:/tmp/OC3C_Formatter.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/Processor/NPL/NM_Voice_EP.npl $ADMIN_SERVER_POD:/tmp/NM_Voice_EP.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/Processor/NPL/NM_SMS_EP.npl $ADMIN_SERVER_POD:/tmp/NM_SMS_EP.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/EI/RecycleAQ/RecycleAQCC.npl $ADMIN_SERVER_POD:/tmp/RecycleAQCC.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/EI/FlatFileEI/NM_Voice_CC.npl $ADMIN_SERVER_POD:/tmp/NM_Voice_CC.npl_1
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/EI/NAR/Suspended_NAR_CC.npl $ADMIN_SERVER_POD:/tmp/Suspended_NAR_CC.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/EI/FileEI/OC3C_CC.npl $ADMIN_SERVER_POD:/tmp/OC3C_CC.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/EI/FileEI/NM_Voice_CC.npl $ADMIN_SERVER_POD:/tmp/NM_Voice_CC.npl_2
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/EI/FileEI/NM_SMS_CC.npl $ADMIN_SERVER_POD:/tmp/NM_SMS_CC.npl
echo oc cp $SOURCE_DIR/customization/rules/CartridgeKit/OI/Suspense/Suspense_DC.npl $ADMIN_SERVER_POD:/tmp/Suspense_DC.npl
echo oc cp $SOURCE_DIR/bin/tools/export.nmx  $ADMIN_SERVER_POD:/tmp/export_$SOURCE_DIR.nmx
echo oc cp $SOURCE_DIR/bin/tools/export.xml  $ADMIN_SERVER_POD:/tmp/export_$SOURCE_DIR.xml
echo oc cp $SOURCE_DIR/3rdparty_jars/ojdbc8.jar  $ADMIN_SERVER_POD:/tmp/ojdbc8.jar
echo oc cp $SOURCE_DIR/web/htdocs/sql/RecycleHeader.sql $ADMIN_SERVER_POD:/tmp/RecycleHeader.sql
echo oc cp $SOURCE_DIR/web/htdocs/sql/RecycleDetail.sql $ADMIN_SERVER_POD:/tmp/RecycleDetail.sql
