#!/bin/bash

domain=$1
RED="\033[1;31m"
GREEN="\033[0;32m"
RESET="\033[0m"

info_path=$domain/info
subdomain_path=$domain/subdomains
open_ports=$domain/ports
harvested=$domain/email

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

echo -e "${GREEN} [-] WELCOME TO WEB OSINT SCANNER ${RED}"

figlet -f slant "WEB SCANNER"

echo -e "${GREEN} [+] Checking who ${domain} is...${RESET}"
whois $1 > $info_path/whois.txt

echo -e "${GREEN} [+] Checking for Available Ports on $domain...${RESET}"
echo -e "${GREEN} [+] Saving Available Ports on $domain...${RESET}"
nmap -sS -A -sV -O -f $domain > $open_ports/port.txt
nmap -sL $domain >> $open_ports/port.txt

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




