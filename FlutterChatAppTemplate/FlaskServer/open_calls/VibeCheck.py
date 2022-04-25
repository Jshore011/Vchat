from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql
import json

from tools.logging import logger


def handle_request():
    logger.debug("Vibe Check Handle Request")

    usrID = request.get_json()
    
    #vibe check = top counted top emotion

    #home all chatrooms displayed
    #--> req Vibecheck
    cur = g.db.cursor()
    cur.execute(sql.SQL("select chtrmid from chatroom where usrid = %s;"),(usrID))
    chatrooms = cur.fetchAll()

    data= '{"chatrooms":"'
    for c in chatrooms:
	data += '{"chatroomid":"'+str(chatrooms[c])+'",emotion":'
	current = 0
	count = 0
	top = ''
	emotions = [joy,sadness,fear, anger, disgust]
	for e in emotions:
            cur.execute(sql.SQL("select COUNT(*) from messages where chtrmid = %s and topemotion = %s;", (chtRmID[],emotions[e])
	    current = fetchOne()
	    if current > count:
                count = current
                top = emotions[e]
	data += '"'+str(top)+'"},'
    data += '{"None":""}'
	
    return jsonify(data)
