#!/bin/bash

# Parametrer les adresses IP ainsi que les identifiants souris et clavier
declare -a adresses_ip=("192.168.1.13" "192.168.1.14" "192.168.1.15")
UTILISATEUR=user
MDP=motdepasse

function disable_all()
{
  for i in "${adresses_ip[@]}"
  do
    ssh $UTILISATEUR@$i "echo '$MDP'|sudo -S modprobe -rvf psmouse"
    ssh $UTILISATEUR@$i "echo '$MDP'|sudo -S modprobe -rvf usbhid"
  done
}

function enable_all()
{
  for i in "${adresses_ip[@]}"
  do
    ssh $UTILISATEUR@$i "echo '$MDP'|sudo -S modprobe psmouse"
    ssh $UTILISATEUR@$i "echo '$MDP'|sudo -S modprobe usbhid"
  done
}

if [ -z "$1" ]
  then
    echo "ERREUR : Vous devez lancer le script avec le parametre 'enable' ou 'disable'"
    exit
fi

if [ "$1" == "disable" ]
  then
    disable_all
fi

if [ "$1" == "enable" ]
  then
    enable_all
fi
