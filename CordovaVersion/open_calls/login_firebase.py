import pyrebase
from flask import request, g
import json
from firebase_admin import credentials, auth
from flask_json import FlaskJSON, JsonError, json_response, as_json
import bcrypt
import psycopg2
from psycopg2 import sql
from tools.logging import logger

def handle_request():

    logging.debug("firebase")
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

    return "success"

