import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'UI/login_ui.dart';
import 'SignUp_UI/signup_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Signup(),
    );
  }
}



void getHttp() async {
  try {
   // Response response;
    var dio = Dio();
    var response = await dio.get('http://13.56.138.93');
    print(response.data.toString());
// Optionally the request above could also be done as
    response = await dio.post('/open_api/login', queryParameters: {'email': 'test@test.com', 'password': '123'});
    print(response.data.toString());
    //var response = await Dio().post('');
    //print(response);
  } catch (e) {
    print(e);
  }
}

Future<User> createUser(String email, String password) async {
  var url = Uri.http('13.56.138.93/', "/");
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password':password
    }),
  );

  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
    );
  }
}
