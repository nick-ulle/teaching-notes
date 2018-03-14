# hello_app.py
#
# To run:
#   FLASK_APP=hello_app python3 -m flask run

import flask

# Set up a Flask app.
app = flask.Flask(__name__)

# This function returns the "/" page.
@app.route("/")
def index():
   return "Hello world!" 

# This function returns the "/hello1" page.
@app.route("/hello<int:n>")
def hello(n):
    if n == 1:
        return "Hello 1 world!"
    else:
        return "Hello, all {} worlds!".format(n)