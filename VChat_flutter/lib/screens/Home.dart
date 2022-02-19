import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vchat_flutter/screens/Signup.dart';

import 'Login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:[Color(0xFF020B1A), Color(0xFF020B1A), Color(0xFF3E5879), Color(0xFF9BA5AE), Color(0xFFDCB697), Color(0xFFFC7001), Color(0xFFDD723C), Color(0xFFAD4A28), Color(0xFF040308)]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Welcome to VChat'),
        ),
        body: Center(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
              new ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
