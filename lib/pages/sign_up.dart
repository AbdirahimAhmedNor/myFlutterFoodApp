import 'package:flutter/material.dart';
import 'package:food_app/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  final _formkey = GlobalKey<FormState>();
  final username = TextEditingController();
  final personName = TextEditingController();
  final confirmPassword = TextEditingController();
  final password = TextEditingController();
  // signing function
  void register(context,name, username, password, confirmPassowrd) async  {
    print(name);
    print(username);
    print(password);
    var url = Uri.parse('http://10.0.2.2:3000/users/register');
    var body = { "name": name, "username": username, "password": password };
    try {
      var response = await http.post(
        url,
        body:body
      );
      print(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen()
        )
      );
    } catch (error) {
      print('getting error');
      print(error);
    }
  }
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
                  'Sign up',
                  style: GoogleFonts.poppins(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
                          ))),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 8, 35, 0),
                        child: TextFormField(
                          controller: personName,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Enter your name'),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'please enter something';
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 8, 35, 0),
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
                            if (value == null || value.isEmpty)
                              return 'please enter something';
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 8, 35, 0),
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
                            if (value == null || value.isEmpty)
                              return 'please enter something';
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 8, 35, 0),
                        child: TextFormField(
                          controller: confirmPassword,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'confirm password'),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'please enter something';
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
                            print("pressed the button");
                            register(
                              context,
                              personName.text,
                              username.text,
                              password.text,
                              confirmPassword.text);
                            
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text('Singup',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                        child: Row(children: <Widget>[
                          Text('Already have account?'),
                          SizedBox(width: 6),
                          GestureDetector(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),

                                ),
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
