from flask import Flask


app = Flask(__name__)

@app.route("/")
def root():
    return "Hello from / "

@app.route("/foo")
def foo():
    return "Hello from /foo "

@app.route("/foo/baz")
def baz():
    return "Hello from /foo/baz "

@app.route("/foo/baz/bar")
def bar():
    return "Hello from /foo/baz/bar "


if __name__ == "__main__":
    app.run(host='0.0.0.0', port='8080')
