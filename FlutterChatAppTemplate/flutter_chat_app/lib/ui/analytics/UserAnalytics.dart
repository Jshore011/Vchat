import 'package:flutter/material.dart';
import 'package:instachatty/ui/analytics/wordCloud/KeywordTagCloud.dart';
import 'barchart/emotionBarChart.dart';


class UserAnalytics extends StatefulWidget {
  final userEmotionCount;
  final userKeywordsList;

  const UserAnalytics({Key? key, required this.userEmotionCount, required this.userKeywordsList}) : super(key: key);

  @override
  _UserAnalyticsState createState() => _UserAnalyticsState();
}

class _UserAnalyticsState extends State<UserAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Center (
            child: widget.userEmotionCount.isNotEmpty && widget.userKeywordsList.isNotEmpty ?
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
                                    'Your Overall Emotion Count',
                                    style: TextStyle(color: Colors.white)
                                )
                            ),
                            Padding (
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: EmotionBarChart(emotionCount: widget.userEmotionCount)
                            ),
                            Container (
                                color: Colors.teal,
                                height: 30,
                                alignment: Alignment.center,
                                child: Text (
                                    'SWIPE LEFT for Your Keyword Tag Cloud',
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
                                    'Your Keyword Tag Cloud',
                                    style: TextStyle(color: Colors.white)
                                )
                            ),
                            Padding (
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: KeywordTagCloud(keywordsList: widget.userKeywordsList)
                            ),
                            Container (
                                color: Colors.teal,
                                height: 30,
                                alignment: Alignment.center,
                                child: Text (
                                    'SWIPE RIGHT for Your Overall Emotion Count',
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
