#!/bin/bash
docker build -t somal/sample-node .
docker push somal/sample-node

ssh malsokolov@35.187.12.13 << EOF
docker pull somal/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi somal/sample-node:current || true
docker tag somal/sample-node:latest somal/sample-node:current
docker run -d --restart always --name web -p 80:80 somal/sample-node:current
EOF
