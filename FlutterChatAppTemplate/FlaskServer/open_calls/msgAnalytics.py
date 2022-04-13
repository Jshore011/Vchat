from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql
import json

from tools.logging import logger


def handle_request():
    logger.debug("Message Analytics Handle Request")

    user = request.args.get('usrID')
    msgID = request.args.get('msgID')
    chtRmID = request.args.get('chtRmID')
    
    cur = g.db.cursor()
    cur.execute(sql.SQL("SELECT * FROM keywords AND emotions WHERE msgID = %S AND chtRmID = %S;",(msgID, chtRmID)))

    analytics = cur.fetchall()


    
