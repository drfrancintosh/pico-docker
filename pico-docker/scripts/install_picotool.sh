#!/bin/bash
set -e

git clone https://github.com/raspberrypi/picotool.git /home/pico/picotool

cd /home/pico/picotool && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install