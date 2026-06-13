#!/bin/bash

case "$1" in
    build_generator)
        docker build -t generator-image .
        ;;
    run_generator)
        docker run --rm -v "$(pwd)/data:/data" generator-image
        ;;
    create_local_data)
        python3 generate.py ./local_data
        ;;
    build_reporter)
        docker build -f Dockerfile.reporter -t reporter-image .
        ;;
    run_reporter)
        docker run --rm -v "$(pwd)/data:/data" reporter-image
        ;;
    structure)
        find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
        ;;
    clear_data)
        rm -f data/*.csv data/*.html
        ;;
    inside_generator)
        docker run --rm -v "$(pwd)/data:/data" generator-image ls -la /data
        ;;
    inside_reporter)
        docker run --rm -v "$(pwd)/data:/data" reporter-image ls -la /data
        ;;
    *)
        echo "Usage: ./run.sh {build_generator|run_generator|create_local_data|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter}"
        exit 1
        ;;
esac
