from flask import Flask,render_template,request, redirect, url_for, g, request
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

import psycopg2
from psycopg2 import sql

ERROR_MSG = "That Didn't work!"

#Create our app
app = Flask(__name__)

#add in flask json
FlaskJSON(app)

#connect to firebase
cred = credentials.Certificate('fbAdminConfig.json')
firebase = firebase_admin.initialize_app(cred)
pb = pyrebase.initialize_app(json.load(open('fbconfig.json')))

@app.route('/auth') #endpoint
def handle_request():

    auth = firebase.auth()

    email = request.form['email']
    password = request.form['password']

    user = firebase.auth().signInWithEmailAndPassword(email, password)

    return "success"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
