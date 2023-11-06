# Advance Website Osint Scanner

![Project Logo](https://pbs.twimg.com/media/F-QoYi2XgAAVKxF?format=png&name=small)

## What is a Web OSINT Scanner

Web OSINT Scanner is an Advance Website Scanning tool for uncovering information from the vast web of online sources! Whether you're an investigator, researcher, or just curious, this tool can help you gather publicly available data from the internet.

## Key Features

- 🌐 Explore information from online sources.
- 🕵️‍♂️ Active Sub Domains Finder
- 🌐 Website Whois Information
- 🕵️‍♂️ Website Nmap Ports and Service  Scan

## Example Usage

Using Web Osint Scanner to scan reddit.com.

Root privileges needed for nmap tofunction effectively so you must use sudo when performing scan.

$ sudo ./web_Osint.sh reddit.com

## Getting Started

Before you dive into the world of Open Source intelligence, make sure you have the following Knowledge and Tools

### Prerequisites

- Linux : Intermidiate Linux knowledge will be required to use this tool
- This tool is built with bash, so make sure you understand how bash works.
- You may need to install additional Linux tools. Check out our [installation guide](#installation) for more details.

### Installation

1. Clone this repository to your local machine using git clone https://github.com/mezarkiv/web_osint_scanner.git

2. change web_Osint script permission to Executable $chmod +x web_Osint.sh 

3. Add the Below Codes to your .bashrc config file
    export GOPATH=$HOME/go 
    export GOROOT=/usr/lib/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

4. install the following packages for a smooth scan
 - $go install github.com/tomnomnom/httprobe@latest 
 - $go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
 - $go get -u github.com/tomnomnom/assetfinder 
 - $apt-get install nmap
