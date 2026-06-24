#!/bin/bash

FOLDER=$1

DEST_FOLDER="${FOLDER}-archive-split"
DEST_FILE="${DEST_FOLDER}/${FOLDER}.tar.gz"

mkdir -p ${DEST_FOLDER}

tar -c --use-compress-program=pigz -O -v ${FOLDER} | split -b 500M - ${DEST_FILE}
