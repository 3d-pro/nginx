# Nginx Mainline /w OpenSSL 1.0.2 image of Debian Sid [![Build Status](https://travis-ci.org/3d-pro/nginx.svg?branch=master)](https://travis-ci.org/3d-pro/nginx)

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
