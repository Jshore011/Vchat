from flask import Flask, request, redirect, g, jsonify
from flask_json import FlaskJSON, json_response
import traceback
from db_con import get_db
from tools.token_required import token_required
from tools.get_aws_secrets import get_secrets
from tools.logging import logger
from firebase_admin import credentials, firestore, initialize_app

ERROR_MSG = "That Didn't work!"

# Initialize Flask app
app = Flask(__name__)
# add in flask json
FlaskJSON(app)

# Initialize Firestore DB
cred = credentials.Certificate('fbAdminConfig.json')
default_app = initialize_app(cred)
db = firestore.client()
channels_ref = db.collection('channels')


# g is flask for a global var storage
def init_new_env():
    if 'db' not in g:
        g.db = get_db()

    g.secrets = get_secrets()


# This gets executed by default by the browser if no page is specified
# So, we redirect to the endpoint we want to load the base page
@app.route('/')  # endpoint
def index():
    return redirect('/static/index.html')


@app.route('/list', methods=['GET'])
def read():
    """
        read() : Fetches documents from Firestore collection as JSON.
        user : Return document that matches query ID.
        all_todos : Return all documents.
    """
    try:
        # Check if ID was passed to URL query
        user_id = request.args.get('userid')
        if user_id:
            user = channels_ref.document(user_id).get()
            return jsonify(user.to_dict()), 200
        else:
            all_users = [doc.to_dict() for doc in channels_ref.stream()]
            return jsonify(all_users), 200
    except Exception as e:
        return f"An Error Occurred: {e}"


@app.route("/secure_api/<proc_name>", methods=['GET', 'POST'])
@token_required
def exec_secure_proc(proc_name):
    logger.debug(f"Secure Call to {proc_name}")

    # set up the env
    init_new_env()

    # see if we can execute it.

    try:
        fn = getattr(__import__('secure_calls.' + proc_name), proc_name)
        resp = fn.handle_request()
    except Exception as err:
        ex_data = str(Exception) + '\n'
        ex_data = ex_data + str(err) + '\n'
        ex_data = ex_data + traceback.format_exc()
        logger.error(ex_data)
        return json_response(status_=500, data=ERROR_MSG)

    return resp


@app.route("/open_api/<proc_name>", methods=['GET', 'POST'])
def exec_proc(proc_name):
    logger.debug(f"Call to {proc_name}")

    # set up the env
    init_new_env()

    # see if we can execute it.
    try:
        fn = getattr(__import__('open_calls.' + proc_name), proc_name)
        resp = fn.handle_request()
    except Exception as err:
        ex_data = str(Exception) + '\n'
        ex_data = ex_data + str(err) + '\n'
        ex_data = ex_data + traceback.format_exc()
        logger.error(ex_data)
        return json_response(status_=500, data=ERROR_MSG)

    return resp


# if __name__ == '__main__':
# app.run(debug=True)
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
