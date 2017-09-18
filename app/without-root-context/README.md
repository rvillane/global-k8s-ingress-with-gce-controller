# Simple app with root context


Exposes:

- /bar
- /bar/baz
- /bar/baz/foo




```
docker build -t cgrant/server-without-root-context .
docker run -it --rm -p 8080:8080 cgrant/server-without-root-context
docker push cgrant/server-without-root-context
```