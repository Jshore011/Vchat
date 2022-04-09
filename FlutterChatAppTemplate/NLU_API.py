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
    
key = '_J9y8uEfAGCf0-AGEwW-cj15eWxpEDnqFQnqBSSimkDv'#os.environ.get('IBM_API_KEY')
url = "https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/4c6d89e4-9a1a-41f2-962a-dc42e5854346"
    
authenticator = IAMAuthenticator(key)
natural_language_understanding = NaturalLanguageUnderstandingV1(
        version='2021-08-01',
        authenticator=authenticator
)
natural_language_understanding.set_service_url(url)
ibm_response = natural_language_understanding.analyze(
    text="Everytime I start to make progress, something happens that puts me back and wastes my time",
    features=Features(emotion=EmotionOptions(),
                          keywords=KeywordsOptions())).get_result()

print( json.dumps(ibm_response, indent=2))
#need to return the json file, still working on it. will reference existing Flask server example

data = ibm_response
for d in data:    
    print(d)
    if(d == "keywords"):
        print("keyword is: ", data[d])
        k_words = data[d]
        for k in k_words:
            print(k)
    if(d == "emotion"):
        print("emotion is: ", data[d])
        doc = data[d]
        for do in doc:
            emote = doc[do]
            for emo in emote:
                em = emote[emo]
                for e in em:
                    print(e)
