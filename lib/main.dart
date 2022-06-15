import 'package:flutter/material.dart';
import 'Screens/Page.dart';
import 'Screens/Home.dart';
import 'Screens/Login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(const Base());
}

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample app",
      routes: {
        "Login" : (context) => const Login(),
        "Home" : (context) => const Home(),
        "Pages" : (context) => const Pages(),
      },
      initialRoute: "Login",
    );
  }
}

