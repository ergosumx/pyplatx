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

# Create Python Environment Manager Tool with Pyenv

config_file="$HOME/.pyplatx"

# License prompt
read -p "Accept MIT License for this tool? (y/n) " choice  
if [ "$choice" != "y" ]; then
  echo "License not accepted, exiting"
  exit 1 
fi

# Functions  

function pyenv_install() {

  if [ -z "$(which pyenv)" ]; then
    curl https://pyenv.run | bash
  fi

  pyenv update

  banner="######### pyenv configured by pyplatx #########"

  if grep -q "$banner" ~/.bash_profile; then
    sed -i "/$banner/,/$banner/d" ~/.bash_profile
  fi

  echo "$banner" >> ~/.bash_profile  
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
  echo "$banner" >> ~/.bash_profile

  . ~/.bash_profile 
}

function install_build_packages() {

  pkgs=$(yq e '.build_packages[]' "$config_file")
  
  for pkg in $pkgs; do
    if [ ! $(dpkg -s $pkg > /dev/null) ]; then
      sudo apt install -y $pkg 
    fi
  done  
}

function install_python_versions() {

  versions=$(yq e '.python_envs[]' "$config_file")  

  for version in $versions; do
    if ! pyenv versions | grep -q $version; then
      pyenv install "$version"
    fi
  done
  
  pyenv global $(yq e '.global_version' "$config_file")  
}

# Install and configure pyenv
pyenv_install

# Install build packages
install_build_packages

# Install python versions
install_python_versions