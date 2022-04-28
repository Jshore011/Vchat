from flask import request, g, jsonify
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql
import json

from tools.logging import logger

def handle_request():
    logger.debug("Analytics Handle Request")

    requestDetails = request.get_json()
    logger.debug(requestDetails)

    usrID = requestDetails['userID']
    
    chtRmID = requestDetails['conversationID']
    
    cur = g.db.cursor()
       
    #query for most recent message in chatroom
    cur.execute(sql.SQL("SELECT emotions FROM emotions WHERE chtrmid = %s AND orderid =(select  MAX(orderid) from emotions);"),(chtRmID,))
    msgEmotions = cur.fetchone()
    logger.debug(msgEmotions)
    
    #query for all user messages in a specific chatroom
    cur.execute(sql.SQL("SELECT topemotion FROM messages WHERE usrid = %s AND chtrmid = %s;"),(usrID, chtRmID))
    usrEmotions = cur.fetchall()
    #query for ordered list of most used keywords used by user in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s AND usrid = %s GROUP BY keyword ORDER BY COUNT(keyword) DESC;"),(chtRmID,usrID))
    usrKeywords = cur.fetchall()

    #query for all messages in a specific chatroom
    cur.execute(sql.SQL("SELECT topemotion FROM messages WHERE chtrmid = %s;"),(chtRmID,))
    chtRmEmotions = cur.fetchall()
    #query for ordered list of most used keywords in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s GROUP BY keyword ORDER BY COUNT(keyword) DESC;"),(chtRmID,))
    chtRmKeywords = cur.fetchall()
    
    data = '{"data":{"msgAnalytics":"'+str(msgEmotions)+'"},{"usrAnalytics":{"emotions:"'+str(usrEmotions)+'"},{"keywords":"'+str(usrKeywords)+'"}},{"chtRmAnalytics":{"emotions:"'+str(chtRmEmotions)+'"},{"keywords":"'+str(chtRmKeywords)+'"}}}'
    
    logger.debug(data)
    cur.close()
    
    return jsonify(data)
