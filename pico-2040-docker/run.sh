#!/bin/bash
# set -e

source ./env.sh

_user_project="$1"
if [[ "" == "$_user_project" ]]; then
    echo "Usage: $0 <user_project>"
    echo "  user_project: the path to the user's project directory"
    echo "  it will be mounted at the root of the container"
    exit 1
fi

user_project=`realpath $_user_project`
echo "Using user_project directory: $user_project"

## remove old container, if there is one
$DOCKER container rm "$PICO_CONTAINER" 2>&1 > /dev/null 

## run the container 
## -it: in interactive mode
## --network="host": use the host network
## -v: mount the user's project directory to the container's home directory
##     NOTE: USER_HOME is set the something like /Users/greg ($HOME)
##     NOTE: This emulates the user's home path in the container
##     NOTE: To make connecting w/ VSCode easier
## --privileged: give the container full access to the host's devices
## --name: name the container
## $PICO_IMAGE: the image to run
## "login.sh": the command to run in the container

echo $DOCKER run -it --network="host" -v "$user_project:$user_project" --privileged --name "$PICO_CONTAINER" "$PICO_IMAGE"  "login.sh"