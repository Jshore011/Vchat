# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

# URL: https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/6d20155f-b189-4609-bcb1-fcce7343e170
# API key: dE0gX9pcJjBTYdU6oydbWiHNamf2GD249FhffntYniV6
'''
pip install --upgrade "ibm-watson>=5.3.1"


'''

from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_watson import ToneAnalyzerV3, ApiException
import json

version = '2017-09-21'
key = 'dE0gX9pcJjBTYdU6oydbWiHNamf2GD249FhffntYniV6'
url = 'https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/6d20155f-b189-4609-bcb1-fcce7343e170'
auth = IAMAuthenticator(key)
tone_analyzer = ToneAnalyzerV3(
    version=version,
    authenticator=auth
)

tone_analyzer.set_service_url(url)

try:
    #invoke method
    text = 'Team, I know that times are tough! Product ' \
           'sales have been disappointing for the past three ' \
           'quarters. We have a competitive product, but we ' \
           'need to do a better job of selling it!'

    tone_analysis = tone_analyzer.tone(
        {'text': text},
        content_type='application/json'
    ).get_result()
    print(json.dumps(tone_analysis, indent=2))

except ApiException as ex:
    print("Method failed with a status code " + str(ex.code) + ": " +ex.message)