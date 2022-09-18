#!/bin/bash

EXT=('*.mp4' '*.mkv' '*.avi')
SCALE="scale=640:-2"

Help() {
    echo
    echo "Create thumbnails for every video in afolder"
    echo
    echo "thumbnail [-h|t]"
    echo "options:"
    echo "h     Show this help."
    echo "t     Create thumbnail at a specific Timestamp. (ex. 00:00:05)"
    echo
}

SetTimestamp() {
    echo -n "Make thumbnail at what timestamp? (ex. 00:00:05) "
    read TIMESTAMP
    MakeThumbnail
}

MakeThumbnail() {
    for file in "$PWD"/${EXT[@]}; do
        if [[ "$TIMESTAMP" ]]; then
            TIME="-ss $TIMESTAMP"
            VF="-vf $SCALE"
        else
            TIME=""
            VF="-vf thumbnail,$SCALE"
        fi
        ffmpeg -i "$file" $TIME $VF -frames:v 1 "${file%%.mp4}"-thumb.jpg
    done
}

while getopts ":h:t" option; do
    case $option in
        h)  Help
            exit;;
        t)  SetTimestamp
            exit;;
        \?) echo "Not an Option"
            exit;;
    esac
done

MakeThumbnail
