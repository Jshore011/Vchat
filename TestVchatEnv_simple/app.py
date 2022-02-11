import pyrebase
from flask import *
import firebase_admin
import pyrebase
import json
from firebase_admin import credentials, auth

app = Flask(__name__)

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

@app.route('/', methods=['GET', 'POST'])

def basic():

	if request.method == 'POST':
		email = request.form['email']
		password = request.form['password']
		try:
			auth.sign_in_with_email_and_password(email, password)
			return print("successful login")
		except:
			return print("unsuccessful login")

	return ('login.html')


if __name__ == '__main__':
	app.run()



























