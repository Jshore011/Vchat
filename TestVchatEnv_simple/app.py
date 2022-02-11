import pyrebase
from flask import *
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
	unsuccessful = 'Please check your credentials'
	successful = 'Login successful'
	if request.method == 'POST':
		email = request.form['email']
		password = request.form['password']
		try:
			auth.sign_in_with_email_and_password(email, password)
			return render_template('login.html', s=successful)
		except:
			return render_template('login.html', us=unsuccessful)

	return render_template('login.html')


if __name__ == '__main__':
	app.run()



























