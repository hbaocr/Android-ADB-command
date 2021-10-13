#!/bin/bash

#https://www.techmesto.com/uninstall-pre-installed-apps-from-android-phone/


echo "0. List Connected Devices(Phones)"
echo "1. For list all installed package"
echo "2. For list Running APPs"
echo "3. For uninstall APPs by packageName"
echo "4. For Install APPS"
echo "5. For Disable Developer mode"

read opt

case $opt in
    0)
        echo "=========> 0. List Connected Devices(Phones)"
        adb devices
        ;;
    1)
        echo "=========> 1. List all installed package"
        adb shell pm list packages
        ;;

    2)
        echo "=========> 2. List Running APPs"
        #adb shell dumpsys window | find "mCurrentFocus"  #for Window Only
        adb shell dumpsys window | grep mPackageName= 
        ;;
    3) 
        echo "=========> 3. Uninstall APPs by packageName"
        #adb shell dumpsys window | find "mCurrentFocus"  #for Window Only
        packageNames=(
            com.drkumo.com
            com.example.invokemsteam
        )
        for ((i=0; i < ${#packageNames[@]}; i++ ))
        do 
            echo "--> $i  uninstall:  ${packageNames[$i]}"
            adb shell pm uninstall -k --user 0 ${packageNames[$i]}
        done
        ;;

    4)
        echo "=========> 5. Install Apps"
        apk_file=(
          $(PWD)/apps/microsoft-teams.apk
	      $(PWD)/apps/cpu-z.apk
        )
        for ((i=0; i < ${#apk_file[@]}; i++ ))
        do 
            echo "--> $i  install:  ${apk_file[$i]}"
            adb install ${apk_file[$i]}
        done
        ;;

    5) 
        echo "=========> 5. Disable Developer mode"
        adb shell settings put global development_settings_enabled 0
        adb shell settings put global adb_enabled 0
        adb reboot


esac

