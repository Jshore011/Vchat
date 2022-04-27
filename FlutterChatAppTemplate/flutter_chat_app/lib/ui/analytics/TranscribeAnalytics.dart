import 'package:flutter/material.dart';

class TranscribeAnalytics extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center (
        child: ListView (
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/images/' + 'joy' + '.png',
                height: 100,
              ),
              Padding (
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text (
                  'Chatroom\'s most recent message\'s',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding (
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text (
                  'Top Emotion: ' + 'Joy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/joy.png',
                    height: 50,
                  ),
                  title: Text('Joy'),
                  subtitle: Text('Level: ' + ''),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/sadness.png',
                    height: 50,
                  ),
                  title: Text('Sadness'),
                  subtitle: Text('Level: ' + ''),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/disgust.png',
                    height: 50,
                  ),
                  title: Text('Disgust'),
                  subtitle: Text('Level: ' + ''),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/anger.png',
                    height: 50,
                  ),
                  title: Text('Anger'),
                  subtitle: Text('Level: ' + ''),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/fear.png',
                    height: 50,
                  ),
                  title: Text('Fear'),
                  subtitle: Text('Level: ' + ''),
                ),
              ),
            ]
        ),
      )
  );
}
