docker run -p 127.0.0.1:3306:3306 --name mariadb -e MARIADB_ROOT_PASSWORD=superpass -d mariadb
docker exec -ti mariadb sh
# whoami -покажет под каким пользователем мы находимся
# cat /etc/passwd -покажет всех пользователей
docker stop mariadb
docker rm mariadb

docker run -u 999 -p 127.0.0.1:3306:3306 --name mariadb -e MARIADB_ROOT_PASSWORD=superpass -d mariadb
docker exec -ti mariadb sh
# whoami
# cd /root/
docker stop mariadb
docker rm mariadb

docker run -p 127.0.0.1:3306:3306 --name mariadb -e MARIADB_ROOT_PASSWORD=superpass -d mariadb
docker exec -ti mariadb sh
# whoami
# cd /root/
# ip link 
# ip link delete eth0
docker stop mariadb
docker rm mariadb

docker run --privileged -p 127.0.0.1:3306:3306 --name mariadb -e MARIADB_ROOT_PASSWORD=superpass -d mariadb
docker exec -ti mariadb sh
# whoami
# cd /root/
# ip link 
# ip link delete eth0
docker stop mariadb
docker rm mariadb