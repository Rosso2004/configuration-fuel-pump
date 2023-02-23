#!/bin/bash

read -p "Desideri eseguire l'aggiornamento del sistema? [Y/n]" choice
case "$choice" in 
  y|Y ) 
    echo "Aggiornamento dei pacchetti di sistema..."
    sudo apt-get update && sudo apt-get upgrade
    ;;
  n|N )
    echo "Aggiornamento del sistema non eseguito."
    ;;
  * ) echo "Scelta non valida. L'aggiornamento del sistema non verrà eseguito."
      ;;
esac

sudo apt-get install plymouth -y
sudo apt-get install plymouth-themes -y

sudo apt -y install rpd-plym-splash

sudo rm -f /usr/share/plymouth/themes/spinner/background-tile.png
sudo mv background-tile.png /usr/share/plymouth/themes/spinner
sudo plymouth-set-default-theme -R spinner
sudo reboot