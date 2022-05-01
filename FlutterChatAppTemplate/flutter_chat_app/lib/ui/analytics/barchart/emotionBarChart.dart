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
  List<Emotion> emotionData = [];

  buildEmotionList() {
    var joy = Emotion('joy', 0, charts.ColorUtil.fromDartColor(Colors.amber));
    var sadness = Emotion('sadness', 0, charts.ColorUtil.fromDartColor(Colors.blue));
    var disgust = Emotion('disgust', 0, charts.ColorUtil.fromDartColor(Colors.green));
    var anger = Emotion('anger', 0, charts.ColorUtil.fromDartColor(Colors.red));
    var fear = Emotion('fear', 0, charts.ColorUtil.fromDartColor(Colors.purple));

    var emotionList = [joy, sadness, disgust, anger, fear];

    for(int i = 0; i < widget.emotionCount.length; i++) {
      switch(widget.emotionCount[i]) {
        case 'joy' :
          {
            emotionList.removeAt(0);
            emotionList.insert(0, Emotion('joy', int.parse(widget.emotionCount[i + 1]), charts.ColorUtil.fromDartColor(Colors.amber)));
          }
          break;
        case 'sadness' :
          {
            emotionList.removeAt(1);
            emotionList.insert(1, Emotion('sadness', int.parse(widget.emotionCount[i + 1]), charts.ColorUtil.fromDartColor(Colors.blue)));
          }
          break;
        case 'disgust' :
          {
            emotionList.removeAt(2);
            emotionList.insert(2, Emotion('disgust', int.parse(widget.emotionCount[i + 1]), charts.ColorUtil.fromDartColor(Colors.green)));
          }
          break;
        case 'anger' :
          {
            emotionList.removeAt(3);
            emotionList.insert(3, Emotion('anger', int.parse(widget.emotionCount[i + 1]), charts.ColorUtil.fromDartColor(Colors.red)));
          }
          break;
        case 'fear' :
          {
            emotionList.removeAt(4);
            emotionList.insert(4, Emotion('fear', int.parse(widget.emotionCount[i + 1]), charts.ColorUtil.fromDartColor(Colors.purple)));
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
    List<charts.Series<Emotion, String>> series = [
      charts.Series(
        id: "EmotionCount",
        data: emotionData,
        domainFn: (Emotion series, _) => series.name,
        measureFn: (Emotion series, _) => series.count,
        colorFn: (Emotion series, _) => series.barColor
      ),
    ];

    return Container (
      height: MediaQuery.of(context).size.height/ 2.0,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: charts.BarChart(series, animate: true)
          )
        ]
      )
    );
  }
}