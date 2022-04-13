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
print("made it here")
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
    text="My milkshake brings all the boys to the yard. And they're like, it's better than yours. You're damn right, it's better than yours. I could teach you, but I'd have to charge.",
    features=Features(emotion=EmotionOptions(),
                      keywords=KeywordsOptions())).get_result()

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
                    if(em[e] > score):
                        emotions += '{"emotion":"'+ str(e) + ', "score":"' + str(em[e]) + '"},'
                        score = em[e]
                        top = e
                        print("Overall Emotion: ", top)
            emotions += '{"top":"' + str(top) + '"}]}'
print(keys)
print(emotions)
                                #need to return the json file, still working on it. will reference existing Flask server example
                                #    return json_response(data= json.loads(keys, strict = False), data2= json.loads(emotions, strict = False)) 
