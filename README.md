# Dockerfile
```shell
docker run -v `pwd`:/src -p 8080:8000 mrlyc/opengrok
curl http://127.0.0.1:8000/source/
```
