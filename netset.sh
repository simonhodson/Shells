#!/bin/bash

# File name and path to write too
# /etc/wpa_supplicant/wpa_supplicant.conf
FILE="test"
ping=`ping -c 1 www.google.com | grep bytes | wc -l`

function enter_details  {
        echo "*************************************"
        echo "*    Welcome to PI network setup    *"
        echo "*************************************"

        sleep 1

        echo "Enter SSID: "

        read SSID

        echo "Enter Passkey"

        read PASSKEY

        rm -f $FILE

        touch $FILE

        # Everything until EOT is included in file

        cat <<EOT>> $FILE
        country=GB
        ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
        update_config=1

        network={
                ssid="$SSID"
                psk="$PASSKEY"
        }
EOT
check_net
}

# Check Network with curl 
# Re run if fail


function check_net {
        if [ "$ping" -gt 1 ];then
                echo ">>>>>>>>> Success <<<<<<<<<<"
                exit
        else
                echo ">>>>>>>>>>>> NET FAILURE <<<<<<<<<<<"
                echo ">>>> CTRL + C to quit operation <<<<"
                echo "Restarting process 3."
                sleep 1
                echo "Restarting process 2.."
                sleep 1
                echo "Restarting process 1..."
                enter_details
        fi
}

# Start process
enter_details
  
