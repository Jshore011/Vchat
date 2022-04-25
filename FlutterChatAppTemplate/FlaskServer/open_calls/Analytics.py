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

    cur.execute(sql.SQL("SELECT COUNT(*) FROM keywords WHERE chtrmid = %s;"),(chtRmID))
    keyCount = cur.fetchOne()
    
    #query for most recent message in chatroom
    cur.execute(sql.SQL("SELECT emotions FROM emotions WHERE chtrmid = %s AND max(orderID);"),(chtRmID))
    msgEmotions = cur.fetchOne()
    
    #query for all user messages in a specific chatroom
    cur.execute(sql.SQL("SELECT emotions FROM emotions WHERE chtrmid = %s AND usrid = %s;"),(chtRmID,usrID))
    usrEmotions = cur.fetchAll()
    cur.execute(sql.SQL("SELECT keyword FROM keywords WHERE chtrmid = %s AND usrid = %s;"),(chtRmID,usrID))
    usrKeywords = cur.fetchAll()

    #query for all messages in a specific chatroom
    cur.execute(sql.SQL("SELECT emotions FROM emotions WHERE chtrmid = %s;"),(chtRmID))
    chtRmEmotions = cur.fetchAll()
    cur.execute(sql.SQL("SELECT keyword FROM keywords WHERE chtrmid = %s;"),(chtRmID))
    chtRmKeywords = cur.fetchAll()
    
    data = '{"data":{"msgAnalytics":"'+str(msgEmotions)+'"},{"usrAnalytics":{"emotions:"'+str(usrEmotions)+'"},{"keywords":"'+str(usrKeywords)+'"}},{"chtRmAnalytics":{"emotions:"'+str(chtRmEmotions)+'"},{"keywords":"'+str(chtRmKeywords)+'"}}}'
    
    logger.debug(data)
    cur.close()
    
    return jsonify(data)
