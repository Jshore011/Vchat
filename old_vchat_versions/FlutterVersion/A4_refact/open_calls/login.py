from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json

from tools.token_tools import create_token

from tools.logging import logger

def handle_request():

    logger.debug("Login Handle Request")
    #use data here to auth the user
    logger.debug(request.form['username'])
    logger.debug(request.form['password'])
    
    password_from_user_form = request.form['password']
    user = {
        "sub" : request.form['username'] #sub is used by pyJwt as the owner of the token
        }
    #content = request.json

    username = get_value_from_dict(content,"username")
    password = get_value_from_dict(content,"password")
    user = { "sub" : username }

    print(username, password)
    if not user:
        return json_response(status_ = 401, message = 'Invalid credentials', authenticated = False )

    return json_response(token = create_token(user), authenticated = False)
