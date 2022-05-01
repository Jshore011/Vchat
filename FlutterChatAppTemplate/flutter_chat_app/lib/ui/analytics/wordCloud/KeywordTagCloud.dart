import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:instachatty/ui/analytics/wordCloud/KeywordData.dart';

class KeywordTagCloud extends StatefulWidget {
  final keywordsList;

  const KeywordTagCloud({Key? key, required this.keywordsList}) : super(key: key);

  @override
  _KeywordTagCloudState createState() => _KeywordTagCloudState();
}

class _KeywordTagCloudState extends State<KeywordTagCloud> {
  List keywords = [];
  double size = 200;
  final List<Color> colorCollection = <Color>[];

  void addColorToArray() {
    colorCollection.add(Colors.teal);
    colorCollection.add(Colors.greenAccent);
    colorCollection.add(Colors.green);
    colorCollection.add(Colors.lightGreen);
    colorCollection.add(Colors.amber);
    colorCollection.add(Colors.orangeAccent);
    colorCollection.add(Colors.orange);
    colorCollection.add(Colors.deepOrangeAccent);
  }

  buildKeywordList() {
    var keywordsList = [];
    for(int i = 0; i < widget.keywordsList.length; i++) {
      keywordsList.add(Keyword('#' + '${widget.keywordsList[i]}', colorCollection[Random().nextInt(8)], size, Random().nextBool()));
      size = size - 25;
      if(size <= 50) {
        size = 50;
      }
      print('${widget.keywordsList[i]}');
    }
    return keywordsList;
  }

  @override
  void initState() {
    super.initState();
    addColorToArray();
    setState(() => keywords = buildKeywordList());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < keywords.length; i++) {
      widgets.add(ScatterItem(keywords[i], i));
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
  ScatterItem(this.keyword, this.index);
  final Keyword keyword;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyText2!.copyWith(
      fontSize: keyword.size.toDouble(),
      color: keyword.color,
    );
    return RotatedBox(
      quarterTurns: keyword.rotated ? 1 : 0,
      child: Text(
        keyword.hashtag,
        style: style,
      ),
    );
  }
}