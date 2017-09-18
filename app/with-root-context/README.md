# Simple app with root context


Exposes:
- /
- /foo
- /foo/baz
- /foo/baz/bar




```
docker build -t cgrant/server-with-root-context .
docker run -it --rm -p 8080:8080 cgrant/server-with-root-context
docker push cgrant/server-with-root-context
```