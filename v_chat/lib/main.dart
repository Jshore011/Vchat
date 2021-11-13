import 'package:flutter/material.dart';
import 'package:v_chat/wrapper.dart';

import 'LoginUI/LoginPage.dart';
//import 'SignupUI/SignupPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  //const MyApp({Key? key}) : super(key: key);

  @override
  //State<MyApp> createState() => _MyAppState();
//}

//class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context){


    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: wrapper(),


    );
  }
}