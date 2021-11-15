import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'SignUp_UI/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpSection(),
    );
  }
}

void getHttp() async {
    try {
      var response = await Dio().get('http://34.204.3.211');
      print(response);
    } catch(e) {
      print(e);
    }
}
//getUserApi(email, password) async {
  //var httpClient = new HttpClient();
  //var uri = new Uri.https('yourserverurl.com', '/your/endpoint/whatever');
  //var request = await httpClient.getUrl(uri);
  //var response = await request.close();
  //var responseBody = await response.transform(UTF8.decoder).join();
  //return response;
//}

signup(email, password) async {
  var url =new Uri.https( 'yourserverurl.com', '/your/endpoint/whatever'); // iOS
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception('Failed to create user.');
  }
}