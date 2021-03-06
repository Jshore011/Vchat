import pyrebase
from flask import *
import firebase_admin
import pyrebase
import json
from firebase_admin import credentials, auth
from flask_json import FlaskJSON, JsonError, json_response, as_json

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

if __name__ == '__main__':
	app.run()



























