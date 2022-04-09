from flask import Flask,render_template,request, redirect, url_for, g
from flask_json import FlaskJSON, JsonError, json_response, as_json

ERROR_MSG = "That Didn't work!"

#Create our app
app = Flask(__name__)
#add in flask json
FlaskJSON(app)

@app.route('/') #endpoint
def index():
    print("In index")
    return redirect('/static/ChatAnalytics.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
