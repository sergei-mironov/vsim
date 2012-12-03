for file in $*
do
    { rm $file && awk '{ sub("\r$$", ""); sub("$$", "\r"); print }' > $file; } < $file
done
