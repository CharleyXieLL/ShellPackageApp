#!/usr/bin/env bash

appChineseName=$1
baseUrlPrefix=$2
api=$3

#gradle.properties 文件路径
gradlePropertiesFilePath=$(pwd)/gradle.properties

shellGradleProperties="shellGradleProperties"

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

productFlavorsStatus=$(judgeStringInFile $shellGradleProperties $gradlePropertiesFilePath)

gradlePropertiesStatus=$(judgeStringInFile $shellGradleProperties $gradlePropertiesFilePath)

if [ $productFlavorsStatus -ne 1 ];then

shellGradlePropertiesLineNumber=$(getLine $shellGradleProperties $gradlePropertiesFilePath)
shellGradlePropertiesSet1="#"$appChineseName" 正式环境"
shellGradlePropertiesSet2=$baseUrlPrefix"="$api""

sed -i '' $shellGradlePropertiesLineNumber'a\
'"$shellGradlePropertiesSet1"'\
'"$shellGradlePropertiesSet2"'\
' $gradlePropertiesFilePath
else
echo "<<"$gradlePropertiesFilePath"中缺少驱动脚本字符串<<"$shellGradleProperties
fi