from ibm_watson import SpeechToTextV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator

api = IAMAuthenticator("ZETDrS6IQQYaflhJx_VSRz4p7Cah1a8g-AtB6FEkDeR6")
speech_2_text = SpeechToTextV1(authenticator=api)
speech_2_text.set_service_url("https://api.us-south.speech-to-text.watson.cloud.ibm.com/instances/6c7380dc-4f1d-4779"
                              "-a22e-dbaa0bf9ffc7")
with open("./audio-file.mp3", "rb") as audio_file:
    result = speech_2_text.recognize(audio=audio_file, content_type="audio/flac").get_result()
    print(result)
