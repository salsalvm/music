// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:music/main.dart';

// import 'package:music/module_2/nowplaying_function.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class NowPlayingDesigns extends StatefulWidget {
//   // int index;
//   List<SongModel>allSongs=[];
//    NowPlayingDesigns({Key? key}) : super(key: key);

//   @override
//   State<NowPlayingDesigns> createState() => _NowPlayingDesignsState();
// }

// class _NowPlayingDesignsState extends State<NowPlayingDesigns>
//     with TickerProviderStateMixin {
//   //  AudioPlayer audioPlayer = AudioPlayer();
//   dynamic totalDuration = "00:00";
//   Duration position = Duration();

//   late AnimationController controller;
//   // dynamic position1 = "00:00";
//   // String? audioState;
//   // Duration duration = Duration();
//   int _value = 6;
//   bool isAnimated = false;
//   bool showPlay = true;
//   bool shopPause = false;
//   AssetsAudioPlayer player = AssetsAudioPlayer();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(microseconds: 400),
//       reverseDuration: Duration(microseconds: 400),
//     );
//     player.open(Audio('lib/assets/audio/Parudeesa.mp3'),
//         autoStart: false, showNotification: true);
//   }

//   //  initAudio() {
//   //   audioPlayer.onDurationChanged.listen((updatedDuration) {
//   //     setState(() {
//   //       totalDuration = updatedDuration;
//   //     });
//   //   });
//   //   audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
//   //     setState(() {
//   //       position = updatedPosition;
//   //     });
//   //   });
//   // }



