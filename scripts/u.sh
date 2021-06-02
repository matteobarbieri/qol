#!/bin/bash

HOST_FOLDER=$1
shift

TARGET_FOLDER=/mnt/folder

docker run -it -v $HOST_FOLDER:$TARGET_FOLDER ubuntu $@ $TARGET_FOLDER
