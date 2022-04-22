import 'dart:convert';
import 'package:http/http.dart' as http;

class IBMUtils {
  messageEmotionRequest(String message, String userID, String conversationID) async {
    var response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      // Uri.parse('http://52.116.29.131/open_api/NLU_API'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'message': message,
        'userID': userID,
        'conversationID': conversationID,
      }),
    );

    if(response.statusCode == 201) {
      var emotionalAnalysis = jsonDecode(response.body);
      var emotion = emotionalAnalysis['message'];
      return emotion;
    }
    else {
      print("Failed to get response");
      return null;
    }
  }
}