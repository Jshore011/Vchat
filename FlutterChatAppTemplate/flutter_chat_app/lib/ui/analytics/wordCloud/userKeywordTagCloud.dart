import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:instachatty/ui/analytics/wordCloud/userKeywords.dart';

class UserKeywordWordCloud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < kChatroomKeywords.length; i++) {
      widgets.add(ScatterItem(kChatroomKeywords[i], i));
    }

    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    return Center(
      child: FittedBox(
        child: Scatter(
          fillGaps: true,
          delegate: ArchimedeanSpiralScatterDelegate(ratio: ratio),
          children: widgets,
        ),
      ),
    );
  }
}

class ScatterItem extends StatelessWidget {
  ScatterItem(this.userKeyword, this.index);
  final UserKeyword userKeyword;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyText2!.copyWith(
      fontSize: userKeyword.size.toDouble(),
      color: userKeyword.color,
    );
    return RotatedBox(
      quarterTurns: userKeyword.rotated ? 1 : 0,
      child: Text(
        userKeyword.hashtag,
        style: style,
      ),
    );
  }
}