#!/usr/bin/env bash

appName=$1
appChineseName=$2
baiduAppKey=$3

#资源签名三方参数设置文件路径
appBuildFilePath=$(pwd)/app/build.gradle

shellProductFlavors="shellProductFlavors"

#目标字符串所在行数
function getLine(){
    sed -n -e '/'$1'/=' $2
}

#判断某文件中是否包含某字符串,如果没有则退出当前脚本命令
function judgeStringInFile() {
    grep -q $1 $2
    if [ ! $? -eq 0 ];then
        echo 1
        else
        echo 0
    fi
}

productFlavorsStatus=$(judgeStringInFile $shellProductFlavors $appBuildFilePath)

if [ $productFlavorsStatus -ne 1 ];then
#ProductFlavors开始的行数
productFlavorsLineNumber=$(getLine $shellProductFlavors $appBuildFilePath)
#开始添加 productFlavors
productFlavorsString1="\        "$appName"\ {"
productFlavorsString2="\            dimension\ globalConfiguration.androidDemension"
productFlavorsString3="\            applicationId\ globalConfiguration."$appName"ApplicationId"
productFlavorsString4="\            buildConfigField\ \"String\",\ \"ZC_KEY\",\ \'\"bbbbeb98dea845e3b185ee4ca6d01982\"\'"
sed -i '' $productFlavorsLineNumber'a\
'"$productFlavorsString1"'\
'"$productFlavorsString2"'\
'"$productFlavorsString3"'\
'"$productFlavorsString4"'\
\        }\
' $appBuildFilePath
else
echo "<<"$appBuildFilePath"中缺少驱动脚本字符串<<"$shellProductFlavors
fi

shellBuildTypesSignRelease="shellBuildTypesSignRelease"
shellBuildTypesSignDemonstrate="shellBuildTypesSignDemonstrate"

buildTypeSignReleaseStatus=$(judgeStringInFile $shellBuildTypesSignRelease $appBuildFilePath)

if [ $buildTypeSignReleaseStatus -ne 1 ];then
#shellBuildTypesSignRelease开始的行数配置应用签名
buildTypeSignReleaseLineNumber=$(getLine $shellBuildTypesSignRelease $appBuildFilePath)
#开始配置签名
buildTypeSignSet="\            productFlavors."$appName".signingConfig signingConfigs.shandian"
sed -i '' $buildTypeSignReleaseLineNumber'a\
'"$buildTypeSignSet"'\
' $appBuildFilePath
else
echo "<<"$appBuildFilePath"中缺少驱动脚本字符串<<"$shellBuildTypesSignRelease
fi

buildTypeSignDemonstrateStatus=$(judgeStringInFile $shellBuildTypesSignDemonstrate $appBuildFilePath)

if [ $buildTypeSignDemonstrateStatus -ne 1 ];then
#shellBuildTypesSignDemonstrate开始的行数,配置应用签名,每一次设置都要重新获取一次行数
buildTypeSignDemonstrateLineNumber=$(getLine $shellBuildTypesSignDemonstrate $appBuildFilePath)
buildTypeSignSet="\            productFlavors."$appName".signingConfig signingConfigs.shandian"
sed -i '' $buildTypeSignDemonstrateLineNumber'a\
'"$buildTypeSignSet"'\
' $appBuildFilePath
else
echo "<<"$appBuildFilePath"中缺少驱动脚本字符串<<"$shellBuildTypesSignDemonstrate
fi

#shellSourceSets,开始配置资源文件
shellSourceSets="shellSourceSets"

sourceSetsStatus=$(judgeStringInFile $shellSourceSets $appBuildFilePath)

if [ $sourceSetsStatus -ne 1 ];then
shellSourceSetsLineNumber=$(getLine $shellSourceSets $appBuildFilePath)

shellSourceSetsSet1="\        "$appName"\ {"
shellSourceSetsSet2="\            res.srcDirs = [\'src/"$appName"/res']"
shellSourceSetsSet3="\        }"

sed -i '' $shellSourceSetsLineNumber'a\
'"$shellSourceSetsSet1"'\
'"$shellSourceSetsSet2"'\
'"$shellSourceSetsSet3"'\
' $appBuildFilePath
else
echo "<<"$appBuildFilePath"中缺少驱动脚本字符串<<"$shellSourceSets
fi


#shellSourceSets,开始配置app名称,三方参数等,
shellManifestPlaceholders="shellManifestPlaceholders"

manifestPlaceholdersStatus=$(judgeStringInFile $shellManifestPlaceholders $appBuildFilePath)

if [ $manifestPlaceholdersStatus -ne 1 ];then
manifestPlaceholdersLineNumber=$(getLine $shellManifestPlaceholders $appBuildFilePath)

shellManifestPlaceholdersSet1="\        if (variant.productFlavors.get(0).name == \""$appName"\") {"
shellManifestPlaceholdersSet2="\            if (variant.buildType.getName().toLowerCase() == \"debug\") {"
shellManifestPlaceholdersSet3="\                variant.resValue \"string\", \"app_name\", \"测试版 "$appChineseName"\""
shellManifestPlaceholdersSet4="\            }"
shellManifestPlaceholdersSet5="\            if (variant.buildType.getName().toLowerCase() == \"release\") {"
shellManifestPlaceholdersSet6="\                variant.resValue \"string\", \"app_name\", \""$appChineseName"\""
shellManifestPlaceholdersSet7="\            }"
shellManifestPlaceholdersSet8="\            if (variant.buildType.getName().toLowerCase() == \"demonstrate\") {"
shellManifestPlaceholdersSet9="\                variant.resValue \"string\", \"app_name\", \"内测版 "$appChineseName"\""
shellManifestPlaceholdersSet10="\            }"
shellManifestPlaceholdersSet11="\            variant.buildConfigField(STRING, \"APPName\", \'\""$appChineseName"\"\')"
shellManifestPlaceholdersSet12="\            mergedFlavor.manifestPlaceholders = [GETUI_APP_ID    : \"rz9sn0ZlgyAxvoYbVOD8u7\","
shellManifestPlaceholdersSet13="\                                                 GETUI_APP_KEY   : \"XQhPAXfajY6EPvZ4IoTbO7\","
shellManifestPlaceholdersSet14="\                                                 GETUI_APP_SECRET: \"Etjewvv897Axftm9KynQh3\","
shellManifestPlaceholdersSet15="\                                                 BAIDU_APP_KEY   : \""$baiduAppKey"\","
shellManifestPlaceholdersSet16="\                                                 UMENG_APP_KEY   : \"5c5115fbf1f556f0c10018ee\","
shellManifestPlaceholdersSet17="\                                                 SCHEME          : \""$appName"\"]"
shellManifestPlaceholdersSet18="\        }"

sed -i '' $manifestPlaceholdersLineNumber'a\
'"$shellManifestPlaceholdersSet1"'\
'"$shellManifestPlaceholdersSet2"'\
'"$shellManifestPlaceholdersSet3"'\
'"$shellManifestPlaceholdersSet4"'\
'"$shellManifestPlaceholdersSet5"'\
'"$shellManifestPlaceholdersSet6"'\
'"$shellManifestPlaceholdersSet7"'\
'"$shellManifestPlaceholdersSet8"'\
'"$shellManifestPlaceholdersSet9"'\
'"$shellManifestPlaceholdersSet10"'\
'"$shellManifestPlaceholdersSet11"'\
'"$shellManifestPlaceholdersSet12"'\
'"$shellManifestPlaceholdersSet13"'\
'"$shellManifestPlaceholdersSet14"'\
'"$shellManifestPlaceholdersSet15"'\
'"$shellManifestPlaceholdersSet16"'\
'"$shellManifestPlaceholdersSet17"'\
'"$shellManifestPlaceholdersSet18"'\
' $appBuildFilePath
else
echo "<<"$appBuildFilePath"中缺少驱动脚本字符串<<"$shellManifestPlaceholders
fi

