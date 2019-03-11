#!/usr/bin/env bash

appName=$1
appId=$2

#包名设置文件路径
dependenciesFilePath=$(pwd)/buildsystem/dependencies.gradle

shellAppApplicationId="shellAppApplicationId"

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

shellAppApplicationIdStatus=$(judgeStringInFile $shellAppApplicationId $dependenciesFilePath)

if [ $shellAppApplicationIdStatus -ne 1 ];then
#添加应用标识开始的行数
applicationIdLineNumber=$(getLine $shellAppApplicationId $dependenciesFilePath)
#开始添加应用唯一识别 ID
dependenciesString=$appName"ApplicationId = \"$appId\""
sed -i '' $applicationIdLineNumber'a\
\    '"$dependenciesString"'\'$'\n' $dependenciesFilePath
else
echo "<<"$dependenciesFilePath"中缺少驱动脚本字符串<<"$shellAppApplicationId
fi

