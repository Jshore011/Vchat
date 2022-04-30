import 'package:flutter/material.dart';
import '../../services/IBMHelper.dart';

class TranscribeAnalytics extends StatefulWidget {
  final String conversationID;
  final String userID;

  const TranscribeAnalytics({Key? key, required this.conversationID, required this.userID}) : super(key: key);

  @override
  _TranscribeAnalyticsState createState() => _TranscribeAnalyticsState();
}

class _TranscribeAnalyticsState extends State<TranscribeAnalytics>{

  @override
  void initState() {
    super.initState();
  }

  Future<String> getEmotion() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var topEmotion = await _ibmUtils.requestTopEmotion(widget.conversationID, widget.userID);
    return topEmotion;
  }

  Future<List> getEmotionsScores() async {
    final IBMUtils _ibmUtils = IBMUtils();
    var emotionsScores = await _ibmUtils.requestEmotionsScores(widget.conversationID, widget.userID);
    return emotionsScores;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body:
      FutureBuilder(
        future: Future.wait([getEmotion(), getEmotionsScores()]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.red,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)),
            );
          } else {
            return Center(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/' + '${snapshot.data[0]}' + '.png',
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        'Chatroom\'s most recent message\'s',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        'Top Emotion: ' + '${snapshot.data[0]}',
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
                        subtitle: Text('${snapshot.data[1][3]}' + '%'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/sadness.png',
                          height: 50,
                        ),
                        title: Text('Sadness'),
                        subtitle: Text('${snapshot.data[1][1]}' + '%'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/disgust.png',
                          height: 50,
                        ),
                        title: Text('Disgust'),
                        subtitle: Text('${snapshot.data[1][7]}' + '%'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/anger.png',
                          height: 50,
                        ),
                        title: Text('Anger'),
                        subtitle: Text('${snapshot.data[1][9]}' + '%'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/fear.png',
                          height: 50,
                        ),
                        title: Text('Fear'),
                        subtitle: Text('${snapshot.data[1][5]}' + '%'),
                      ),
                    ),
                  ]
              ),
            );
          }
        },
      ),
  );
}