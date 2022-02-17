import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vchat_flutter/screens/Home.dart';
import 'package:vchat_flutter/screens/Wadapak.dart';
import 'package:vchat_flutter/screens/Signup.dart';
import 'package:vchat_flutter/util/fire_auth.dart';

class UserSettingsPage extends StatefulWidget{
  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new ElevatedButton(
              child: const Text('Username'),
              onPressed: () {
                Navigator.push(
                  context,
                  throw UnimplementedError,
                );
              },
            ),
            new ElevatedButton(
              child: const Text('Email'),
              onPressed: () {
                Navigator.push(
                  context,
                  throw UnimplementedError(),
                );
              },
            ),
          ],
        ),

      ),
    );
  }
}