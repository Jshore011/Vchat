import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../services/IBMHelper.dart';
import '../../services/helper.dart';
import 'TranscribeAnalytics.dart';
import 'ChatroomAnalytics.dart';
import 'UserAnalytics.dart';

class AnalyticsScreen extends StatefulWidget {
  final String conversationID;
  final String userID;

  const AnalyticsScreen({Key? key, required this.conversationID, required this.userID}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getPage(int index, String transcribeTopEmotion, List transcribeEmotionsAndScores, List userEmotionCount, List userKeywords, List chatroomEmotionCount, List chatroomKeywords) {
    switch (index){
      case 1:
        return ChatroomAnalytics(chatroomEmotionCount: chatroomEmotionCount, chatroomKeywordsList: chatroomKeywords);
      case 2:
        return UserAnalytics(userEmotionCount: userEmotionCount, userKeywordsList: userKeywords);
      default:
        return TranscribeAnalytics(transcribeTopEmotion: transcribeTopEmotion, transcribeEmotionsAndScores: transcribeEmotionsAndScores);
    }
  }

  Future<String> getTranscribeTopEmotion() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var topEmotion = await _ibmUtils.requestTopEmotion(widget.conversationID, widget.userID);
    return topEmotion;
  }

  Future<List> getTranscribeEmotionsScores() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var emotionsScores = await _ibmUtils.requestEmotionsScores(widget.conversationID, widget.userID);
    return emotionsScores;
  }

  Future<List> getUserEmotionCount() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var userEmotionList = await _ibmUtils.requestUserEmotionCount(widget.conversationID, widget.userID);
    return userEmotionList;
  }

  Future<List> getUserKeywords() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var userKeywords = await _ibmUtils.requestUserKeywords(widget.conversationID, widget.userID);
    return userKeywords;
  }

  Future<List> getChatroomEmotionCount() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var chatroomEmotionList = await _ibmUtils.requestChatroomEmotionCount(widget.conversationID, widget.userID);
    return chatroomEmotionList;
  }

  Future<List> getChatroomKeywords() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var chatroomKeywords = await _ibmUtils.requestChatroomKeywords(widget.conversationID, widget.userID);
    return chatroomKeywords;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder (
      future: Future.wait([getTranscribeTopEmotion(), getTranscribeEmotionsScores(), getUserEmotionCount(), getUserKeywords(), getChatroomEmotionCount(), getChatroomKeywords()]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          return Scaffold(
            appBar: AppBar (
              actionsIconTheme: IconThemeData(
                color: isDarkMode(context) ? Colors.grey.shade200 : Colors.white),
                iconTheme: IconThemeData(
                    color: isDarkMode(context) ? Colors.grey.shade200 : Colors.white),
                title: Text('Analytics'),
                centerTitle: true,
                backgroundColor: Color(COLOR_PRIMARY),
            ),
            body: getPage(currentIndex, snapshot.data[0], snapshot.data[1], snapshot.data[2], snapshot.data[3], snapshot.data[4], snapshot.data[5]),
            bottomNavigationBar: BottomNavigationBar (
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(COLOR_PRIMARY),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,
              showUnselectedLabels: false,
              onTap: (index) => setState(() {
                currentIndex  = index;
              }),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Transcribe',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.groups),
                  label: 'Chatroom',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'User',
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}

