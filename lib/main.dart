import 'package:flutter/material.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:music/MAIN/widget.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,color: lightBlue,
      
      

      home: SplashScreen(),
    );
  }
}
