#!/bin/bash

if [[$EUID -ne 0]]; then
    echo $EUID
    echo "fuck off non root man"
    exit 1
fi

for var in $@; do
    adduser $var
    mkdir /home/$var/Documents
    mkdir /home/$var/Downloads
    mkdir /home/$var/Work
    touch /home/$var/.logme

    echo "Välkommen $var" > /home/$var/welcome.txt

    chmod u=wrx /home/$var /home/$var/Documents /home/$var/Downloads /home/$var/Work
    chgrp $var /home/$var /home/$var/Documents /home/$var/Downloads /home/$var/Work
    chown $var /home/$var /home/$var/Documents /home/$var/Downloads /home/$var/Work
done

for var in $@; do
    find /home/ | grep .logme | sed 's/\/home\///g' | sed 's/\/.logme//g' >> /home/$var/welcome.txt
done