#!/bin/bash
docker container stop linux
# docker container stop $(docker container ls -aq)
# docker container rm $(docker container ls -aq)
docker container rm linux
# docker rmi $(docker images ls -aq)
docker build -t mfrancia:linux .
docker run --name=linux --rm -v C:\Users\matteo.francia5\Documents\repos:/repos -it mfrancia:linux
