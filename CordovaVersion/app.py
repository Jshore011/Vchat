from flask import Flask,render_template,request, redirect, url_for, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
import jwt

import sys
import datetime
import bcrypt
import traceback


import firebase_admin
import pyrebase
import json
from firebase_admin import credentials, auth


from db_con import get_db_instance, get_db

from tools.token_required import token_required
from tools.get_aws_secrets import get_secrets

from tools.logging import logger

ERROR_MSG = "That Didn't work!"


#Create our app
app = Flask(__name__)
#add in flask json
FlaskJSON(app)

#connect to firebase
cred = credentials.Certificate('fbAdminConfig.json')
firebase = firebase_admin.initialize_app(cred)
pb = pyrebase.initialize_app(json.load(open('fbconfig.json')))

#g is flask for a global var storage 
#def init_new_env():
#    if 'db' not in g:
#        g.db = get_db()

#    g.secrets = get_secrets()


config = {
    "apiKey": "AIzaSyCjMU8ankorPuxvYnxQpbk5hX1a0ZjvwSk",
    "authDomain": "vchat-37136.firebaseapp.com",
    "databaseURL": "https://vchat-37136.firebaseapp.com/",
    "projectId": "vchat-37136",
    "storageBucket": "vchat-37136.appspot.com",
    "messagingSenderId": "993893663736"
}

firebase = pyrebase.initialize_app(config)

auth = firebase.auth()

@app.route('/login_auth', methods=['GET', 'POST'])
def login_user():
	if request.method == 'POST':
		email = request.form['email']
		print("email:")
		print(email)

		password = request.form['password']
		print("Password:")
		print(password)
		try:
			auth.sign_in_with_email_and_password(email, password)
			return "successful login"
		except:
			return "unsuccessful login"

@app.route('/signup_auth', methods=['GET', 'POST'])
def signup_user():
	if request.method == 'POST':
		newemail = request.form['newemail']
		print("newEmail:")
		print(newemail)

		newpassword = request.form['newpassword']
		print("newPassword:")
		print(newpassword)
		try:
			user=auth.create_user_with_email_and_password(newemail, newpassword)
			return  user.get("localId")
		except:
			return "unsuccessful signup. Try again"

#This gets executed by default by the browser if no page is specified
#So.. we redirect to the endpoint we want to load the base page
@app.route('/') #endpoint
def index():
    return redirect('/static/VChat.html')


@app.route("/secure_api/<proc_name>",methods=['GET', 'POST'])
@token_required
def exec_secure_proc(proc_name):
    logger.debug(f"Secure Call to {proc_name}")

    #setup the env
    init_new_env()

    #see if we can execute it..
    resp = ""
    try:
        fn = getattr(__import__('secure_calls.'+proc_name), proc_name)
        resp = fn.handle_request()
    except Exception as err:
        ex_data = str(Exception) + '\n'
        ex_data = ex_data + str(err) + '\n'
        ex_data = ex_data + traceback.format_exc()
        logger.error(ex_data)
        return json_response(status_=500 ,data=ERROR_MSG)

    return resp



@app.route("/open_api/<proc_name>",methods=['GET', 'POST'])
def exec_proc(proc_name):
    logger.debug(f"Call to {proc_name}")

    #setup the env
    init_new_env()

    #see if we can execute it..
    resp = ""
    try:
        fn = getattr(__import__('open_calls.'+proc_name), proc_name)
        resp = fn.handle_request()
    except Exception as err:
        ex_data = str(Exception) + '\n'
        ex_data = ex_data + str(err) + '\n'
        ex_data = ex_data + traceback.format_exc()
        logger.error(ex_data)
        return json_response(status_=500 ,data=ERROR_MSG)

    return resp

#if __name__ == '__main__':
   # app.run(debug=True)
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
