#!/bin/bash

#kollar if root
if [[$EUID -ne 0]]; then
    echo $EUID
    exit "User is not root, must be executed as root"
fi

# loop som skapar alla users i argumenten
for var in $@; do
    adduser $var
    mkdir /home/$var/Documents
    mkdir /home/$var/Downloads
    mkdir /home/$var/Work

    #log file to find all users added by this script
    touch /home/$var/.logme

    echo "Välkommen $var" > /home/$var/welcome.txt

    #ändrar permissions
    chmod 700 /home/$var/* #700 står för user all permissions inget annat
    chgrp $var /home/$var/*
    chown $var /home/$var/*
done

# Filter the users and add them to welcome.txt
for var in $@; do
    find /home/ | grep .logme | sed 's/\/home\///g' | sed 's/\/.logme//g' >> /home/$var/welcome.txt
done