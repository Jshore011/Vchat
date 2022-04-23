import os
import json
from ibm_watson import NaturalLanguageUnderstandingV1, ApiException
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_watson.natural_language_understanding_v1 import Features, EmotionOptions, KeywordsOptions, SentimentOptions

import requests as req

from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
from tools.token_tools import create_token
from psycopg2 import sql

import json

from tools.logging import logger

def handle_request():

    logger.debug("NLU Analysis Handle Request")
    
    content = request.get_json()
    logger.debug(content)
    message = content.message
    
    if message is None or len(message) < 1:
    
        response = "audio message recieved"
        logger.debug(response)
        return response

    logger.debug("transcript received: " + str(message))

    cur = g.db.cursor()
    
    #post request data
    msgID = message.messageID
    usrID = message.userID
    chtRmID = message.conversationID


    #message table insert
    cur.execute(sql.SQL("INSERT INTO messages (msgID, usrID, chatroomID, transcript) VALUES (%s, %s, %s, %s);"),(msgID, usrID, chtRmID, message))
    #chatroom table insert
    cur.execute(sql.SQL("INSERT INTO  chatroom (%s, %s, %s);"),(chtRmID,msgID, usrID))

                
    #IBM credentials
    key = '_J9y8uEfAGCf0-AGEwW-cj15eWxpEDnqFQnqBSSimkDv'
    url = "https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/4c6d89e4-9a1a-41f2-962a-dc42e5854346"

    authenticator = IAMAuthenticator(key)
    natural_language_understanding = NaturalLanguageUnderstandingV1(
        version='2021-08-01',
        authenticator=authenticator
    )
    natural_language_understanding.set_service_url(url)

    #API call for NLU Emotion and Keyword Analysis
    try:
        ibm_response = natural_language_understanding.analyze(
            text= str(message),
            features=Features(emotion=EmotionOptions(),
                          keywords=KeywordsOptions(), sentiment=SentimentOptions())).get_result()

        print(json.dumps(ibm_response, indent=2))

        data = ibm_response

        #parse response data
        for d in data:    
            
            if(d == "keywords"):
            
                k_words = data[d]
                print(len(k_words) , "keywords found")
                count = len(k_words)
                keys = '{"keywords":['
                print("Adding keywords")

                for i in range(count):
                    print("Case: ", i)

                    for words in k_words[i]:
                        print('key is: ' + str(words) + ' and value is "' + str(k_words[i][words])+'"')

                        if(words == 'text'):
                            keys += '{"keyword":"'+str(k_words[i][words])+'"},'
                            cur.execute(sql.SQL("INSERT INTO keywords (msgID, usrID, chatroomID, keyword) VALUES (%s, %s, %s, %s);"),(msgID, usrID, chtRmID, k_words[i][words]))

                keys += '{"end":"none"}]}'
                    
            if(d == "emotion"):
                print("Emotions Detected: ")

                #print("emotion is: ", data[d])
                doc = data[d]
                emotions = '{"emotions":['
                for do in doc:
                    emote = doc[do]

                    for emo in emote:
                        em = emote[emo]
                        score = 0

                        for e in em:
                            print(e, em[e])
                            emotions += '{"emotion":"'+ str(e) + '", "score":"' + str(em[e]) + '"},'
                            cur.execute(sql.SQL("INSERT INTO emotion (msgID, usrID, chatroomID, emotion,confidence) VALUES (%s, %s, %s, %s, %d);"),(msgID, usrID, chtRmID, e, em[e]))
                                        
                            if(em[e] > score):
                            
                                score = em[e]
                                top = e
                emotions += '{"top":"' + str(top) + '"}]}'
                print("Overall Emotion: ", top)
                                                
        print(keys)
        print(emotions)
    
        return json_response(data= json.loads(keys, strict = False), data2= json.loads(emotions, strict = False))
    except ApiException as ex:
        print("Method failed with status code " + str(ex.code) + ": " + ex.message)
        return ex.code, ex.message
    
