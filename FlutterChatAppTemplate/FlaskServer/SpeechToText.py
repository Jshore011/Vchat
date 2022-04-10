import os

from ibm_watson import SpeechToTextV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
import pyrebase


config = {
    "apiKey": "AIzaSyCjMU8ankorPuxvYnxQpbk5hX1a0ZjvwSk",
    "authDomain": "vchat-37136.firebaseapp.com",
    "databaseURL": "https://vchat-37136-default-rtdb.firebaseio.com",
    "projectId": "vchat-37136",
    "storageBucket": "vchat-37136.appspot.com",
    "messagingSenderId": "993893663736",
    "appId": "1:993893663736:web:2133ebf4902f239c6dcc0d",
    "measurementId": "G-7P8B3NR1HY",
    "serviceAccount": "serviceAccountKeyForPython.json"
}

firebase_storage = pyrebase.initialize_app(config)
storage = firebase_storage.storage()

storage.child("tornado.mp3").put("audio-file.mp3") #in goes audio-file saves as tornado on firebase
storage.child("tornado.mp3").download("tornado2.mp3") #out comes tornado from firebase saved as tornado2 locally



api = IAMAuthenticator("ZETDrS6IQQYaflhJx_VSRz4p7Cah1a8g-AtB6FEkDeR6")
speech_2_text = SpeechToTextV1(authenticator=api)
speech_2_text.set_service_url("https://api.us-south.speech-to-text.watson.cloud.ibm.com/instances/6c7380dc-4f1d-4779"
                              "-a22e-dbaa0bf9ffc7")
with open("./tornado2.mp3", "rb") as audio_file:
    result = speech_2_text.recognize(audio=audio_file).get_result()
    print(result)
