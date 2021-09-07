#!/bin/bash


#Post Install Script for VM or (possibly) Linux Box
#Personal Use only | Based on g0tm1lk's ~ https://blog.g0tmi1k.com/  
# https://raw.githubusercontent.com/g0tmi1k/os-scripts/master/kali-rolling.sh
#-Licence-
#  MIT License ~ http://opensource.org/licenses/MIT           
#-Notes-
#Run as Root
#  Command line arguments:                                    
#    -burp     = Automates configuring Burp Suite (Community) 
#    -dns      = Use OpenDNS and locks permissions           
#    -openvas  = Installs & configures OpenVAS vuln scanner   
#    -osx      = Changes to Apple keyboard layout             
#                                                             
#    -keyboard <value> = Change the keyboard layout language  
#    -timezone <value> = Change the timezone location         
#                                                             
#  e.g. # bash 4s0ck3t.sh -burp -keyboard gb -openvas    


#-Defaults-------------------------------------------------------------#


##### Location information
keyboardApple=false         # Using a Apple/Macintosh keyboard (non VM)?                [ --osx ]
keyboardLayout=""           # Set keyboard layout                                       [ --keyboard gb]
timezone=""                 # Set timezone location                                     [ --timezone Europe/London ]

##### Optional steps
burpFree=false              # Disable configuring Burp Suite (for Burp Pro users...)    [ --burp ]
hardenDNS=false             # Set static & lock DNS name server                         [ --dns ]
openVAS=false               # Install & configure OpenVAS (not everyone wants it...)    [ --openvas ]

##### (Optional) Enable debug mode?
#set -x

##### (Cosmetic) Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

STAGE=0                                                         # Where are we up to
TOTAL=$( grep '(${STAGE}/${TOTAL})' $0 | wc -l );(( TOTAL-- ))  # How many things have we got todo



#-Start----------------------------------------------------------------#


##### Check if we are running as root - else this script will fail (hard!)
if [[ "${EUID}" -ne 0 ]]; then
  echo -e ' '${RED}'[!]'${RESET}" This script must be ${RED}run as root${RESET}" 1>&2
  echo -e ' '${RED}'[!]'${RESET}" Quitting..." 1>&2
  exit 1
else
  echo -e " ${BLUE}[*]${RESET} ${BOLD}Kali Linux rolling post-install script${RESET}"
  sleep 3s
fi

apt update && apt upgrade -y

#install go
apt install golang

#install gobuster on kali
apt install gobuster

#install xclip for clipboard
apt install xclip

#setup tmux########################
cd /opt/ && git clone https://github.com/samoshkin/tmux-config.git && cd /opt/tmux-config/ && ./install.sh

#install ffuf
apt install ffuf

#install seclists
apt install seclists

#install pip & impacket stuff
apt install python-pip && pip install pyasn1 && pip install impacket

#install pip3
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py

#install nmapAutomator
cd /opt/ && git clone https://github.com/21y4d/nmapAutomator.git
sudo ln -s $(pwd)/nmapAutomator/nmapAutomator.sh /usr/local/bin/

#install AutoRecon
cd /opt/ && git clone https://github.com/Tib3rius/AutoRecon && cd AutoRecon && pip3 install -r requirements 

#########################################################################################################
###think this is vmware!
#mount -t fuse.vmhgfs-fuse .host:/ /mnt/s/ -o allow_other

#Virtualbox mounts as root so:
#usermod -aG vboxsf <youruser>

#increase history in terminal
#copy autoNmap to /usr/local/bin/
#sort alias
