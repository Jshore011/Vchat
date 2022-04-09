import 'package:flutter/material.dart';

class UserSettingsPage extends StatefulWidget{
  const UserSettingsPage({Key? key}) : super(key: key);
  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final _userSettingsFormKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusPhoneNumber = FocusNode();
  final _focusUsername = FocusNode();
  final _focusName = FocusNode();

  final bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    //throw UnimplementedError();
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focusUsername.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _userSettingsFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        decoration: InputDecoration(
                          hintText: "Email",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password"
                        ),
                      ),
                      TextFormField(
                        controller: _nameTextController,
                        focusNode: _focusName,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Name",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _usernameTextController,
                        focusNode: _focusUsername,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Username",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _phoneNumberTextController,
                        focusNode: _focusPhoneNumber,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      if (_isProcessing) const CircularProgressIndicator() else Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              // TODO: implement onPressed
                              onPressed: () {

                              },
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}