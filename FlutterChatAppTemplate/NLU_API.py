import os
import json
from ibm_watson import NaturalLanguageUnderstandingV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_watson.natural_language_understanding_v1 import Features, EmotionOptions, KeywordsOptions

import requests as req

from flask import request, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
#from tools.token_tools import create_token
from psycopg2 import sql

import json

#from tools.logging import logger


#def handle_request():

#logger.debug("NLU Analysis Handle Request")

if 'IBM_API_KEY' in os.environ:
    print("yes")
key = '_J9y8uEfAGCf0-AGEwW-cj15eWxpEDnqFQnqBSSimkDv'
#print(os.environ.get('IBM_API_KEY'))
url = "https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/4c6d89e4-9a1a-41f2-962a-dc42e5854346"
    
authenticator = IAMAuthenticator(key)
natural_language_understanding = NaturalLanguageUnderstandingV1(
        version='2021-08-01',
        authenticator=authenticator
)
natural_language_understanding.set_service_url(url)
ibm_response = natural_language_understanding.analyze(
    text="I am really excited to go see the Red Hot Chili Peppers in June. They are one of my favorite bands! I hope that they play my favorite song 'Bicycle Song'",
    features=Features(emotion=EmotionOptions(),
                          keywords=KeywordsOptions())).get_result()

print( json.dumps(ibm_response, indent=2))

data = ibm_response

#parse response data
for d in data:    
    #print(d)
    if(d == "keywords"):
        
        k_words = data[d]
        print(len(k_words) , "keywords found")
        count = len(k_words)
        for i in range(count):
            print("Case: ", i)
            for words in k_words[i]:
                print('key is: ' + str(words) + ' and value is "' + str(k_words[i][words])+'"')

    
    if(d == "emotion"):
        print("Emotions Detected: ")
        #print("emotion is: ", data[d])
        doc = data[d]
        for do in doc:
            emote = doc[do]
            for emo in emote:
                em = emote[emo]
                score = 0
                for e in em:
                    print(e, em[e])
                    if(em[e] > score):
                        score = em[e]
                        top = e
                print("Overall Emotion: ", top)
#need to return the json file, still working on it. will reference existing Flask server example
