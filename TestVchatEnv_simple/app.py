import pyrebase
from flask import *
app = Flask(__name__)

#connect to firebase
cred = credentials.Certificate('fbconfig.json')
firebase = pyrebase.initialize_app(cred)
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
            return render_template('new.html', s=successful)
        except:
            return render_template('new.html', us=unsuccessful)

    return render_template('new.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
