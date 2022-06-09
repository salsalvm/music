import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/application/favorite/favorites_bloc.dart';
import 'package:music/application/playlist/playlist_bloc.dart';
import 'package:music/application/repeat/repeat_bloc.dart';
import 'package:music/application/search/search_cubit.dart';
import 'package:music/application/shuffle/shuffle_bloc.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<List>(boxname);

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        designSize: const Size(392.7, 781.1),
        builder: (child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => RepeatBloc()),
              BlocProvider(create: (context) => SearchCubit()),
              BlocProvider(create: (context) => ShuffleBloc()),
              BlocProvider(create: ((context) => FavoritesBloc()),
              ),
              BlocProvider(
                create: ((context) => PlaylistBloc()),
              )
            ],
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              color: lightBlue,
              home: SplashScreen(),
            ),
          );
        });
  }
}
