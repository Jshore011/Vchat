import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'chatroomKeywords.dart';

class ChatroomKeywordWordCloud extends StatelessWidget {
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
  ScatterItem(this.chatroomKeyword, this.index);
  final ChatroomKeyword chatroomKeyword;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyText2!.copyWith(
      fontSize: chatroomKeyword.size.toDouble(),
      color: chatroomKeyword.color,
    );
    return RotatedBox(
      quarterTurns: chatroomKeyword.rotated ? 1 : 0,
      child: Text(
        chatroomKeyword.hashtag,
        style: style,
      ),
    );
  }
}