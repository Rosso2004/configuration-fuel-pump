function progress {
    echo -ne "\r\e[K"
    local w=80 p=$1;  shift
    printf -v progressbar "%0.s#" $(seq 1 $(($p*$w/100)))
    printf -v spaces "%0.s " $(seq $((($p*$w/100)+1)) $w)
    printf "\r\e[K|%s%s| %3d %% %s" "$progressbar" "$spaces" "$p" "$*";
}

echo -n "Aggiornare il sistema? [s/N]: "
read update
if [ "$update" = "s" ] || [ "$update" = "S" ]; then
    echo "Aggiornamento del sistema in corso..."
    sudo apt-get update && sudo apt-get upgrade &> /dev/null
    if [ $? -ne 0 ]; then
        echo "Aggiornamento del sistema non eseguito."
        ERROR=1
    else
        echo "Aggiornamento del sistema eseguito con successo."
    fi
fi

echo "Installazione di Plymouth e dei suoi temi..."
sudo apt-get install plymouth -y &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installazione di Plymouth non riuscita."
    ERROR=1
else
    progress 25
    echo
fi

echo "Installazione di RPD-Plym-Splash per abilitare/disabilitare lo splash screen dal raspi-config..."
sudo apt -y install rpd-plym-splash &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installazione di RPD-Plym-Splash non riuscita."
    ERROR=1
else
    progress 50
    echo
fi

echo "Clonazione del repository dei temi di Plymouth e impostazione del tema di default..."
sudo rm -f /usr/share/plymouth/themes/spinner/background-tile.png &> /dev/null
sudo mv background-tile.png /usr/share/plymouth/themes/spinner &> /dev/null
sudo plymouth-set-default-theme -R spinner &> /dev/null
if [ $? -ne 0 ]; then
    echo "Clonazione del repository dei temi di Plymouth non riuscita."
    ERROR=1
else
    progress 75
    echo
fi

echo -ne "\r\e[K"
progress 100
echo

if [ $ERROR -eq 0 ]; then
    echo "Eseguito con successo!"
fi