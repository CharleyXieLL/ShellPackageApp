#!/usr/bin/env bash

baseUrlPrefix=$1
appName=$2

#baselibrary build.gradle 文件路径
baselibraryGradleFilePath=$(pwd)/baselibrary/build.gradle

shellBaselibraryProductFlavors="shellBaselibraryProductFlavors"
shellBaseLibraryUrl="shellBaseLibraryUrl"
shellBaselibraryUrlAsProject="shellBaselibraryUrlAsProject"

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

baselibraryProductFlavorsStatus=$(judgeStringInFile $shellBaselibraryProductFlavors $baselibraryGradleFilePath)

if [ $baselibraryProductFlavorsStatus -ne 1 ];then
shellBaselibraryProductFlavorsLineNumber=$(getLine $shellBaselibraryProductFlavors $baselibraryGradleFilePath)

shellBaselibraryProductFlavorsSet1="\        "$appName" {"
shellBaselibraryProductFlavorsSet2="\            dimension globalConfiguration.androidDemension"
shellBaselibraryProductFlavorsSet3="\        }"

sed -i '' $shellBaselibraryProductFlavorsLineNumber'a\
'"$shellBaselibraryProductFlavorsSet1"'\
'"$shellBaselibraryProductFlavorsSet2"'\
'"$shellBaselibraryProductFlavorsSet3"'\
' $baselibraryGradleFilePath
else
echo "<<"$baselibraryGradleFilePath"中缺少驱动脚本字符串<<"$shellBaselibraryProductFlavors
fi



baseLibraryUrlStatus=$(judgeStringInFile $shellBaseLibraryUrl $baselibraryGradleFilePath)

if [ $baseLibraryUrlStatus -ne 1 ];then
shellBaseLibraryUrlLineNumber=$(getLine $shellBaseLibraryUrl $baselibraryGradleFilePath)
shellBaseLibraryUrlSet="\    def "$baseUrlPrefix" = CONFIG('"$baseUrlPrefix"')"

sed -i '' $shellBaseLibraryUrlLineNumber'a\
'"$shellBaseLibraryUrlSet"'\
' $baselibraryGradleFilePath
else
echo "<<"$baselibraryGradleFilePath"中缺少驱动脚本字符串<<"$shellBaseLibraryUrl
fi



baselibraryUrlAsProjectStatus=$(judgeStringInFile $shellBaselibraryUrlAsProject $baselibraryGradleFilePath)

if [ $baselibraryUrlAsProjectStatus -ne 1 ];then
shellBaselibraryUrlAsProjectLineNumber=$(getLine $shellBaselibraryUrlAsProject $baselibraryGradleFilePath)
shellBaselibraryUrlAsProjectSet1="\            else if (variant.productFlavors.get(0).getName() == \""$appName"\") {"
shellBaselibraryUrlAsProjectSet2="\                apiUrl = "$baseUrlPrefix
shellBaselibraryUrlAsProjectSet3="\            }"

sed -i '' $shellBaselibraryUrlAsProjectLineNumber'a\
'"$shellBaselibraryUrlAsProjectSet1"'\
'"$shellBaselibraryUrlAsProjectSet2"'\
'"$shellBaselibraryUrlAsProjectSet3"'\
' $baselibraryGradleFilePath
else
echo "<<"$baselibraryGradleFilePath"中缺少驱动脚本字符串<<"$shellBaselibraryUrlAsProject
fi