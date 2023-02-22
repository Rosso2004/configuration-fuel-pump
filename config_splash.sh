#!/bin/bash

# Aggiornamento dei pacchetti di sistema
#sudo apt-get update && sudo apt-get upgrade

# Installazione di Plymouth e dei suoi temi
sudo apt-get install plymouth -y
sudo apt-get install plymouth-themes -y

# Installazione di RPD-Plym-Splash per abilitare/disabilitare lo splash screen dal raspi-config
sudo apt -y install rpd-plym-splash

# Clonazione del repository dei temi di Plymouth e impostazione del tema di default
sudo rm -f /usr/share/plymouth/themes/spinner/background-tile.png
sudo mv background-tile.png /usr/share/plymouth/themes/spinner
sudo plymouth-set-default-theme -R spinner
sudo reboot