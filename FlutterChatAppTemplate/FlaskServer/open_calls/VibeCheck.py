from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql
import json

from tools.logging import logger


def handle_request():
    logger.debug("Vibe Check Handle Request")

    #userID should be sent from mobile app frontend
    usrID = request.get_json()
    
    #vibe check queries the database for all chatrooms participated in by user
    cur = g.db.cursor()
    #query gets all chatrooms user participates in                DELETE this query after testing 
    #cur.execute(sql.SQL("select chtrmid from chatroom where usrid = %s;"),(usrID))
    
    #query gets all chatrooms user participates in ordered by recent activity
    cur.execute(sql.SQL("select DISTINCT chtrmid from messages where usrid = %s ORDER BY orderid DESCENDING;"),(usrID))
    chatrooms = cur.fetchAll()

    data= '{"chatrooms":['

    for c in chatrooms:
	data += '{"chatroomid":"'+str(c)+'","emotion":'
	current = 0
	count = 0
	top = ''
	emotions = ['joy','sadness','fear', 'anger', 'disgust']
	for e in emotions:
            cur.execute(sql.SQL("select COUNT(*) from messages where chtrmid = %s and topemotion = %s;", (c, e)
	    current = fetchOne()
	    if current > count:
                count = current
                top = e
	data += '"'+str(top)+'"},'
    data += '{"None":""}]}'
	
    return jsonify(data)
