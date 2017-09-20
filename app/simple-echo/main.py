from flask import Flask


app = Flask(__name__)

@app.route("/")
def root():
    return "Hello from / "

@app.route("/echo")
def foo():
    return "Hello from /echo "

@app.route('/echo/<name>')
def show_user_profile(name):
    # show the user profile for that user
    return 'Hello %s' % name


if __name__ == "__main__":
    app.run(host='0.0.0.0', port='8080')
