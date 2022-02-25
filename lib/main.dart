import 'package:flutter/material.dart';
import 'package:food_app/pages/root.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'pages/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'theme/color.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primaryColor: primary,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 400,
        splash: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/splash_screen_image.png'),
                  ),
                ),
              ),
            Text(
              "Food Delivery", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: secondary),),
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0),),
            SpinKitCubeGrid(
              color: secondary,
              size: 50.0,
            ),
            ],
          ),
        ),
      ),
      nextScreen: RootApp(),
      ),
    );
  }
}
