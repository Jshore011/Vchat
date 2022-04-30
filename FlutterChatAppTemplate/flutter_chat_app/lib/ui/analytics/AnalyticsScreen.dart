import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../services/helper.dart';
import 'TranscribeAnalytics.dart';
import 'ChatroomAnalytics.dart';
import 'UserAnalytics.dart';

class AnalyticsScreen extends StatefulWidget {
  final String conversationID;
  final String userID;

  const AnalyticsScreen({Key? key, required this.conversationID, required this.userID}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  var currentIndex = 0;

  Widget getPage(int index) {
    switch (index){
      case 1:
        return ChatroomAnalytics();
        break;
      case 2:
        return UserAnalytics();
        break;
      default:
        return TranscribeAnalytics(conversationID: widget.conversationID, userID: widget.userID);
        break;
    }
  }

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
        //     child: Column (
        //       children: [
        //         Text(
        //           myText
        //         ),
        //         ElevatedButton(
        //         onPressed: () async {
        //           myText = await getAnalytics(widget.conversationID, widget.userID);
        //           setState(() { myText; });
        //           },
        //         child: Text('Get Text'),
        //       )]
        //     )
        // )
        getPage(currentIndex),
        bottomNavigationBar: BottomNavigationBar (
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(COLOR_PRIMARY),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex  = index;
          }),
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
