#!/bin/bash

# Copyright (c) 2023 Nilay Parikh (me@nilayparikh.com, nilayparikh@gmail.com), ErgoSum Technologies LTD (oss@ergosum.in)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Load config from file or use defaults
CONFIG_FILE=".pyplatx"
if [ "$1" = "-f" ] || [ "$1" = "--file" ]; then
    CONFIG_FILE="$2"
fi

# Functions
function parse_config {
    # Parse versions 
    TOOLKITS=($(yq e '.cuda.toolkit[]' ${1})) 
    CUDNNS=($(yq e '.cuda.cudnn[]' ${1}))
    
    if [ ${#TOOLKITS[@]} -eq 0 ]; then
        echo "No toolkits found in config"
        exit 1
    fi
    
    if [ ${#CUDNNS[@]} -eq 0 ]; then
        echo "No cuDNN found in config"
        exit 1 
    fi

    ACTIVE_TOOLKIT=$(yq e '.cuda.active[0] | split(":")[1]' $1)
    ACTIVE_CUDNN=$(yq e '.cuda.active[1] | split(":")[1]' $1)  
}

function install_cuda {
    # Loop through and install
    for tk in "${TOOLKITS[@]}"; do 
        sudo apt install -y cuda-$tk
    done
    
    for cudnn in "${CUDNNS[@]}"; do
        sudo apt install -y libcudnn8=$cudnn-1+cuda${tk} 
    done
}

function configure_cuda {
    # Set paths and vars for active 
    echo "export PATH=/usr/local/cuda-$ACTIVE_TOOLKIT/bin:$PATH" >> ~/.bashrc  
    echo "export CUDNN_VER=$ACTIVE_CUDNN" >> ~/.bashrc
}

function install_yq() {
  if ! command -v yq &> /dev/null; then
    echo "yq could not be found, installing..."
    sudo wget https://github.com/mikefarah/yq/releases/download/v4.6.3/yq_linux_amd64 -O /usr/bin/yq && sudo chmod +x /usr/bin/yq
  fi
}

function nvidia_add_update_and_upgrade() {
    
    # Add NVIDIA repos
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
    sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
    sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
    sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"

    sudo apt-get update -y && sudo apt-get upgrade -y
}

function update_and_upgrade() {
    echo "Updating and upgrading Ubuntu packages..."
    sudo apt-get update -y && sudo apt-get upgrade -y

    sudo apt-get install software-properties-common -y
}

# Update and upgrade Ubuntu packages
update_and_upgrade

# Add Nvidia repos
nvidia_add_update_and_upgrade

# Install yq
install_yq

# Main driver
parse_config $CONFIG_FILE
install_cuda
configure_cuda 

# Validate
nvidia-smi  

echo "Installation completed!"  