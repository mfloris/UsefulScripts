#!/bin/bash

#run command on the last created/ edited file.
# if no command is given as $1, it runs the editor

EDITOR="emacsclient -n"
FILE=`ls -tr | tail -n1`

COMMAND=$EDITOR

if [ "$1" != "" ]
then
    COMMAND=$1
fi

echo "Processing [$FILE] with command [$COMMAND]"
$COMMAND $FILE
