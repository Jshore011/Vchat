import 'package:charts_flutter/flutter.dart' as charts;

class Emotion {
  final String name;
  final int count;
  final charts.Color barColor;

  Emotion(
    this.name,
    this.count,
    this.barColor,
  );
}