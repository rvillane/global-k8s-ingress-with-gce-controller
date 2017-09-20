# Simple app without root context


Exposes:
- /foo
- /foo/baz
- /foo/baz/bar



```
docker build -t cgrant/server-without-root-context .
docker run -it --rm -p 8080:8080 cgrant/server-without-root-context
docker push cgrant/server-without-root-context
```