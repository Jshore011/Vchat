import pyrebase
from flask import *
import firebase_admin
import pyrebase
from firebase_admin import credentials, auth
from settings.local_settings import AWS_REGION, ENVIRONMENT
import json
app = Flask(__name__)

#connect to firebase
###cred = credentials.Certificate('fbconfig.json')
firebase_config_file='fbconfig.json'
firebase_admin_creds_file='fbAdminConfig.json'
firebase = pyrebase.initialize_app(firebase_admin_creds_file)
auth = firebase.auth()

@app.route('/', methods=['GET','POST']) #endpoint
def auth():
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
    app.run(host='0.0.0.0', port=80)
