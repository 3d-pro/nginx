# Nginx Stable [![Build Status](https://github.com/3d-pro/nginx/actions/workflows/docker-build.yaml/badge.svg)](https://github.com/3d-pro/nginx/actions)

## Required Docker Images
- openssh

## Build
```
  docker build -t nginx:latest .
```
## Run
```
  docker run -d -p 8080:80 -p 4433:443 -h nginx --name nginx nginx:latest
```
