import 'package:flutter/material.dart';
import 'package:instachatty/ui/analytics/wordCloud/KeywordTagCloud.dart';
import 'barchart/emotionBarChart.dart';

class ChatroomAnalytics extends StatefulWidget {
  final chatroomEmotionCount;
  final chatroomKeywordsList;

  const ChatroomAnalytics({Key? key, required this.chatroomEmotionCount, this.chatroomKeywordsList}) : super(key: key);

  @override
  _ChatroomAnalyticsState createState() => _ChatroomAnalyticsState();
}

class _ChatroomAnalyticsState extends State<ChatroomAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center (
        child: widget.chatroomEmotionCount.isNotEmpty && widget.chatroomKeywordsList.isNotEmpty ?
        ListView (
          scrollDirection: Axis.horizontal,
          children: [
            Container (
              width: MediaQuery.of(context).size.width,
              child: Column (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container (
                      color: Colors.teal,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text (
                          'Chatroom Overall Emotion Count',
                          style: TextStyle(color: Colors.white)
                      )
                  ),
                  Padding (
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: EmotionBarChart(emotionCount: widget.chatroomEmotionCount)
                  ),
                  Container (
                      color: Colors.teal,
                      height: 30,
                      alignment: Alignment.center,
                      child: Text (
                          'SWIPE LEFT for Chatroom Keyword Tag Cloud',
                          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)
                      )
                  ),
                ]
              )
            ),
            Container (
                width: MediaQuery.of(context).size.width,
                child: Column (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container (
                          color: Colors.teal,
                          height: 40,
                          alignment: Alignment.center,
                          child: Text (
                              'Chatroom Keyword Tag Cloud',
                              style: TextStyle(color: Colors.white)
                          )
                      ),
                      Padding (
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: KeywordTagCloud(keywordsList: widget.chatroomKeywordsList)
                      ),
                      Container (
                          color: Colors.teal,
                          height: 30,
                          alignment: Alignment.center,
                          child: Text (
                              'SWIPE RIGHT for Chatroom Overall Emotion Count',
                              style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)
                          )
                      ),
                    ]
                )
            )
          ]
        ) :
        Padding (
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text (
            'No Chatroom Keywords and Emotional Analyses found',
            textAlign: TextAlign.center,
            style: TextStyle (
              fontWeight: FontWeight.bold,
            )
          )
        )
      )
    );
  }
}
