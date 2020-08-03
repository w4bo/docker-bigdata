sudo docker stop cdh
sudo docker rm cdh
sudo docker build -t mfrancia/cdh .
sudo docker run --name=cdh -it -p 7180:7180 -p 7182:7182 mfrancia/cdh
