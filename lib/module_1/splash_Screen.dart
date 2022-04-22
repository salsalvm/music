import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music/module_1/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   List<SongModel> fetchedSongs = [];
//   List<SongModel> allSongs = [];
//   List<Audio> fullSong = [];

//   requestStoragePermissiono() async {
//     bool permissionStatus = await _audioQuery.permissionsStatus();
//     if (!permissionStatus) {
//       _audioQuery.permissionsRequest();
//     }
//     setState(() {});

//     // allmedia fetched from storage
//     fetchedSongs = await _audioQuery.querySongs();
//     for (var element in fetchedSongs) {
//       if (element.fileExtension == "mp3") {
//         allSongs.add(element);
//       }
//     }

// // seperat song details
//     for (var element in allSongs) {
//       fullSong.add(
//         Audio.file(element.uri.toString(),
//             metas: Metas(
//               title: element.title,
//               id: element.id.toString(),
//               artist: element.artist,
//             )),
//       );
//     }
//   }

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

// delayed

  Future goTo() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }
}

// design

Widget splash({required String content}) {
  return Column(children: [
    SizedBox(
      height: 350,
    ),
    const Icon(
      Icons.music_video,
      size: 50,
      color: Colors.white,
    ),
    SizedBox(height: 30),
    Text(
      content,
      style: const TextStyle(
          color: Colors.white, fontSize: 30, fontFamily: 'mono'),
    )
  ]);
}
