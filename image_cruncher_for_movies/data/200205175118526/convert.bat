ffmpeg -framerate 12 -i img%%03d.jpg -c:v mpeg4 -vf scale=1280:720:flags=neighbor -sws_dither none out.mp4
pause