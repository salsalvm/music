import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsModelAdapter());
  await Hive.openBox<List>(boxname);

  final box = PlaylistBox.getInstance();
  List<dynamic> favKey = box.keys.toList();
  if (!(favKey.contains("favourites"))) {
    List<dynamic> favouritesSongs = [];
    await box.put("favourites", favouritesSongs);
  }
  List<dynamic> recentKey = box.keys.toList();
  List<dynamic> recentPlayed = [];
  if (!(recentKey.contains("recentPlayed"))) {
    List<dynamic> recentPlayed = [];
    await box.put("recentPlayed", recentPlayed);
  }
  runApp(const MyApp());
}
// void requestPermission(){
//     Permission.storage.request();
   
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // requestPermission();
    return ScreenUtilInit(splitScreenMode: true,minTextAdapt: true,useInheritedMediaQuery: true,
        designSize: const Size(392.7, 781.1),
        builder: (child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            color: lightBlue,
            home: const SplashScreen(),
          );
        });
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
