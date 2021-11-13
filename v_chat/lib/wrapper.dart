import 'package:flutter/material.dart';
import 'package:v_chat/UserHomeUI/UserDash.dart';

import 'LoginUI/LoginPage.dart';
import 'SignupUI/SignupPage.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return either home or auth
    return SignupPage();
  }
}
