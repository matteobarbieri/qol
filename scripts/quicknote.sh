#!/bin/sh

set -e

TODAY=$(date +%Y%m%d)
NOW=$(date +%Y%m%d%H%M%S)

NOTES_FOLDER=~/Dropbox/quicknotes

# Create folder if it does not already exists
mkdir -p $NOTES_FOLDER

NOTE_NOW="$NOTES_FOLDER/${NOW}.md"
NOTE_TODAY="$NOTES_FOLDER/${TODAY}.md"

# Edit note in a temp file
vim -c 'startinsert' $NOTE_NOW


# Add note to today's notes only if not empty
if [ -f $NOTE_NOW ]; then

    # Add timestamp before note
    echo $(date +%d/%m/%Y\ %H:%M:%S) >> $NOTE_TODAY

    # Add note to daily notes
    cat $NOTE_NOW >> $NOTE_TODAY

    # Add a newline after note
    echo "" >> $NOTE_TODAY

    # Remove single note
    rm $NOTE_NOW
fi
