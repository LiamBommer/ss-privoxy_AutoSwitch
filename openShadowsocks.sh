#!/bin/bash
# Program:
#	Start shadowsocks & privoxy to access to the real world
# History:
#	17/10/25 Liam
# 
# =========================================================
# 
# README
# 
# ---------------------------
#
# Usage:
#   @param 'start' or ''
#       open
#   @param 'stop'
#       stop
#
# Function:
#   Open or shutdown shadowsocks & privoxy
#   and change system proxy settings to 'manual' or 'auto'
#
# !!!  IMPORTANT !!!
# Path to your shadowsocks config file (*.json)
# Change it to your own path

    ssConfig='/etc/shadowsocks.json'
#
# =========================================================

# Can't find the correct shadowsocks' command
# PATH=/usr/bin:/usr/local/bin:/sbin:/bin

# =========================================================
# 
# =========================================================

echo -e "$1 running...\n "

# start
if [ "$1" == "start" ] || [ "$1" == "" ]; then
    echo -e "Changing systme proxy settings...\n "

    # Change system proxy settings to manual
    gsettings set org.gnome.system.proxy.http host '127.0.0.1'
    gsettings set org.gnome.system.proxy.http port 8118
    gsettings set org.gnome.system.proxy.https host '127.0.0.1'
    gsettings set org.gnome.system.proxy.https port 8118
    gsettings set org.gnome.system.proxy mode 'manual'

    echo -e "[Succeced] System proxy settings changed to manual.\n "

    echo -e "Loading shadowsocks & privoxy...\n "

    # shadowsocks & privoxy loading
    echo "liaomelo15@" | sudo -S /etc/init.d/privoxy start
    (sslocal -c "$ssConfig" &)
fi

# stop
if [ "$1" == 'stop' ]; then
    echo -e "Stopping shadowsocks & privoxy ...\n "
    
    # Stopping shadowsocks & privoxy
    echo "liaomelo15@" | sudo -S /etc/init.d/privoxy start
    sslocal -c ${ssConfig} -d stop

    # Change system proxy settings to manual
    gsettings set org.gnome.system.proxy mode 'auto'

    echo -e "\n[Succeeded] in Stopping shadowsocks & privoxy and turn system proxy settings to manual.\n "

fi

exit 0;
