import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Signup_Header.dart';
import 'signup_InputWrapper.dart';
//testing webhook number3
class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.purpleAccent,
            Colors.deepPurpleAccent,
            Colors.deepPurple
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 60,),
            Header(),
            Expanded(child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)
                  )
              ),
              child: InputWrapper(),
            ))
          ],
        ),
      ),
    );
  }
}