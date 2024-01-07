#!/bin/bash

#Domain and Colors Varible
domain=$1
RED="\033[1;31m" 
GREEN="\033[0;32m"
RESET="\033[0m"

#Varible for file Storage
info_path=$domain/info
subdomain_path=$domain/subdomains
open_ports=$domain/ports
harvested=$domain/email

#conditions That helps Create New Folders if they don't Already Exist
if [ ! -d "$domain" ];then
    mkdir $domain
fi

if [ ! -d "$info_path" ];then
    mkdir $info_path
fi

if [ ! -d "$subdomain_path" ];then
    mkdir $subdomain_path
fi

if [ ! -d "$open_ports" ];then
    mkdir $open_ports
fi

if [ ! -d "$harvested" ];then
    mkdir $harvested
fi

#Welcome Message
echo -e "${GREEN} [-] WELCOME TO WEB OSINT SCANNER ${RED}"

#WEB SCANNER Banner Code
figlet -f slant "WEB SCANNER"

#Checking for WHOis Info and Storing in whois file
echo -e "${GREEN} [+] Checking who ${domain} is...${RESET}"
whois $1 > $info_path/whois.txt

#Using Nmap to Scan Ports, Services, Operation systems and Possible Vulnerabilities.
echo -e "${GREEN} [+] Checking for Available Vulnerabilities on $domain...${RESET}"
echo -e "${GREEN} [+] Saving Available Ports on $domain...${RESET}"
nmap -T4 -sS -p- -A $domain > $open_ports/port.txt

echo -e "${GREEN} [+] Checking for Firewall on ${domain}...${RESET}"
wafw00f $1 

echo -e "${GREEN} [+] Harvesting Emails from ${domain}...${RESET}"
theHarvester -d $domain -b yahoo | sed -n '/@/p'  > $harvested/email.txt
sed -i '/cmartorella/d' $harvested/email.txt

echo -e "${GREEN} [+] Launching subfinder...${RESET}"
subfinder -d $domain > $subdomain_path/found.txt

echo -e "${GREEN} [+] Running assetfinder...${RESET}"
assetfinder $domain | grep $domain >> $subdomain_path/found.txt

echo -e "${GREEN} [+] Checking what's alive...${RESET}"
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt




