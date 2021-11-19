import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_chat/UI/login_ui.dart';
import '/main.dart';

class Signup extends StatefulWidget {
  const Signup({ Key? key }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[600],
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('VChat'),
      ),
      body: Center(
        child: Form (
          key: _formKey,
            child: Container(
            margin: const EdgeInsets.all(20),
            width: 500,
            height: 550,
            decoration: const BoxDecoration(
              color: Color(0xFF424242),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row (
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 5, 20),
                        child: TextFormField(
                          validator: (firstName) {
                            if(firstName == null || firstName.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Color(0xFF303030),
                            filled: true,
                            icon: Icon(Icons.person, color: Colors.white),
                            hintText: 'Please type in your first name',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            labelText: 'first name',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (String? value) {
                            //todo
                            //code that will run when the user saves the form
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 20),
                        child: TextFormField(
                          validator: (lastName) {
                            if(lastName == null || lastName.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Color(0xFF303030),
                            filled: true,
                            hintText: 'Please type in your last name',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            labelText: 'last name',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (String? value) {
                            //todo
                            //code that will run when the user saves the form
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 20, 20),
                  child: TextFormField(
                    validator: (userName) {
                      if(userName == null || userName.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFF303030),
                      filled: true,
                      hintText: 'Please create a new username',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'new username',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    onSaved: (String? value) {
                      //todo
                      //code that will run when the user saves the form
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: TextFormField(
                    validator: (password) {
                      if(password == null || password.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock_rounded, color: Colors.white),
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFF303030),
                      filled: true,
                      hintText: 'Please create a new password',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'new password',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    onSaved: (String? value) {
                      //todo
                      //code that will run when the user saves the form
                    },
                  ),
                ),
                Row (
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Color(0xFF303030),
                            filled: true,
                            icon: Icon(Icons.cake, color: Colors.white),
                            hintText: 'month',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            labelText: 'birthmonth',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (String? value) {
                            //todo
                            //code that will run when the user saves the form
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Color(0xFF303030),
                            filled: true,
                            hintText: 'day',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            labelText: 'birthdate',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (String? value) {
                            //todo
                            //code that will run when the user saves the form
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Color(0xFF303030),
                            filled: true,
                            hintText: 'year',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                            labelText: 'birthyear',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (String? value) {
                            //todo
                            //code that will run when the user saves the form
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding (
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //todo
                        //Build query and post onto database
                      }
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      minimumSize: const Size(470, 50),
                      primary: Colors.teal[400],
                    ),
                  ),
                ),
                Padding (
                  padding: const EdgeInsets.all(0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                      },
                    child: const Text('Already have an account?'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      primary: Colors.teal[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),  
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoPageScaffold(
  //       navigationBar: CupertinoNavigationBar(
  //         automaticallyImplyLeading: false,
  //       ),
  //       child: SafeArea(
  //           child: ListView(padding: const EdgeInsets.all(16), children: [
  //             Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 8),
  //                 child: CupertinoTextField(
  //                     placeholder: "Email",
  //                     onChanged: (value) {
  //                       email = value;
  //                     })),
  //             Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 8),
  //                 child: CupertinoTextField(
  //                     placeholder: "Password",
  //                     obscureText: true,
  //                     onChanged: (value) {
  //                       password = value;
  //                     })),
  //             FlatButton.icon(
  //                 onPressed: () {
  //                   print(email);
  //                   print(password);
  //            //       signup(email, password);
  //                   //getHttp(email, password);
  //                 },
  //                 icon: Icon(Icons.save),
  //                 label: Text("Sign UP"))
  //           ])));
  // }
}