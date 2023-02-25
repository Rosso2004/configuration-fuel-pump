#!/bin/bash

count_lines() {
  lines=$(wc -l < "${1:-/dev/stdin}")
  echo "$lines"
}

{
  sudo apt update 2>/dev/null
  for i in {1..35}; do
    echo $i
    sleep 0.05
  done
  sudo apt-get install plymouth -y 2>/dev/null
  for i in {36..59}; do
    echo $i
    sleep 0.05
  done
  sudo apt-get install plymouth-themes -y 2>/dev/null
  for i in {60..78}; do
    echo $i
    sleep 0.05
  done
  sudo apt -y install rpd-plym-splash 2>/dev/null
  for i in {79..100}; do
    echo $i
    sleep 0.05
  done
} | whiptail --title "Installing dependencies" --gauge "Installing packages, please wait..." 8 78 0

{
  sudo rm -f /usr/share/plymouth/themes/spinner/background-tile.png
  for i in {1..42}; do
    echo $i
    sleep 0.05
  done
  sudo cp background-tile.png /usr/share/plymouth/themes/spinner
  for i in {53..78}; do
    echo $i
    sleep 0.05
  done
  sudo plymouth-set-default-theme -R spinner
  for i in {79..100}; do
    echo $i
    sleep 0.05
  done
} | whiptail --title "Installing theme" --gauge "Installing custom theme, please wait..." 8 78 0