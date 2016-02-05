#!/bin/bash
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
fileName=$(mktemp fileList.XXXXXX)


    currentDir="/usr/share/backgrounds"
  
   while IFS=' '  read name 
   do 
      
        if [ -z "$name" ] 
        then
	  continue
        else
	  echo "file://$currentDir/$name" >> $fileName
        fi
        i=$(($i+1))
   done < <(ls $currentDir)
   count=$(wc -l $fileName | cut -f1 -d' ')
   
   index=$(shuf -i 1-$count -n 1)
   gsettings set org.gnome.desktop.background picture-uri $(sed $index'q;d' $fileName ) 
    rm $fileName
