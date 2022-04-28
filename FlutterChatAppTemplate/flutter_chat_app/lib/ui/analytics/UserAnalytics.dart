import 'package:flutter/material.dart';
import 'package:instachatty/ui/analytics/wordCloud/userKeywordTagCloud.dart';

class UserAnalytics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserKeywordWordCloud(),
    );
  }
}
