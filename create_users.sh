#!/bin/bash

if [[$EUID -ne 0]]; then
    echo $EUID
    exit "User is not root, must be executed as root"
fi

for var in $@; do
    adduser $var
    mkdir /home/$var/Documents
    mkdir /home/$var/Downloads
    mkdir /home/$var/Work
    touch /home/$var/.logme

    echo "Välkommen $var" > /home/$var/welcome.txt

    chmod 700 /home/$var/*
    chgrp $var /home/$var/*
    chown $var /home/$var/*
done

for var in $@; do
    find /home/ | grep .logme | sed 's/\/home\///g' | sed 's/\/.logme//g' >> /home/$var/welcome.txt
done