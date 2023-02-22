#!/bin/bash

sudo apt-get install chromium-browser -y
sudo apt-get install xorg -y

read -p "Inserisci il sito da mostrare: " sito

echo "#!/bin/sh" > /home/$USER/.xsession
echo "xset -dpms" >> /home/$USER/.xsession
echo "xset s off" >> /home/$USER/.xsession
echo "xset s noblank" >> /home/$USER/.xsession
echo "while true; do" >> /home/$USER/.xsession
echo "     chromium-browser --kiosk --start-fullscreen --window-size=1920,1080 $sito" >> /home/$USER/.xsession
echo "     sleep 5s" >> /home/$USER/.xsession
echo "done" >> /home/$USER/.xsession

chmod +x /home/$USER/.xsession

if ! grep -q "startx -- -nocursor" /home/$USER/.bashrc; then
  echo "if [[ \$(tty) == /dev/tty1 ]]; then" >> /home/$USER/.bashrc
  echo "  startx -- -nocursor" >> /home/$USER/.bashrc
  echo "fi" >> /home/$USER/.bashrc
  echo "Le istruzioni per avviare startx sono state aggiunte al file .bashrc."
else
  echo "Le istruzioni per avviare startx sono già presenti nel file .bashrc."
fi

echo "Lo script è stato creato correttamente."

sudo reboot