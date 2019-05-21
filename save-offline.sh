if [ "$1" != "" ]; then
    docker save --output visual-literacy-survey-2018-$1.tar felicidadgsanchez/visual-literacy-survey-2018:$1
else
    echo "No version specified"
fi