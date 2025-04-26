#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker run -d -p 1337:1337 shashikumar025/strapi-app

