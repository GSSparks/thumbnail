# thumbnail

This is a simple Bash script that will loop through every video file in the directory that it is executed in and create a thumbnail with a "-thumb.jpg" added to the filename. It uses ffmpeg to create this thumbnail and will either make a "meaningful" thumbnail for the video file or you can set a timestamp. This is useful for creating thumbnails that reflect title screens or some other useful information.
I created this small script to make thumbnails for videos that I host on my Jellyfin server. 

The default action of this script is to create a random thumbnail. If you pass the -t flag it'll allow you to set a timestamp. If you pass the -f flag along with the name of a file, it'll create a thumbnail for just that file.
