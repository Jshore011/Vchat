import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emojis/emojis.dart';

class IBMUtils {
  requestEmotionFromMessage(String message, String messageID, String userID, String conversationID) async {
    var response = await http.post(
      Uri.parse('http://52.116.29.131/open_api/NLU_API/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'message': message,
        'messageID': messageID,
        'userID': userID,
        'conversationID': conversationID,
      }),
    );

    if(response.statusCode == 200) {
      var emotionalAnalysis = jsonDecode(response.body);
      var emotion = emotionalAnalysis['message'];
      return emotion;
    }
    else {
      print("Failed to get response");
      return null;
    }
  }

  buildEmojiFromEmotion(String message) {
    late var emoji;

    switch(message) {
      case 'joy': { emoji = '${Emojis.smilingFaceWithSmilingEyes}'; }
      break;

      case 'anger': { emoji = '${Emojis.faceWithSymbolsOnMouth}'; }
      break;

      case 'sadness': { emoji = '${Emojis.cryingFace}'; }
      break;

      case 'fearful': { emoji = '${Emojis.faceScreamingInFear}'; }
      break;

      case 'anger': { emoji = '${Emojis.confoundedFace}'; }
      break;

      case 'Failed to get response' : { emoji = 'Emotional Analysis Failed'; }
      break;

      default: { emoji = '${Emojis.faceWithoutMouth}'; }
      break;
    }

    return emoji;
  }
}