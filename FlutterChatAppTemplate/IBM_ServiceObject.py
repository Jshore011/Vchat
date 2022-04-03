import os
import zope.interface
import IBM_Interface
import json
from ibm_watson import NaturalLanguageUnderstandingV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_watson.natural_language_understanding_v1 import Features, EmotionOptions, KeywordsOptions

@zope.interface.Implementer(IBM_Interface)
class IBM_ServiceObject:
    key = os.environ.get('IBM_API_KEY')
    authenticator = IAMAuthenticator(key)
    natural_language_understanding = NaturalLanguageUnderstandingV1(
        version='2021-08-01',
        authenticator=authenticator
    )
    natural_language_understanding.set_service_url(
        "https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/4c6d89e4-9a1a-41f2-962a-\
dc42e5854346")

    text = "Test this out please"
    def get_emotion(self, text):
        e_response = natural_language_understanding.analyze(
            {text},
            features=Features(emotion=EmotionOptions())).get_result()

        print("Emotion analysis: " + json.dumps(e_response, indent=2))
        return e_response

    def get_keywords(self, text):
        k_response = natural_language_understanding.analyze(
            {text},
            features=Features(keywords=KeywordsOptions(sentiment=True, emotion=True, limit=10))).get_result()

        print("Keyword analysis: " + json.dumps(k_response, indent=2))
        return k_response
