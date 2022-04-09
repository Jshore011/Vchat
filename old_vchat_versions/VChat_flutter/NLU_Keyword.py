import json
from ibm_watson import NaturalLanguageUnderstandingV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_watson.natural_language_understanding_v1 import Features, EmotionOptions, KeywordsOptions

authenticator = IAMAuthenticator('_J9y8uEfAGCf0-AGEwW-cj15eWxpEDnqFQnqBSSimkDv')
natural_language_understanding = NaturalLanguageUnderstandingV1(
    version='2021-08-01',
    authenticator=authenticator
)
natural_language_understanding.set_service_url(
    'https://api.us-south.natural-language-understanding.watson.cloud.ibm.com/instances/4c6d89e4-9a1a-41f2-962a'
    '-dc42e5854346%27')

# def getKeywords(String txt):
response = natural_language_understanding.analyze(
    text="Here we go again, this is a test" 
         " for some reason keyword analysis does emotion recognition too ",
    features=Features(keywords=KeywordsOptions(sentiment=True, emotion=True, limit=10))).get_result()

print("Keyword analysis: " + json.dumps(response, indent=2))
#    return response
