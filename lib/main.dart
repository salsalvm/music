import 'package:flutter/material.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<List>(boxname);

  // final box = PlaylistBox.getInstance();
  List<dynamic> favKey = box.keys.toList();
  if (!(favKey.contains("favourites"))) {
    List<dynamic> favouritesSongs = [];
    await box.put("favourites", favouritesSongs);
  }
  List<dynamic> recentKey = box.keys.toList();
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
    return ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        useInheritedMediaQuery: true,
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


