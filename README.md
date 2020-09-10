# docker-nginx

Rebuild the nginx with echo module.  
Debug or learn nginx config comfortable.


How to use.
>1. Build it yourself.
```sh
git clone https://github.com/carlxjs/docker-nginx.git
cd docker-nginx
docker build -t tagname:version .
docker run --name nginx -p 80:80 -d tagname:version
```

>2. Pull the image directly.
```sh
docker pull carlxjs/nginx:latest
docker run --name nginx -p 80:80 -d carlxjs/nginx:latest
```
