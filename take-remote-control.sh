#!/bin/bash

# Parametrer les adresses IP ainsi que les identifiants souris et clavier
declare -a adresses_ip=("192.168.1.13" "192.168.1.25" "192.168.1.30")
ID_PRINCIPAL_SOURIS=2
ID_SECONDAIRE_SOURIS=12
ID_PRINCIPAL_CLAVIER=3
ID_SECONDAIRE_CLAVIER=11

function disable_all()
{
  for i in "${adresses_ip[@]}"
  do
    ssh root@$i 'xinput float $ID_SECONDAIRE_SOURIS'
    ssh root@$i 'xinput float $ID_SECONDAIRE_CLAVIER'
  done
}

function enable_all()
{
  for i in "${adresses_ip[@]}"
  do
    ssh root@$i 'xinput reattach $ID_SECONDAIRE_SOURIS $ID_PRINCIPAL_SOURIS'
    ssh root@$i 'xinput reattach $ID_SECONDAIRE_CLAVIER $ID_PRINCIPAL_CLAVIER'
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
