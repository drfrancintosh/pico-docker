#!/bin/bash
# set -e

### If you're getting Error statfs no such file or directory init the machine as follows:
### With the "-v" option pointing to the volume you're having trouble mounting
# podman machine init "$DEFAULT_MACHINE" -v /Volumes/GregsGit

# these are more dangerous that I thought
# yes | podman container prune
# yes | podman image prune

# variables
source ./env.sh

function machine_reset() {
    VOLUME="$1"; shift
    $DOCKER machine stop
    $DOCKER machine rm "$DEFAULT_MACHINE"
    if [[ "$VOLUME" != "" ]]; then
        $DOCKER machine init "$DEFAULT_MACHINE" -v "$VOLUME"
    else
        $DOCKER machine init "$DEFAULT_MACHINE"
    fi
    $DOCKER machine set --rootful
    $DOCKER machine start
}

function machine_usb() {
    # not working - Docker images don't readily support USB
    $DOCKER machine stop
    $DOCKER machine set --usb=bus=0,devnum=4
    $DOCKER machine set --rootful
    $DOCKER machine start
}  

function cleanup() {
    $DOCKER container rm "$PICO_CONTAINER" # delete old container
    $DOCKER image rm "$PICO_IMAGE" # delete old image
}

function build() {
    $DOCKER build -t "$PICO_IMAGE" . # build new image
}

machine_reset # /Volumes/GregsGit
# machine_usb
cleanup
build
