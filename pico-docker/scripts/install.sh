#!/bin/bash

export SKIP_OPENOCD=1 # skip openocd until we can get it working
export SKIP_VSCODE=1
export SKIP_UART=1

cd /home
source .bashrc
rm -rf pico
mkdir -p "$USER_HOME"

wget https://raw.githubusercontent.com/raspberrypi/pico-setup/master/pico_setup.sh -O /usr/local/bin/pico_setup.sh
chmod +x /usr/local/bin/pico_setup.sh
/usr/local/bin/pico_setup.sh
# it looks like pico_setup.sh does this for us...
#/usr/local/bin/install_picotool.sh

# /usr/local/bin/makepico.sh example
# /bin/bash