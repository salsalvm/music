import 'package:flutter/material.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:sizer/sizer.dart';


void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,color: lightBlue,
        
        
    
        home: SplashScreen(),
      );
    },
     
    );
  }
}

var lightBlue = Color.fromRGBO(36, 112, 161, .9);
var darkBlue = Color.fromRGBO(0, 88, 146, 1);
var boxtColor = Color.fromRGBO(94, 147, 185, 1);
// var boxtColor = Color.fromARGB(255, 22, 39, 52);
// var darkBlue = Color.fromARGB(255, 14, 62, 101);
// var lightBlue = Colors.transparent;
var textWhite = Color.fromARGB(255, 240, 242, 244);
var textGrey = Color.fromARGB(255, 188, 191, 193);