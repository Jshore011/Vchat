import pyrebase
from getpass import getpass


firebaseConfig = {
        "apiKey": "AIzaSyCjMU8ankorPuxvYnxQpbk5hX1a0ZjvwSk",

        "authDomain": "vchat-37136.firebaseapp.com",

        "databaseURL": "https://vchat-37136.firebaseapp.com/",

        "projectId": "vchat-37136",
       
        "storageBucket": "vchat-37136.appspot.com",

        "messagingSenderId": "993893663736",

        "appId": "1:993893663736:web:87f489696d2f23656dcc0d",

        "measurementId": "G-7K5G0D6MMW"

        }

firebase = pyrebase.initialize_app(firebaseConfig)

auth = firebase.auth()


email = input("Please enter your email")
password = getpass("Please enter a password")


user = auth.create_user_with_email_and_password(email, password)

print("success")
