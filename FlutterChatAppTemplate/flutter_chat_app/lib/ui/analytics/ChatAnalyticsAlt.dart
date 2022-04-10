import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter/services.dart';

class AnalyticsPage extends StatelessWidget {
  final _htmlContent = """
  <div>
    <h1>Chatroom Analytics</h1>
    <p>Let's see how the room has been <strong>feeling</strong>.</p>
    <ul>
        <li>Joy: % </li>
        <li>Sad: % </li>
        <li>Anger: % </li>
        <li>Disgust: % </li>
        <li>Fear: % </li>
    </ul>
    <img src='https://www.kindacode.com/wp-content/uploads/2020/11/my-dog.jpg' />
  </div>
  """;

  const AnalyticsPage({Key? key}) : super(key: key);

  set geturl(geturl) {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Url geturl = upload;
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Html(
            data: _htmlContent,
            // Styling with CSS (not real CSS)
            style: {
              'h1': Style(color: Colors.red),
              'p': Style(color: Colors.black87, fontSize: FontSize.medium),
              'ul': Style(margin: const EdgeInsets.symmetric(vertical: 20))
            },
          ),
        ),
      ),
    );
  }
}