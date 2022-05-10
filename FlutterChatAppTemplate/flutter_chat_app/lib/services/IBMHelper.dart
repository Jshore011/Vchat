import 'dart:convert';
import 'package:http/http.dart' as http;

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
      return 'message failed to send';
    }
  }

  requestTopEmotion(String conversationID, String userID) async {
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
      String topEmotion = 'None';
      var analytics = jsonDecode(jsonDecode(response.body));
      var messageEmotions = analytics["data"][0]["msgAnalytics"]["emotions"];
      var emotionsAndScoresList = [];

      for (int i = 0; i < messageEmotions.length; i++) {
        if(i == messageEmotions.length - 1) {
          topEmotion = (messageEmotions[i]["top"]);
          break;
        }
        emotionsAndScoresList.add(messageEmotions[i]["emotion"]);
        emotionsAndScoresList.add(messageEmotions[i]["score"]);
      }
      return topEmotion;
    }
    else {
      print("Failed to get response");
      return '';
    }
  }

  requestEmotionsScores(String conversationID, String userID) async {
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

    if (response.statusCode == 200) {
      List emotionsAndScoresList = [];
      var analytics = jsonDecode(jsonDecode(response.body));
      var messageEmotions = analytics["data"][0]["msgAnalytics"]["emotions"];
      for (int i = 0; i < messageEmotions.length; i++) {
        if (i == messageEmotions.length - 1) {
          break;
        }
        emotionsAndScoresList.add(messageEmotions[i]["emotion"]);
        var score = double.parse(messageEmotions[i]["score"]);
        score = score * 100;
        var stringScore = score.toStringAsFixed(3);
        emotionsAndScoresList.add(stringScore);
      }
      return emotionsAndScoresList;
    }
    else {
      print("Failed to get response");
      return [];
    }
  }

  requestUserEmotionCount(String conversationID, String userID) async {
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

    if (response.statusCode == 200) {
      List userEmotionsList = [];
      var analytics = jsonDecode(jsonDecode(response.body));
      var userEmotions = analytics["data"][1]["usrAnalytics"][0]["emotions"];
      for (int i = 0; i < userEmotions.length; i++) {
        if(i == userEmotions.length - 1) {
          break;
        }
        userEmotionsList.add(userEmotions[i]["emotion"]);
        userEmotionsList.add(userEmotions[i]["count"]);
      }
      print(userEmotionsList);
      return userEmotionsList;
    }
    else {
      print("Failed to get response");
      return [];
    }
  }

  requestUserKeywords(String conversationID, String userID) async {
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
    if (response.statusCode == 200) {
      List userKeywordsList = [];
      var analytics = jsonDecode(jsonDecode(response.body));
      var userKeywords = analytics["data"][1]["usrAnalytics"][1]["keywords"];
      for (int i = 0; i < userKeywords.length; i++) {
        if(i == userKeywords.length - 1) {
          break;
        }
        userKeywordsList.add(userKeywords[i]["keyword"]);
        print(userKeywords[i]["keyword"]);
      }
      return userKeywordsList;
    }
    else {
      print("Failed to get response");
      return [];
    }
  }

  requestChatroomEmotionCount(String conversationID, String userID) async {
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
      List chatroomEmotionList = [];
      var analytics = jsonDecode(jsonDecode(response.body));
      var chatroomEmotions = analytics["data"][2]["chtRmAnalytics"][0]["emotions"];
      for (int i = 0; i < chatroomEmotions.length; i++) {
        if(i == chatroomEmotions.length - 1) {
          break;
        }
        chatroomEmotionList.add(chatroomEmotions[i]["emotion"]);
        chatroomEmotionList.add(chatroomEmotions[i]["count"]);
      }
      print(chatroomEmotionList);
      return chatroomEmotionList;
    } else {
      print("Failed to get response");
      return [];
    }
  }

    requestChatroomKeywords(String conversationID, String userID) async {
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
    if (response.statusCode == 200) {
      List chatroomKeywordsList = [];
      var analytics = jsonDecode(jsonDecode(response.body));
      var chatroomKeywords = analytics["data"][2]["chtRmAnalytics"][1]["keywords"];
      for (int i = 0; i < chatroomKeywords.length; i++) {
        if(i == chatroomKeywords.length - 1) {
          break;
        }
        chatroomKeywordsList.add(chatroomKeywords[i]["keyword"]);
      }
      return chatroomKeywordsList;
    }
    else {
      print("Failed to get response");
      return [];
    }
  }
}





