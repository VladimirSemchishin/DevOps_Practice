#! /bin/bash

### Install Docker

apt-get update && apt-get install -y apt-transport-https ca-sertificates curl software-properties-common
echo "<h2>СОЗДАЛ САЙТ<h2>" > /var/www/html/index.html
sudo service nginx start 