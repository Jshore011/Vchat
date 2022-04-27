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

  requestAnalytics(String conversationID, String userID) async {
    var response = await http.post(
      Uri.parse('http://52.116.29.131/open_api/Analytics/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'conversationID': conversationID,
        'userID': userID,
      }),
    );

    if(response.statusCode == 200) {
      var analytics = jsonDecode(response.body);
      print(analytics);
      return analytics;
    }
    else {
      print("Failed to get response");
      return null;
    }
  }
}
