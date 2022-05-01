import 'package:flutter/material.dart';
import 'package:instachatty/ui/analytics/wordCloud/KeywordTagCloud.dart';


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
        body: widget.userKeywordsList.isNotEmpty ?
        KeywordTagCloud(keywordsList: widget.userKeywordsList) :
        Center (
            child: Text (
                'No User Keywords found',
                style: TextStyle (
                  fontWeight: FontWeight.bold,
                )
            )
        )
    );
  }
}
