from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql
import json

from tools.logging import

def handle_request():
    logger.debug("Add analytics to database Handle Request")

    msgID = request.args.get('msgID')
    chtRmID = request.args.get('chtRmID')
    usrID = request.args.get('usrID')
    emotions = request.args.get(message.emotions)
    keywords = request.args.get(message.keywords)
    response = ''
    
    cur = g.db.cursor()
    for k in keywords:
        cur.execute(sql.SQL("INSERT INTO keywords (keyword, msgID, chtRmID, usrID) VALUES(%S,%S,%S,%S);"),(keywords[i],msgID,ctRmID,usrID))
        response += "successfully added keywords"

    for e in emotions:
        cur.execute(sql.SQL("INSERT INTO keywords (keyword, msgID, chtRmID, usrID) VALUES(%S,%S,%S,%S);"),(emotions.emotion[i],msgID,ctRmID,usrID))

        cur.close()
        g.db.commit()

        response += ", successfully added emotions"

    if len(response) < 1:
        response += "nohing added"
    elif len(response) < 26:
        response += ", we missed emotions along the way"

    return response
