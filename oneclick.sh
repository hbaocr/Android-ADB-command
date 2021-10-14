#!/bin/bash
echo "=========> 0. List Connected Devices(Phones)"
adb devices

echo "=========> 1. Uninstall APPs by packageName"
#adb shell dumpsys window | find "mCurrentFocus"  #for Window Only
packageNames=(
    org.linhome
    com.cpuid.cpu_z
    com.microsoft.teams
)
for ((i=0; i < ${#packageNames[@]}; i++ ))
do 
    echo "--> $i  uninstall:  ${packageNames[$i]}"
    adb shell pm uninstall -k --user 0 ${packageNames[$i]}
done

echo "=========> 2. Install Apps"
apk_file=($(find ./apps -name '*.apk'))
for ((i=0; i < ${#apk_file[@]}; i++ ))
do 
    echo "--> $i  install:  ${apk_file[$i]}"
    adb install ${apk_file[$i]}
done


# echo "=========> 5. Disable Developer mode"
# adb shell settings put global development_settings_enabled 0
# adb shell settings put global adb_enabled 0
# adb reboot

