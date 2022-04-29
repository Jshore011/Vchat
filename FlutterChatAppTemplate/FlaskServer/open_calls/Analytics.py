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
    emotions = ['joy','sadness','disgust','anger','fear']

    #query for most recent message in chatroom
    cur.execute(sql.SQL("SELECT emotions FROM emotions WHERE chtrmid = %s AND orderid =(select  MAX(orderid) from emotions);"),(chtRmID,))
    msgEmotions = cur.fetchone()
    msgEmotions = msgEmotions[0]
    logger.debug(msgEmotions)
    
    
    #query for all user messages in a specific chatroom
    cur.execute(sql.SQL("SELECT DISTINCT topemotion, COUNT(topemotion) FROM messages WHERE usrid = %s AND chtrmid = %s GROUP BY topemotion;"),(usrID, chtRmID))
    usrEmotions = cur.fetchall()
    userEmotions = '['
    for e in emotions:
        #userEmotions += '{"'+str(e)+'":"'
        for us in usrEmotions:
            logger.debug(us)
            if us[0] == e:
                userEmotions += '{"emotion":"'+str(e)+'","count":"'+str(us[1])+'"},'
            else:
                continue
    userEmotions += '{"None":""}]'
            
    logger.debug(userEmotions)
    #query for ordered list of most used keywords used by user in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s AND usrid = %s GROUP BY keyword ORDER BY COUNT(keyword) DESC;"),(chtRmID,usrID))
    usrKeywords = cur.fetchall()
    userKeys = '['
    for uk in usrKeywords:
        logger.debug(uk)
        userKeys += '{"keyword":"'+str(uk[0])+'","count":"'+str(uk[1])+'"},'
    userKeys += '{"None":""}]'

    #query for all messages in a specific chatroom
    cur.execute(sql.SQL("SELECT DISTINCT topemotion, COUNT(topemotion) FROM messages WHERE chtrmid = %s GROUP BY topemotion;"),(chtRmID,))
    chtRmEmotions = cur.fetchall()
    chatEmotions = '['
    for e in emotions:
        #userEmotions += '{"'+str(e)+'":"'
        for ch in chtRmEmotions:
            logger.debug(ch)
            if ch[0] == e:
                chatEmotions += '{"emotion":"'+str(e)+'","count":"'+str(ch[1])+'"},'
            else:
                continue
    chatEmotions += '{"None":""}]'

    #query for ordered list of most used keywords in chatroom
    cur.execute(sql.SQL("SELECT DISTINCT keyword, COUNT(keyword) FROM keywords WHERE chtrmid = %s GROUP BY keyword ORDER BY COUNT(keyword) DESC;"),(chtRmID,))
    chtRmKeywords = cur.fetchall()
    chatKeys = '['
    for ck in chtRmKeywords:
        logger.debug(ck)
        chatKeys += '{"keyword":"'+str(ck[0])+'","count":"'+str(ck[1])+'"},'
    chatKeys += '{"None":""}]'

    data = '{"data":[{"msgAnalytics":'+str(msgEmotions)+'},{"usrAnalytics":[{"emotions":'+str(userEmotions)+'},{"keywords":'+str(userKeys)+'}]},{"chtRmAnalytics":[{"emotions":'+str(chatEmotions)+'},{"keywords":'+str(chatKeys)+'}]}]}'
    
    logger.debug(data)
    cur.close()
    
    return jsonify(data)
