#!/bin/bash

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip"
FONT_NAME="iosevka"

LOCAL_FILE_DIR="~/Downloads"
SYS_FILE_DIR="/usr/share/fonts"

if [ -d "$FILE_DIR" ]; then
  cd $FILE_DIR
  wget $FONT_URL
  unzip "Iosevka.zip" -d $FONT_NAME
  sudo cp -R $FONT_NAME $SYS_FILE_DIR
else
  	echo "The directory $DOWNLOADS_DIR not exists."
	exit 1
fi