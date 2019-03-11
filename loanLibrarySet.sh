#!/usr/bin/env bash

baseUrlPrefix=$1
appName=$2

#loan module build.gradle 文件路径
loanGradleFilePath=$(pwd)/loan/build.gradle

shellBaseLibraryUrl="shellBaseLibraryUrl"
shellBaselibraryProductFlavors="shellBaselibraryProductFlavors"
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

LoanLibraryProductFlavors=$(judgeStringInFile $shellBaselibraryProductFlavors $loanGradleFilePath)
if [ $LoanLibraryProductFlavors -ne 1 ];then
shellBaselibraryProductFlavorsLineNumber=$(getLine $shellBaselibraryProductFlavors $loanGradleFilePath)

shellBaselibraryProductFlavorsSet1="\        "$appName" {"
shellBaselibraryProductFlavorsSet2="\            dimension globalConfiguration.androidDemension"
shellBaselibraryProductFlavorsSet3="\        }"

sed -i '' $shellBaselibraryProductFlavorsLineNumber'a\
'"$shellBaselibraryProductFlavorsSet1"'\
'"$shellBaselibraryProductFlavorsSet2"'\
'"$shellBaselibraryProductFlavorsSet3"'\
' $loanGradleFilePath
else
echo "<<"$loanGradleFilePath"中缺少驱动脚本字符串<<"$shellBaselibraryProductFlavors
fi



loanLibraryUrlStatus=$(judgeStringInFile $shellBaseLibraryUrl $loanGradleFilePath)

if [ $loanLibraryUrlStatus -ne 1 ];then
shellBaseLibraryUrlLineNumber=$(getLine $shellBaseLibraryUrl $loanGradleFilePath)
shellBaseLibraryUrlSet="\    def "$baseUrlPrefix" = CONFIG('"$baseUrlPrefix"')"

sed -i '' $shellBaseLibraryUrlLineNumber'a\
'"$shellBaseLibraryUrlSet"'\
' $loanGradleFilePath
else
echo "<<"$loanGradleFilePath"中缺少驱动脚本字符串<<"$shellBaseLibraryUrl
fi


loanLibraryUrlAsProjectStatus=$(judgeStringInFile $shellBaselibraryUrlAsProject $loanGradleFilePath)

if [ $loanLibraryUrlAsProjectStatus -ne 1 ];then
shellBaselibraryUrlAsProjectLineNumber=$(getLine $shellBaselibraryUrlAsProject $loanGradleFilePath)
shellBaselibraryUrlAsProjectSet1="\            else if (variant.productFlavors.get(0).getName() == \""$appName"\") {"
shellBaselibraryUrlAsProjectSet2="\                apiUrl = "$baseUrlPrefix
shellBaselibraryUrlAsProjectSet3="\            }"

sed -i '' $shellBaselibraryUrlAsProjectLineNumber'a\
'"$shellBaselibraryUrlAsProjectSet1"'\
'"$shellBaselibraryUrlAsProjectSet2"'\
'"$shellBaselibraryUrlAsProjectSet3"'\
' $loanGradleFilePath
else
echo "<<"$loanGradleFilePath"中缺少驱动脚本字符串<<"$shellBaselibraryUrlAsProject
fi