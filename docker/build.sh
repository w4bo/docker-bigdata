docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
sudo docker build -t mfrancia/bigdata .
sudo docker run --name=bigdata -it \
            -p 18080:18080 -p 8080:8080 \
            --mount type=bind,source="$(pwd)"/work,target=/work \
            mfrancia/bigdata