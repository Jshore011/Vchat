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
import pyrebase

from getpass import getpass
from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
import bcrypt
import psycopg2
from psycopg2 import sql

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

@app.route('/') #endpoint
def index():
    return redirect('/login.html')



def handle_request():

    logging.debug("firebase")
    firebaseConfig ={
        “apiKey”: "AIzaSyCjMU8ankorPuxvYnxQpbk5hX1a0ZjvwSk",

        “authDomain”: "vchat-37136.firebaseapp.com",
            "databaseURL": "https://vchat-37136.firebaseapp.com/",

        “projectId”: "vchat-37136",

        “storageBucket”: "vchat-37136.appspot.com",

        “messagingSenderId”: "993893663736",

        “appId”: "1:993893663736:web:87f489696d2f23656dcc0d",

        “measurementId”: "G-7K5G0D6MMW"
        }

    firebase = pyrebase.initialize_app(firebaseConfig)

    auth = firebase.auth()

        #pw = request.form['password']
        #un = request.form['username']

    email = request.form['email']
    logger.debug(email)
    password = request.form['password']
    logger.debug(password)


    user = auth.sign_in_with_email_and_password(email, password)

    return "success"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
