#!/bin/bash

sudo chmod +x config/config_splash.sh
sudo chmod +x config/config_kiosk.sh

options=(1 "Install the custom bootloader"
         2 "Configure the kiosk on startup"
         3 "Reboot the system appol")

while true; do
    option=$(whiptail --title "Pump Configuration" --menu "Choose an option:" 15 60 4 "${options[@]}" 3>&1 1>&2 2>&3)

    if [ $? -eq 0 ]; then
        case $option in
            1)
                sh config/config_splash.sh
                ;;
            2)

                sh config/config_kiosk.sh
                ;;
            3)
                sudo reboot
                ;;
        esac
    else
        break
    fi
done