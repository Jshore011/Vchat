from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql
import json

from tools.logging import logger

def handle_request():
    logger.debug("Analytics Handle Request")

    requestDetails = request.get_json()
    logger.debug(requestDetails)

    usrID = requestDetails['usrID']
    #msgID = requestDetails['messageID']
    chtRmID = requestDetails['conversationID']
    
    cur = g.db.cursor()
       
    #query for most recent message in chatroom
    cur.execute(sql.SQL("SELECT emotions FROM emotions WHERE chtrmid = %s orderid = (SELECT MAX(orderid) FROM emotions);"),(chtRmID))
    msgEmotions = cur.fetchOne()
    
    #query for all user messages in a specific chatroom
    cur.execute(sql.SQL("SELECT topemotion FROM messages WHERE usrid = %s AND chtrmid = %s;"),(chtRmID,usrID))
    usrEmotions = cur.fetchAll()
    #query for ordered list of most used keywords used by user in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s AND usrid = %s GROUP BY keyword ORDER BY COUNT(keyword);"),(chtRmID,usrID))
    usrKeywords = cur.fetchAll()

    #query for all messages in a specific chatroom
    cur.execute(sql.SQL("SELECT topemotion FROM messages WHERE chtrmid = %s;"),(chtRmID))
    chtRmEmotions = cur.fetchAll()
    #query for ordered list of most used keywords in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s GROUP BY keyword ORDER BY COUNT(keyword);"),(chtRmID))
    chtRmKeywords = cur.fetchAll()
    
    data = '{"data":{"msgAnalytics":"'+str(msgEmotions)+'"},{"usrAnalytics":{"emotions:"'+str(usrEmotions)+'"},{"keywords":"'+str(usrKeywords)+'"}},{"chtRmAnalytics":{"emotions:"'+str(chtRmEmotions)+'"},{"keywords":"'+str(chtRmKeywords)+'"}}}'
    
    logger.debug(data)
    cur.close()
    
    return jsonify(data)
