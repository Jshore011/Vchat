import zope.interface
import json
from ibm_watson import NaturalLanguageUnderstandingV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_watson.natural_language_understanding_v1 import Features, EmotionOptions, KeywordsOptions
class IBM_Interface(zope.interface.Interface):
     def get_emotion(self, text):
        pass
    def get_keywords(self, text):
        pass


