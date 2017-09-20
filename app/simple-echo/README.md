# Simple app with root context


Exposes:
- /
- /echo



```
docker build -t cgrant/simple-echo-server .
docker run -it --rm -p 8080:8080 cgrant/simple-echo-server
docker push cgrant/simple-echo-server
```