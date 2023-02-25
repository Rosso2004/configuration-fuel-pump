#!/bin/bash

if whiptail --title "WARNING" --yesno "This option automatically starts a kiosk after system boot. Are you sure you want to proceed with the configuration?" 20 80; then
  count_lines() {
    lines=$(wc -l < "${1:-/dev/stdin}")
    echo "$lines"
  }

  {
    sudo apt update 2>/dev/null
    for i in {1..10}; do
      echo $i
      sleep 0.05
    done
    sudo apt-get install chromium-browser -y 2>/dev/null
    for i in {11..50}; do
      echo $i
      sleep 0.05
    done
    sudo apt-get install xorg -y 2>/dev/null
    for i in {51..100}; do
      echo $i
      sleep 0.05
    done
  } | whiptail --title "Installing dependencies" --gauge "Installing packages, please wait..." 8 78 0

  sito=""
  while [[ -z "$sito" ]]; do
    sito=$(whiptail --inputbox "Enter the website to display:" 8 78 --title "Website" 3>&1 1>&2 2>&3)
    if [[ -z "$sito" ]]; then
      whiptail --title "Error" --msgbox "Cannot proceed without entering a website." 8 78
    fi
  done

  {
    for i in {1..10}; do
      echo $i
      sleep 0.05
    done
    echo "#!/bin/sh" > /home/$USER/.xsession
    echo "xset -dpms" >> /home/$USER/.xsession
    echo "xset s off" >> /home/$USER/.xsession
    echo "xset s noblank" >> /home/$USER/.xsession
    echo "while true; do" >> /home/$USER/.xsession
    echo "     chromium-browser --kiosk --start-fullscreen --window-size=1920,1080 $sito" >> /home/$USER/.xsession
    echo "done" >> /home/$USER/.xsession
    for i in {11..50}; do
      echo $i
      sleep 0.05
    done
    chmod +x /home/$USER/.xsession
    for i in {51..100}; do
      echo $i
      sleep 0.05
    done
  } | whiptail --title "Creating .xsession" --gauge "Creating .xsession file, please wait..." 8 78 0

  {
    for i in {1..10}; do
      echo $i
      sleep 0.05
    done
    if ! grep -q "startx -- -nocursor" /home/$USER/.bashrc; then
        echo "if [[ \$(tty) == /dev/tty1 ]]; then" >> /home/$USER/.bashrc
        echo "  startx -- -nocursor" >> /home/$USER/.bashrc
        echo "fi" >> /home/$USER/.bashrc
    fi
    for i in {11..50}; do
      echo $i
      sleep 0.05
    done
    for i in {51..100}; do
      echo $i
      sleep 0.05
    done
  } | whiptail --title "Updating .bashrc" --gauge "Updating .bashrc file, please wait..." 8 78 0
fi