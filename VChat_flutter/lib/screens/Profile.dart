import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vchat_flutter/screens/Home.dart';
import 'package:vchat_flutter/screens/UserSettings.dart';
import 'package:vchat_flutter/screens/Wadapak.dart';
import 'package:vchat_flutter/screens/Signup.dart';
import 'package:vchat_flutter/util/fire_auth.dart';

import 'Analytics.dart';
import 'Chatroom.dart';
import 'Friends.dart';


class NavBarPage extends StatefulWidget {
  final User user;

  const NavBarPage({required this.user});

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

// class _ProfilePageState extends State<ProfilePage> {
//   bool _isSendingVerification = false;
//   bool _isSigningOut = false;
//
//   late User _currentUser;
//
//   @override
//   void initState() {
//     _currentUser = widget.user;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'NAME: ${_currentUser.displayName}',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'EMAIL: ${_currentUser.email}',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             SizedBox(height: 16.0),
//             _currentUser.emailVerified
//                 ? Text(
//               'Email verified',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(color: Colors.green),
//             )
//                 : Text(
//               'Email not verified',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(color: Colors.red),
//             ),
//             SizedBox(height: 16.0),
//             _isSendingVerification
//                 ? CircularProgressIndicator()
//                 : Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     setState(() {
//                       _isSendingVerification = true;
//                     });
//                     await _currentUser.sendEmailVerification();
//                     setState(() {
//                       _isSendingVerification = false;
//                     });
//                   },
//                   child: Text('Verify email'),
//                 ),
//                 SizedBox(width: 8.0),
//                 IconButton(
//                   icon: Icon(Icons.refresh),
//                   onPressed: () async {
//                     User? user = await FireAuth.refreshUser(_currentUser);
//
//                     if (user != null) {
//                       setState(() {
//                         _currentUser = user;
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             _isSigningOut
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   _isSigningOut = true;
//                 });
//                 await FirebaseAuth.instance.signOut();
//                 setState(() {
//                   _isSigningOut = false;
//                 });
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (context) => RegisterPage(),
//                   ),
//                 );
//               },
//               child: Text('Sign out'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.red,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       drawer:NavBar(),
//     );
//   }
// }

class _NavBarPageState extends State<NavBarPage> {

  late User _currentUser;
  bool _isSigningOut = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  Center test = Center(
      child: Column(
          children: [
            Row(
                children: [
                  Text("hello world!"),
                  Padding(padding: EdgeInsets.all(24.0),
                    child: Text("padded text!"),
                  )
                ]
            )
          ]
      )
  );

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('VChat')),
        body: test,
        drawer: Drawer(
          child: ListView(
            // Remove padding
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Welcome to VChat, ${_currentUser.displayName}',
                  style: Theme.of(context).textTheme.bodyText1,),
                accountEmail: Text('${_currentUser.email}',
                  style: Theme.of(context).textTheme.bodyText1,),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      '',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal[800],
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage (
                          '')),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.chat_rounded),
                title: Text('Chatrooms'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatroomPage()),
                    );
                  }
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Friends'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendsPage()),
                    );
                  }
              ),
              ListTile(
                leading: Icon(Icons.analytics_rounded),
                title: Text('Analytics'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnalyticsPage()),
                  );
                }
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  UserSettingsPage()),
                );
                },
              ),
              Divider(),
              ListTile(
                title: Text('Signout'),
                leading: Icon(Icons.exit_to_app_rounded),
                onTap: () async {
                  setState(() {
                    _isSigningOut = true;
                  });
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    _isSigningOut = false;
                  });
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
  }
}