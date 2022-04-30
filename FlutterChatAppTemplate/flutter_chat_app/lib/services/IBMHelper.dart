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
      var topEmotion = 'None';
      var analytics = jsonDecode(jsonDecode(response.body));
      var messageEmotions = analytics["data"][0]["msgAnalytics"]["emotions"];
      var emotionsAndScoresList = [];

      for (int i = 0; i < messageEmotions.length; i++) {
        if(i == messageEmotions.length - 1) {
          topEmotion = (messageEmotions[i]["top"]);
          break;
        }
        emotionsAndScoresList.add(messageEmotions[i]["emotion"]);
        print(messageEmotions[i]["emotion"]);
        emotionsAndScoresList.add(messageEmotions[i]["score"]);
        print(messageEmotions[i]["score"]);
      }

      return topEmotion;
    }
    else {
      print("Failed to get response");
      return null;
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
      var emotionsAndScoresList = [];
      var analytics = jsonDecode(jsonDecode(response.body));
      var messageEmotions = analytics["data"][0]["msgAnalytics"]["emotions"];
      for (int i = 0; i < messageEmotions.length; i++) {
        if (i == messageEmotions.length - 1) {
          break;
        }
        emotionsAndScoresList.add(messageEmotions[i]["emotion"]);
        print(messageEmotions[i]["emotion"]);
        var score = double.parse(messageEmotions[i]["score"]);
        score = score * 100;
        var stringScore = score.toStringAsFixed(3);
        emotionsAndScoresList.add(stringScore);
        print(stringScore);
      }

      return emotionsAndScoresList;
    }
    else {
      print("Failed to get response");
      return null;
    }
  }

  // requestTopEmotion(String conversationID, String userID) async {
  //   var response = await http.post(
  //     Uri.parse('http://52.116.29.131/open_api/Analytics/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'conversationID': conversationID,
  //       'userID': userID,
  //     }),
  //   );
  //
  //   if(response.statusCode == 200) {
  //     var analytics = jsonDecode(jsonDecode(response.body));
  //     var messageEmotions = analytics["data"][0]["msgAnalytics"]["emotions"];
  //     var emotionsAndScoresList = [];
  //     for (int i = 0; i < messageEmotions.length; i++) {
  //       if(i == messageEmotions.length - 1) {
  //         topEmotion = (messageEmotions[i]["top"]);
  //         break;
  //       }
  //       emotionsAndScoresList.add(messageEmotions[i]["emotion"]);
  //       print(messageEmotions[i]["emotion"]);
  //       emotionsAndScoresList.add(messageEmotions[i]["score"]);
  //       print(messageEmotions[i]["score"]);
  //     }
      // var userEmotions = analytics["data"][1]["usrAnalytics"][0]["emotions"];
      // List userEmotionList = [];
      // for (int i = 0; i < userEmotions.length; i++) {
      //   if(i == userEmotions.length - 1) {
      //     break;
      //   }
      //   userEmotionList.add(userEmotions[i]["emotion"]);
      //   print(userEmotions[i]["emotion"]);
      //   userEmotionList.add(userEmotions[i]["count"]);
      //   print(userEmotions[i]["count"]);
      // }

      // var userKeywords = analytics["data"][1]["usrAnalytics"][1]["keywords"];
      // List userKeywordList = [];
      // for (int i = 0; i < userKeywords.length; i++) {
      //   if(i == userKeywords.length - 1) {
      //     break;
      //   }
      //   userKeywordList.add(userKeywords[i]["keyword"]);
      //   print(userKeywords[i]["keyword"]);
      //   userKeywordList.add(userKeywords[i]["count"]);
      //   print(userKeywords[i]["count"]);
      // }

      // var chatroomEmotions = analytics["data"][2]["chtRmAnalytics"][0]["emotions"];
      // List chatroomEmotionList = [];
      // for (int i = 0; i < chatroomEmotions.length; i++) {
      //   if(i == chatroomEmotions.length - 1) {
      //     break;
      //   }
      //   chatroomEmotionList.add(chatroomEmotions[i]["emotion"]);
      //   print(chatroomEmotions[i]["emotion"]);
      //   chatroomEmotionList.add(chatroomEmotions[i]["count"]);
      //   print(chatroomEmotions[i]["count"]);
      // }

      // var chatroomKeywordList = analytics["data"][2]["chtRmAnalytics"][1]["keywords"];
      // List chatroomKeywords = [];
      // for (int i = 0; i < chatroomKeywordList.length; i++) {
      //   if(i == chatroomKeywordList.length - 1) {
      //     break;
      //   }
      //   chatroomKeywords.add(chatroomKeywordList[i]["keyword"]);
      //   print(chatroomKeywordList[i]["keyword"]);
      // }
    //   print(topEmotion);
    //   return topEmotion;
    // }
    // else {
    //   print("Failed to get response");
    //   return null;
    // }
  // }
}





