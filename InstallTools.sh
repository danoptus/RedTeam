#!/bin/bash
# 
# Operatin System - DEBIAN 10 
#
# Author: Danoptus 
# 
# https://github.com/danoptus/
#
 
####################################
# BEFORE START
####################################
# 1 - ADD YOUR USER TO SUDO
# su -
# adduser <user> sudo 
# shutdown -r now
#
# 2 - CONFIGURE LOCALE
# sudo sudo bash -c 'echo LANGUAGE="en_US.UTF-8" > /etc/environment'
# sudo sudo bash -c 'echo LC_ALL="en_US.UTF-8" >> /etc/environment'

####################################
# BASIC DEPENDENCIES AND TOOLS
####################################

# Dependencies
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt autoremove

sudo apt-get install -y software-properties-common build-essential net-tools autoconf cmake libssl-dev subversion libsvn-dev libssh2-1-dev libffi-dev libpcap-dev libusb-1.0-0-dev libnetfilter-queue-dev libz-dev libbz2-dev libgmp-dev python-dev python-pip python3-pip python-m2crypto ruby-dev autoconf automake autopoint libtool pkg-config krb5-user

#Tools
sudo apt-get -y install net-tools golang postgresql zsh nano vim git wget curl asciinema screen dnsutils

#Python 3 standart
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 2
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1

####################################
# Network Scans
####################################

# Nmap
cd /tmp/
git clone https://github.com/nmap/nmap.git
cd nmap 
sudo ./configure --with-localdirs
sudo make
sudo make install
sudo make clean
sudo nmap --script-updatedb
cd ..
sudo rm -rf nmap

####################################
# Network Tools
####################################

# tcpdump
sudo apt-get install -y tcpdump

# arpsoof
sudo apt install -y dsniff

# ettercap
sudo apt-get install -y ettercap-common

# Bettercap
go get -u github.com/bettercap/bettercap
sudo cp ~/go/bin/bettercap /usr/local/bin 

####################################
# Network Exploitation Tools
####################################

# Impacket
cd /tmp/
sudo apt-get remove -y python-crypto
sudo apt-get purge -y python-crypto 
sudo apt-get purge --auto-remove -y python-crypto 
git clone https://github.com/SecureAuthCorp/impacket.git
cd impacket
sudo pip install .
cd ..
sudo rm -rf impacket

# LDAP3
sudo pip install ldap3

# DNSPYTHON
sudo pip install dnspython

#adidnsdump
git clone https://github.com/dirkjanm/adidnsdump
cd adidnsdump
pip install .

# mitm6
sudo pip install service_identity
sudo pip install mitm6

# Responder
cd ~
mkdir Tools 
cd Tools
git clone https://github.com/lgandx/Responder.git

# CrackMapExec - Python 3
cd /tmp/ 
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec && cd CrackMapExec
sudo pip install -r requirements.txt
sudo python setup.py install
cd ..
sudo rm -rf CrackMapExec

#evil-winrm
sudo gem install winrm winrm-fs stringio
sudo gem install evil-winrm

####################################
# Command and Control
####################################

# Metasploit
cd /tmp
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
rm -rf msfinstall

echo "production:" > database.yml
echo " adapter: postgresql" >> database.yml
echo " database: msf" >> database.yml
echo " username: msf" >> database.yml
echo " password: msf" >> database.yml
echo " host: 127.0.0.1" >> database.yml
echo " port: 5432" >> database.yml
echo " pool: 200" >> database.yml
echo " timeout: 5" >> database.yml
sudo cp database.yml  /opt/metasploit-framework/embedded/framework/config/

sudo su - postgres psql -c "createuser msf -P -S -R -D" << EOF &>/dev/null
msf
msf
EOF

sudo su - postgres psql -c "createdb -O msf msf"

# EMPIRE
cd /opt
sudo git clone https://github.com/BC-SECURITY/Empire.git
cd Empire
sudo ./setup/install.sh

####################################
# Password Tools
####################################

# JohnTheRipper
cd /tmp
git clone git://github.com/magnumripper/JohnTheRipper -b bleeding-jumbo john
cd john/src
sudo ./configure
sudo make -s clean
sudo make -sj4
cd ..
rm -rf JohnTheRipper

####################################
# COVER THE TRACKS
####################################
# Proxychains
cd /tmp
git clone https://github.com/rofl0r/proxychains-ng.git
cd proxychains-ng
./configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
sudo make install-config
cd ..
sudo rm -rf proxychains-ng








