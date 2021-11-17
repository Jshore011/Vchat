

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignUpSection extends StatelessWidget {
  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
        ),
        child: SafeArea(
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CupertinoTextField(
                      placeholder: "Email",
                      onChanged: (value) {
                        email = value;
                      })),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CupertinoTextField(
                      placeholder: "Password",
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      })),
              FlatButton.icon(
                  onPressed: () {
                    print(email);
                    print(password);
             //       signup(email, password);
                    //getHttp(email, password);
                  },
                  icon: Icon(Icons.save),
                  label: Text("Sign UP"))
            ])));
  }
}