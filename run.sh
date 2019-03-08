if [ "$1" != "" ]; then
    docker run -it --rm -p 8888:8888 cbjuan/visual-literacy-survey-2018:$1
else
    echo "No version specified"
fi