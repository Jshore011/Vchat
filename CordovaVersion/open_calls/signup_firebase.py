import pyrebase

from getpass import getpass
from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
import bcrypt
import psycopg2
from psycopg2 import sql

from tools.logging import logger

def handle_request():

    logging.debug("firebase")
firebaseConfg ={
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

email = request.form['username']
logger.debug(email)
password = request.form['password']
logger.debug(password)


user = auth.create_user_with_email_and_password(email, password)

retrun "success"

