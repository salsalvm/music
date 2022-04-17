
import 'package:flutter/material.dart';
import 'package:music/module_1/home_screen.dart';
import 'package:music/module_1/static.dart';



import 'package:music/module_1/widget_splash.dart';
import 'package:music/module_3/setting_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goTo();
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromRGBO(119, 213, 248, 1),
          Color.fromRGBO(0, 88, 146, 1)
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: splash(content: 'Music of Your...'),
        ),
      ),
    );
  }

  Future goTo() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen( )));
  }
}
