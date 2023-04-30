#!/bin/sh


GIT_PATH="D:/Digi-repo/tab-digi-cn-ocomc/development/custom"
SOURCE_PATH="D:/Digi-repo/tab-digi-cn-ocomc/development/custom/bkp/$1"


cksum $SOURCE_PATH/3rdparty_jars/ojdbc8.jar $GIT_PATH/3rdPartyJars/ojdbc8.jar
cksum $SOURCE_PATH/bin/tools/export.xml $GIT_PATH/NodechainExport/export.xml
cksum $SOURCE_PATH/bin/tools/export.nmx $GIT_PATH/NodechainExport/export.nmx
cksum $SOURCE_PATH/customization/rules/Wireless/OI/OCECE/NM_Voice_ECEDC.npl $GIT_PATH/cartridges/NM_Voice_ECEDC.npl
cksum $SOURCE_PATH/customization/rules/Wireless/OI/OCECE/NM_SMS_ECEDC.npl $GIT_PATH/cartridges/NM_SMS_ECEDC.npl
cksum $SOURCE_PATH/customization/rules/Wireless/OI/OCECE/OC3C_ECEDC.npl $GIT_PATH/cartridges/OC3C_ECEDC.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/Processor/Recycle/Recycle_EP.npl $GIT_PATH/cartridges/Recycle_EP.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/Processor/NPL/OC3C_Formatter.npl $GIT_PATH/cartridges/OC3C_Formatter.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/Processor/NPL/NM_Voice_EP.npl $GIT_PATH/cartridges/NM_Voice_EP.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/Processor/NPL/NM_SMS_EP.npl $GIT_PATH/cartridges/NM_SMS_EP.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/EI/RecycleAQ/RecycleAQCC.npl $GIT_PATH/cartridges/RecycleAQCC.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/EI/FlatFileEI/NM_Voice_CC.npl $GIT_PATH/cartridges/FlatFileEI/NM_Voice_CC.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/EI/NAR/Suspended_NAR_CC.npl $GIT_PATH/cartridges/Suspended_NAR_CC.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/EI/FileEI/OC3C_CC.npl $GIT_PATH/cartridges/OC3C_CC.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/EI/FileEI/NM_Voice_CC.npl $GIT_PATH/cartridges/FileEI/NM_Voice_CC.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/EI/FileEI/NM_SMS_CC.npl $GIT_PATH/cartridges/NM_SMS_CC.npl
cksum $SOURCE_PATH/customization/rules/CartridgeKit/OI/Suspense/Suspense_DC.npl $GIT_PATH/cartridges/Suspense_DC.npl
cksum $SOURCE_PATH/web/htdocs/sql/RecycleHeader.sql $GIT_PATH/sql/RecycleHeader.sql
cksum $SOURCE_PATH/web/htdocs/sql/RecycleDetail.sql $GIT_PATH/sql/RecycleDetail.sql
