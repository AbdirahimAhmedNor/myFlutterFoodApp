import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/pages/sign_up.dart';
import 'package:food_app/pages/root.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();
final username = TextEditingController();
final password = TextEditingController();
Future login(context, username, password) async {
  var url = Uri.parse('http://192.168.1.5:3000/users/login');
  var body = {"username": username, "password": password};
  try {
    var response = await http.post(
      url,
      body: body,
    );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootApp()
        )
      );
  } catch (error) {
    print('trying to print the error');
    print(error);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                ),
                Text(
                  'Sign in',
                  style: GoogleFonts.poppins(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: 240,
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 18, 35, 8),
                        child: TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Enter username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter something';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Enter password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter something';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 7),
                                blurRadius: 5.0)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            colors: [
                              Colors.deepPurple.shade400,
                              Colors.deepPurple.shade200,
                            ],
                          ),
                          // color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(200, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            login(context, username.text, password.text);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text('Login',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                        child: Row(children: <Widget>[
                          Text('New here'),
                          SizedBox(width: 6),
                          GestureDetector(
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
