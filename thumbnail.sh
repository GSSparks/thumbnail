#!/bin/bash

FORMATS=('*.mp4' '*.mkv' '*.avi' '*.m4v') # Let's figure out what format video files are in this directory
for ext in ${FORMATS[@]}; do
    test=$(find . -maxdepth 1 -iname "$ext")
    if [[ "$test" ]]; then
        EXT+=("${ext}")
    fi
done

SCALE="scale=640:-2"

Help() {
    echo
    echo "Create thumbnails for every video in afolder"
    echo
    echo "thumbnail [-h|t] [-f Filename]"
    echo "options:"
    echo "-h             Show this help."
    echo "-t             Create thumbnail at a specific Timestamp. (ex. 00:00:05)"
    echo "-f             Filename to make a thumbnail for a single video."
    echo
}

SetTimestamp() {
    echo -n "Make thumbnail at what timestamp? (ex. 00:00:05) "
    read TIMESTAMP
}

MakeThumbnail() {
    for file in "$PWD"/"${EXT[@]}"; do
        if [[ "$TIMESTAMP" ]]; then
            TIME="-ss $TIMESTAMP"
            VF="-vf $SCALE"
        else
            TIME=""
            VF="-vf thumbnail,$SCALE"
        fi

        if [[ "$FILENAME" ]]; then
            file="$FILENAME"
            broked='True'
        fi

        echo "Creating thumbnail for ${file##*/}"
        ffmpeg -hide_banner -loglevel error -i "$file" $TIME $VF -frames:v 1 "${file%%.mp4}"-thumb.jpg
        if [[ "$broked" ]]; then
            break
        fi
    done
}

while getopts ":htf:" option; do
    case $option in
        h)
            Help
            exit;;
        t)
            SetTimestamp
            ;;
        f)
            FILENAME="$OPTARG"
            ;;
        ?)
            Help
            exit;;
    esac
done

MakeThumbnail
