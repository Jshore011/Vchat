import 'package:flutter/material.dart';
import '../../services/IBMHelper.dart';

class TranscribeAnalytics extends StatefulWidget {
  final transcribeTopEmotion;
  final transcribeEmotionsAndScores;

  const TranscribeAnalytics({Key? key, required this.transcribeTopEmotion, required this.transcribeEmotionsAndScores}) : super(key: key);

  @override
  _TranscribeAnalyticsState createState() => _TranscribeAnalyticsState();
}

class _TranscribeAnalyticsState extends State<TranscribeAnalytics>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container (
                    color: Colors.teal,
                    height: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text (
                        'Most Recent Message\'s Emotional Analysis',
                        style: TextStyle(color: Colors.white)
                    )
                )
              ]
            ),
            widget.transcribeTopEmotion != '' ?
            Image.asset(
              'assets/images/' + '${widget.transcribeTopEmotion}' + '.png',
              height: 100,
            ) : Image.asset(
              'assets/images/blankface.png',
              height: 100,
            ),
            widget.transcribeTopEmotion != '' ?
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'Top Emotion: ' + '${widget.transcribeTopEmotion}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ) : Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'Top Emotion: None',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
            ),
            Card(
              child: ListTile (
                leading: Image.asset(
                  'assets/images/joy.png',
                  height: 50,
                ),
                title: Text('Joy'),
                subtitle: widget.transcribeEmotionsAndScores.isNotEmpty ?
                  Text('Confidence: ' + '${widget.transcribeEmotionsAndScores[3]}' + '%') :
                  Text('Confidence: N/A')
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset(
                  'assets/images/sadness.png',
                  height: 50,
                ),
                title: Text('Sadness'),
                subtitle: widget.transcribeEmotionsAndScores.isNotEmpty ?
                  Text('Confidence: ' + '${widget.transcribeEmotionsAndScores[1]}' + '%') :
                  Text('Confidence: N/A')
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset(
                  'assets/images/disgust.png',
                  height: 50,
                ),
                title: Text('Disgust'),
                subtitle: widget.transcribeEmotionsAndScores.isNotEmpty ?
                  Text('Confidence: ' + '${widget.transcribeEmotionsAndScores[7]}' + '%') :
                  Text('Confidence: N/A')
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset(
                  'assets/images/anger.png',
                  height: 50,
                ),
                title: Text('Anger'),
                subtitle: widget.transcribeEmotionsAndScores.isNotEmpty ?
                  Text('Confidence: ' + '${widget.transcribeEmotionsAndScores[9]}' + '%') :
                  Text('Confidence: N/A')
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset(
                  'assets/images/fear.png',
                  height: 50,
                ),
                title: Text('Fear'),
                subtitle: widget.transcribeEmotionsAndScores.isNotEmpty ?
                  Text('Confidence: ' + '${widget.transcribeEmotionsAndScores[5]}' + '%') :
                  Text('Confidence: N/A')
              ),
            ),
          ]
      ),
    ),
  );
}