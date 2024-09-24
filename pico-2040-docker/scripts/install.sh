#!/bin/bash

export SKIP_OPENOCD=1 # skip openocd until we can get it working
export SKIP_VSCODE=1
export SKIP_UART=1

cd /home
source .bashrc
rm -rf pico
mkdir -p "$USER_HOME"

/usr/local/bin/pico_setup.sh
/user/local/bin/install_picotool.sh
# /usr/local/bin/makepico.sh example
# /bin/bash