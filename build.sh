if [ "$1" != "" ]; then
    docker build --no-cache -t cbjuan/visual-literacy-survey-2018:$1 .
else
    echo "No version specified"
fi