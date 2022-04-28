import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../services/helper.dart';
import 'TranscribeAnalytics.dart';
import 'ChatroomAnalytics.dart';
import 'UserAnalytics.dart';
import 'package:instachatty/services/IBMHelper.dart';

class AnalyticsScreen extends StatefulWidget {
  final String conversationID;
  final String userID;

  const AnalyticsScreen({Key? key, required this.conversationID, required this.userID}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int currentIndex = 0;

  final screens = [
    TranscribeAnalytics(),
    ChatroomAnalytics(),
    UserAnalytics(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(
              color: isDarkMode(context) ? Colors.grey.shade200 : Colors.white),
          iconTheme: IconThemeData(
              color: isDarkMode(context) ? Colors.grey.shade200 : Colors.white),
          title: Text('Analytics'),
          centerTitle: true,
          backgroundColor: Color(COLOR_PRIMARY),
        ),
        body:
        // Center(
        //     child: ElevatedButton(
        //       onPressed: ()=> getAnalytics(widget.conversationID, widget.userID),
        //       child: Text('Get Analytics'),
        //     )
        // )
        screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar (
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(COLOR_PRIMARY),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Transcribe',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Chatroom',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'User',
            ),
          ],
        ),
    );
  }
}

getAnalytics(String conversationID, String userID) async {
  final IBMUtils _ibmUtils = IBMUtils();
  var analytics = await _ibmUtils.requestAnalytics(conversationID, userID);
  return analytics;
}
