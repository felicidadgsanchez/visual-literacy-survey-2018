if [ "$1" != "" ]; then
    docker load --input visual-literacy-survey-2018-$1.tar
else
    echo "No version specified"
fi