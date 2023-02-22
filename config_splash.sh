#!/bin/bash

function progress {
    local w=80 p=$1;  shift
    printf -v progressbar "%0.s#" $(seq 1 $(($p*$w/100)))
    printf -v spaces "%0.s " $(seq $((($p*$w/100)+1)) $w)
    printf "\r\e[K|%s%s| %3d %% %s" "$progressbar" "$spaces" "$p" "$*";
}

read -p "Vuoi eseguire l'aggiornamento del sistema? [S/n]" choice
case "$choice" in 
  s|S ) 
    echo "Aggiornamento dei pacchetti di sistema..."
    sudo apt-get update && sudo apt-get upgrade > /dev/null 2>&1 &
    while [ -n "$(jobs | grep 'Running')" ]; do
        sleep 1
        progress $(awk '/progress [0-9]+/{print $2}' <(tail -n1 /var/log/apt/term.log))
    done
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

echo "Installazione di RPD-Plym-Splash per abilitare/disabilitare lo splash screen dal raspi-config..."
sudo apt -y install rpd-plym-splash > /dev/null 2>&1
progress 75

echo "Clonazione del repository dei temi di Plymouth e impostazione del tema di default..."
sudo rm -f /usr/share/plymouth/themes/spinner/background-tile.png > /dev/null 2>&1
sudo mv background-tile.png /usr/share/plymouth/themes/spinner > /dev/null 2>&1
sudo plymouth-set-default-theme -R spinner > /dev/null 2>&1
progress 100
echo -e "\nEseguito con successo!"

sudo reboot