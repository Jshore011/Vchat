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
    
    #query gets all chatrooms user participates in ordered by recent activity
    cur.execute(sql.SQL("select distinct chtrmid from (select order_id, chtrmid from messages where usrid = %s order by order_id)as chatrooms"),(usrID,))
    chatrooms = cur.fetchall()

    data = '{"chatrooms":['

    for c in chatrooms:
        data += '{"chatroomid":"'+str(c)+'","emotion":'
        current = 0
        count = 0
        top = ''
        emotions = ['joy','sadness','fear', 'anger', 'disgust']
        for e in emotions:
            cur.execute(sql.SQL("select COUNT(topemotion) from messages where chtrmid = %s and topemotion = %s;"), (c, e))
            current = cur.fetchone()
            if current > count:
                count = current
                top = e
            data += '"'+str(top)+'"},'
    data += '{"None":""}]}'
	
    return jsonify(data)
