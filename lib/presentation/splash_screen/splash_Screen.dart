import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/home/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final Box<List<dynamic>> box = StorageBox.getInstance();
final OnAudioQuery _audioQuery = OnAudioQuery();
final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
List<SongModel> fetchedSongs = [];
List<Songs> mappedSongs = [];
List<Songs> dbSongs = [];
List<Audio> fullSongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestStoragePermissiono();

    super.initState();
  }

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

  requestStoragePermissiono() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }

    setState(() {});

    fetchedSongs = await _audioQuery.querySongs();
    mappedSongs = fetchedSongs
        .map((audio) => Songs(
            id: audio.id,
            artist: audio.artist,
            duration: audio.duration,
            songname: audio.title,
            songurl: audio.uri))
        .toList();

    await box.put("music", mappedSongs);
    dbSongs = box.get("music") as List<Songs>;

    for (var element in dbSongs) {
      fullSongs.add(
        Audio.file(
          element.songurl.toString(),
          metas: Metas(
            title: element.songname,
            id: element.id.toString(),
            artist: element.artist,
          ),
        ),
      );
    }
    setState(() {});
    // delayed
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }
}

// design
Widget splash({required String content}) {
  return Column(children: [
    SizedBox(
      height: 350.h,
    ),
    Icon(
      Icons.music_video,
      size: 50.sp,
      color: Colors.white,
    ),
    SizedBox(height: 30.h),
    Text(
      content,
      style:
          TextStyle(color: Colors.white, fontSize: 30.sp, fontFamily: 'mono'),
    )
  ]);
}
