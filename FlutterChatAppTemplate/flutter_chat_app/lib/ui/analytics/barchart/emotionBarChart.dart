import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'EmotionData.dart';

class EmotionBarChart extends StatefulWidget {
  final emotionCount;

  const EmotionBarChart({Key? key, required this.emotionCount}) : super(key: key);

  @override
  _EmotionBarChartState createState() => _EmotionBarChartState();
}

class _EmotionBarChartState extends State<EmotionBarChart> {
  List emotionData = [];

  buildEmotionList() {
    var joy = Emotion('joy', 0, Colors.yellow);
    var sadness = Emotion('sadness', 0, Colors.blue);
    var disgust = Emotion('disgust', 0, Colors.green);
    var anger = Emotion('anger', 0, Colors.red);
    var fear = Emotion('fear', 0, Colors.deepPurple);

    var emotionList = [joy, sadness, disgust, anger, fear];

    for(int i = 0; i < widget.emotionCount.length; i++) {
      switch(widget.emotionCount[i]) {
        case 'joy' :
          {
            emotionList.removeAt(0);
            emotionList.insert(
                0, Emotion('joy', int.parse(widget.emotionCount[i + 1]), Colors.yellow));
          }
          break;
        case 'sadness' :
          {
            emotionList.removeAt(1);
            emotionList.insert(
                1, Emotion('sadness', int.parse(widget.emotionCount[i + 1]), Colors.blue));
          }
          break;
        case 'disgust' :
          {
            emotionList.removeAt(2);
            emotionList.insert(2,
                Emotion('disgust', int.parse(widget.emotionCount[i + 1]), Colors.green));
          }
          break;
        case 'anger' :
          {
            emotionList.removeAt(3);
            emotionList.insert(
                3, Emotion('anger', int.parse(widget.emotionCount[i + 1]), Colors.red));
          }
          break;
        case 'fear' :
          {
            emotionList.remove(4);
            emotionList.insert(4,
                Emotion('fear', int.parse(widget.emotionCount[i + 1]), Colors.deepPurple));
          }
          break;
      }
      print(widget.emotionCount[i]);
    }
    return emotionList;
  }

  @override
  void initState() {
    super.initState();
    setState(() => emotionData = buildEmotionList());
  }

  @override
  Widget build(BuildContext context) {
    return Container (
      width: MediaQuery.of(context).size.width,
      color: Colors.grey
    );
  }
}