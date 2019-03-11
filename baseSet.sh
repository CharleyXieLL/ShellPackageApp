#!/usr/bin/env bash
#!/usr/bin/env bash

objArray=($@)

appName=""

baseUrlPrefix="release"
baseUrlSet=""

#将入参中用来表示 projectName 的字段拼接起来并大写
for i in ${!objArray[@]}
do
     baseUrlSet=$baseUrlSet"_"${objArray[$i]}
     appName=$appName${objArray[$i]}
done

baseUrlPrefix=`tr '[a-z]' '[A-Z]' <<<"$baseUrlPrefix$baseUrlSet"`

CURRENT_FILE_PATH=$(pwd)

#核心参数配置文件路径
dependenciedSetPath=$CURRENT_FILE_PATH/shell/dependenciedSet.sh
baseLibrarySetPath=$CURRENT_FILE_PATH/shell/baseLibrarySet.sh
appModuleSetPath=$CURRENT_FILE_PATH/shell/appModuleSet.sh
gradlePropertiesSetPath=$CURRENT_FILE_PATH/shell/gradlePropertiesSet.sh
loanLibrarySetPath=$CURRENT_FILE_PATH/shell/loanLibrarySet.sh

#核心参数配置文件路径
appConfigPath=$CURRENT_FILE_PATH/shell/config/appShellConfig.txt


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

addConfigNumber=1

#将字符串转为数字,let此处作用同$((1+2))
let appNameLineNumber=$(getLine $appName $appConfigPath)+$addConfigNumber
let appIdLineNumber=$appNameLineNumber+$addConfigNumber
let baiduAppKeyLineNumber=$appIdLineNumber+$addConfigNumber
let apiLineNumber=$baiduAppKeyLineNumber+$addConfigNumber

appChineseName=`sed -n ${appNameLineNumber}p $appConfigPath`
appId=`sed -n ${appIdLineNumber}p $appConfigPath`
baiduAppKey=`sed -n ${baiduAppKeyLineNumber}p $appConfigPath`
api=`sed -n ${apiLineNumber}p $appConfigPath`

#设置应用 ID
sh $dependenciedSetPath $appName $appId

#设置签名三方配置参数等
sh $appModuleSetPath $appName $appChineseName $baiduAppKey

#gradle.properties 配置
sh $gradlePropertiesSetPath $appChineseName $baseUrlPrefix $api

#baselibrary 配置
sh $baseLibrarySetPath $baseUrlPrefix $appName

#loan module 配置
sh $loanLibrarySetPath $baseUrlPrefix $appName

echo '>>>>资源签名三方参数设置成功'

#替换应用图标以及开屏页
changeLogoShellPath=$(pwd)/shell/changeLogo.sh
sh $changeLogoShellPath $appName
