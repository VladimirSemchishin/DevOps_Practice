docker build . -t hello-world-image

docker run hwi

docker network inspect bridge 

#Проверим проверим ответ сервера, ip можно узнать при инспекции сети
(ip + 8080 port): 
curl http://172.17.0.2:8080



docker build --target builder . -t hwi-intermediate
docker build . -t hwi