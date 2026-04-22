#!/bin/bash

# 1. Solicita privilégios imediatamente (Antes de qualquer ECHO)
# O -p garante que o prompt seja amigável
sudo -v -p "[sudo] password for $USER: "

# Keep-alive: atualiza o timestamp do sudo enquanto o script rodar
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 2. Agora sim iniciamos as mensagens visuais
echo -e "${BLUE}=== SmartVision Automation for Ubuntu ===${NC}"

# 3. Update and Install Basic Dependencies (NON-SILENT)
echo -e "${BLUE}[...] Updating package lists...${NC}"
sudo apt-get update -y

echo -e "${BLUE}[...] Checking dependencies...${NC}"
for pkg in curl wget tar; do
    if ! command -v $pkg &> /dev/null; then
        echo -e "${BLUE}[...] Installing $pkg...${NC}"
        sudo apt-get install -y $pkg
    fi
done

# 4. Docker Validation and Installation
if command -v docker &> /dev/null; then
    echo -e "${GREEN}[OK] Docker is already installed: $(docker -v)${NC}"
else
    echo -e "${BLUE}[...] Docker not found. Starting official installation...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[OK] Docker installed successfully!${NC}"
        rm -f get-docker.sh
    else
        echo -e "${RED}[Error] Docker installation failed.${NC}"
        exit 1
    fi
fi

# 5. Download and Prepare SmartVision
echo -e "${BLUE}[...] Downloading SmartVision assets...${NC}"
wget -q https://harpia-collector-scripts-ad78b5.gitlab.io/harpia_helper.tar.gz -O smartvision.tar.gz

if [ -f "smartvision.tar.gz" ]; then
    tar -xzvf smartvision.tar.gz
    
    if [ -f "harpia_helper.sh" ]; then
        mv harpia_helper.sh smartvision.sh
    fi
    
    chmod +x smartvision.sh
    rm -f smartvision.tar.gz
    echo -e "${GREEN}[OK] Configuration complete.${NC}"
else
    echo -e "${RED}[Error] Asset download failed.${NC}"
    exit 1
fi

# 6. Handover to SmartVision Submenu
echo -e "${BLUE}[...] Launching SmartVision...${NC}"
echo -e "${GREEN}------------------------------------------${NC}"

exec sudo ./smartvision.sh </dev/tty