docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
:: docker rmi $(docker images -q)
docker build -t mfrancia/bigdata .
docker run --name=bigdata -it -p 18080:18080 -p 8080:8080 -v C:\Users\matteo.francia5\Desktop\docker\bare\work:/work mfrancia/bigdata