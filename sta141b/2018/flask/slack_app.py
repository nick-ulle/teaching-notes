# slack_app.py
#
# To run:
#   FLASK_APP=slack_app flask run

import flask
from slackclient import SlackClient

# Set up a Flask app.
app = flask.Flask(__name__)

# Connect to Slack.
with open("slack_token") as f:
    slack_token = f.readline().strip()
sc = SlackClient(slack_token)

# This function returns the "/" page.
@app.route("/")
def index():
    channels = sc.api_call("channels.list")["channels"]
    chan_id = next(x["id"] for x in channels if x["name"] == "flask")
    
    history = sc.api_call("channels.history", channel = chan_id)
    messages = (x["text"] for x in history["messages"])
    
    return "<br />".join(messages)