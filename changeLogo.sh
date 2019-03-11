#!/usr/bin/env bash

appName=$1

CURRENT_FILE_PATH=$(pwd)

filePath=$CURRENT_FILE_PATH/app/src/$appName/res
desktopPath=/Users/$USER/Desktop/$appName

if [ ! -d $filePath -a -n "$appName" ]
then
	mkdir -p $filePath
	cd $filePath
	mkdir mipmap-hdpi
	mkdir mipmap-mdpi
	mkdir mipmap-xhdpi
	mkdir mipmap-xxhdpi
	mkdir mipmap-xxxhdpi
fi

mv $desktopPath/安卓/h@3x.png $filePath/mipmap-hdpi/ic_launcher_logo.png
mv $desktopPath/安卓/m@3x.png $filePath/mipmap-mdpi/ic_launcher_logo.png
mv $desktopPath/安卓/x@3x.png $filePath/mipmap-xhdpi/ic_launcher_logo.png
mv $desktopPath/安卓/xx@3x.png $filePath/mipmap-xxhdpi/ic_launcher_logo.png
mv $desktopPath/安卓/xxx@3x.png $filePath/mipmap-xxxhdpi/ic_launcher_logo.png
mv $desktopPath/启动页/1125.png $filePath/mipmap-xxhdpi/yhb_splash_welcome.png

echo ">>图标以及开屏页图片更换成功!"

