#!/bin/bash
# set -e

### If you're getting Error statfs no such file or directory init the machine as follows:
### With the "-v" option pointing to the volume you're having trouble mounting
# podman machine init "$DEFAULT_MACHINE" -v /Volumes/GregsGit

# variables
source ./env.sh

function die() {
    echo ""
    echo "$1"
    exit 1
}

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

function cleanup() {
    $DOCKER container rm "$PICO_CONTAINER" # delete old container
    $DOCKER image rm "$PICO_IMAGE" # delete old image
}

function build() {
    $DOCKER build -t "$PICO_IMAGE" . # build new image
}

# set up user home for docker image
export USER_HOME="$1"
if [[ "$USER_HOME" == "" ]]; then die "`basename $0` <USER_HOME> (typically \$HOME, eg... $HOME)"; fi
cp ./scripts/env_template.sh ./scripts/env.sh
echo "export USER_HOME=\"$USER_HOME\"" >> ./scripts/env.sh

machine_reset # /Volumes/GregsGit
cleanup
build
