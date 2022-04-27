from flask import request, g, jsonify
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql
import json

from tools.logging import logger

def handle_request():
    logger.debug("Analytics Handle Request")

    #requestDetails = request.get_json()
    #logger.debug(requestDetails)

    usrID = 'Bmlnlw6bPhsyfSSw9Vta'#requestDetails['userID']
    
    chtRmID = 'ppYgiYl1eKYkm9mX6axlBs0yCqr1'#requestDetails['conversationID']
    
    cur = g.db.cursor()
       
    #query for most recent message in chatroom
    # AND orderid = (SELECT MAX(orderid) FROM emotions)
    cur.execute(sql.SQL("SELECT * FROM emotions WHERE chtrmid = %s;"),(chtRmID,))
    msgEmotions = cur.fetchone()
    
    #query for all user messages in a specific chatroom
    cur.execute(sql.SQL("SELECT topemotion FROM messages WHERE usrid = %s AND chtrmid = %s;"),(usrID, chtRmID))
    usrEmotions = cur.fetchall()
    #query for ordered list of most used keywords used by user in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s AND usrid = %s GROUP BY keyword ORDER BY COUNT(keyword);"),(chtRmID,usrID))
    usrKeywords = cur.fetchall()

    #query for all messages in a specific chatroom
    cur.execute(sql.SQL("SELECT topemotion FROM messages WHERE chtrmid = %s;"),(chtRmID,))
    chtRmEmotions = cur.fetchall()
    #query for ordered list of most used keywords in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s GROUP BY keyword ORDER BY COUNT(keyword);"),(chtRmID,))
    chtRmKeywords = cur.fetchall()
    
    data = '{"data":{"msgAnalytics":"'+str(msgEmotions)+'"},{"usrAnalytics":{"emotions:"'+str(usrEmotions)+'"},{"keywords":"'+str(usrKeywords)+'"}},{"chtRmAnalytics":{"emotions:"'+str(chtRmEmotions)+'"},{"keywords":"'+str(chtRmKeywords)+'"}}}'
    
    logger.debug(data)
    cur.close()
    
    return jsonify(data)
