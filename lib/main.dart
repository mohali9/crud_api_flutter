import 'package:flutter/material.dart';
import 'package:flutter_api/ceate.dart';
import 'package:flutter_api/edit.dart';
import './login.dart';
import './splashscreen.dart';
import './homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Api',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        accentColor: Colors.white70,
      ),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new HomeScreen(),
        '/Login': (BuildContext context) => new Login(),
        '/Edit': (BuildContext context) => new Edit(),
        '/Create': (BuildContext context) => new Create(),
      },
    );
  }
}