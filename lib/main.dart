import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/module_1/splash_Screen.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsModelAdapter());
  await Hive.openBox<List>(boxname);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: lightBlue,
      home: SplashScreen(),
    );
  }
}

// var boxColor = Color.fromRGBO(94, 147, 185, 1);
// var darkBlue = Color.fromRGBO(0, 88, 146, 1);
// var lightBlue = Color.fromRGBO(36, 112, 161, .9);
var boxColor = Color.fromARGB(255, 22, 39, 52);
var darkBlue = Color.fromARGB(255, 14, 62, 101);
var lightBlue = Colors.transparent;
var textWhite = Color.fromARGB(255, 240, 242, 244);
var textGrey = Color.fromRGBO(188, 191, 193, 1);
var black = Color.fromARGB(255, 0, 0, 0);
