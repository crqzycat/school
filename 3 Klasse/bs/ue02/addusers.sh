#!/bin/bash
# addusers.sh
# 
set -x
mkdir -p /home/heroes
mkdir -p /home/friends
mkdir -p /home/police
mkdir -p /home/villains

groupadd heroes
groupadd friends
groupadd police
groupadd villains

useradd batman -c "Bruce Wayne" -g heroes -d /home/heroes/batman -m -s /bin/bash
  
useradd robin -c "Dick Grayson" -g friends -d /home/friends/robin -m -s /bin/bash
  
useradd catwoman -c "Selina Kyle" -g friends -d /home/friends/catwoman -m -s /bin/bash
  
useradd gordon -c "James Gordon" -g police -d /home/police/gordon -m -s /bin/bash
  
useradd joker -c "The Joker" -g villains -d /home/villains/joker -m -s /bin/bash
  
useradd penguin -c "Oswald Cobblepot" -g  villains -d /home/villains/penguin -m -s /bin/bash


echo batman:darkknight | chpasswd
  
echo robin:nightwing | chpasswd
  
echo  catwoman:meowmeow | chpasswd
  
echo  gordon:law-n-order | chpasswd
  
echo  joker:whysoserious | chpasswd
  
echo  penguin:fish\! | chpasswd

