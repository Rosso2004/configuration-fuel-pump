#!/bin/bash

function progress {
    local w=80 p=$1;  shift
    printf -v dots "%*s" "$(( $p*$w/100 ))" ""; dots=${dots// /.};
    printf "\r\e[K|%-*s| %3d %% %s" "$w" "$dots" "$p" "$*";
}

read -p "Desideri eseguire l'aggiornamento del sistema? [Y/n]" choice
case "$choice" in 
  y|Y ) 
    echo "Aggiornamento dei pacchetti di sistema..."
    sudo apt-get update && sudo apt-get upgrade > /dev/null 2>&1
    progress 25
    ;;
  n|N )
    echo "Aggiornamento del sistema non eseguito."
    progress 25
    ;;
  * ) echo "Scelta non valida. L'aggiornamento del sistema non verrà eseguito."
      progress 25
      ;;
esac

echo "Installazione di Plymouth e dei suoi temi..."
sudo apt-get install plymouth -y > /dev/null 2>&1
sudo apt-get install plymouth-themes -y > /dev/null 2>&1
progress 50

echo "Installazione di RPD-Plym-Splash..."
sudo apt -y install rpd-plym-splash > /dev/null 2>&1
progress 75

echo "Clonazione del repository dei temi di Plymouth e impostazione del tema di default..."
sudo rm -f /usr/share/plymouth/themes/spinner/background-tile.png > /dev/null 2>&1
sudo mv background-tile.png /usr/share/plymouth/themes/spinner > /dev/null 2>&1
sudo plymouth-set-default-theme -R spinner > /dev/null 2>&1
progress 100
echo -e "\nConfigurazione del bootloader eseguita con successo!"

sudo reboot