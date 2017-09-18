from flask import Flask


app = Flask(__name__)



@app.route("/bar")
def foo():
    return "Hello from /bar "

@app.route("/bar/baz")
def baz():
    return "Hello from /bar/baz "

@app.route("/bar/baz/foo")
def bar():
    return "Hello from /bar/baz/foo "


if __name__ == "__main__":
    app.run(host='0.0.0.0', port='8080')
