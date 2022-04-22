import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music/main.dart';

import 'package:music/module_2/nowplaying_function.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingDesigns extends StatefulWidget {
  int index;
  List<SongModel>allSongs=[];
   NowPlayingDesigns({Key? key,required this.index,required this.allSongs}) : super(key: key);

  @override
  State<NowPlayingDesigns> createState() => _NowPlayingDesignsState();
}

class _NowPlayingDesignsState extends State<NowPlayingDesigns>
    with TickerProviderStateMixin {
  //  AudioPlayer audioPlayer = AudioPlayer();
  dynamic totalDuration = "00:00";
  Duration position = Duration();

  late AnimationController controller;
  // dynamic position1 = "00:00";
  // String? audioState;
  // Duration duration = Duration();
  int _value = 6;
  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  AssetsAudioPlayer player = AssetsAudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 400),
      reverseDuration: Duration(microseconds: 400),
    );
    player.open(Audio('lib/assets/audio/Parudeesa.mp3'),
        autoStart: false, showNotification: true);
  }

  //  initAudio() {
  //   audioPlayer.onDurationChanged.listen((updatedDuration) {
  //     setState(() {
  //       totalDuration = updatedDuration;
  //     });
  //   });
  //   audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
  //     setState(() {
  //       position = updatedPosition;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          bigBlankSpace,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 280,
            width: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: AssetImage(
                  'lib/assets/bheeshma.jpeg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          bigBlankSpace,
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: listtiles(),
          ),
          Slider(
              value: _value.toDouble(),
              min: 1.0,
              max: 20.0,
              divisions: 10,
              activeColor: textWhite,
              inactiveColor: textGrey,
              // label: '',
              onChanged: (double newValue) {
                setState(() {
                  _value = newValue.round();
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()} dollars';
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  position.toString().split(".").first,
                  style: TextStyle(color: textWhite),
                ),
                Text(totalDuration.toString().split(".").first,
                    style: TextStyle(color: textWhite)),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),

// add nad volume

          addAndVol(context),

  // previous
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      color: textWhite,
                      size: 40,
                    )),
              ),
              smallwidth,

// play and pause

              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    color: textWhite,
                    progress: controller,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      isAnimated = !isAnimated;
                      if (isAnimated) {
                        controller.forward();
                        player.play();
                      } else {
                        controller.reverse();
                        player.pause();
                      }
                    });
                  },
                ),
              ),
              smallwidth,

  //  next
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_next_rounded,
                      color: textWhite,
                      size: 40,
                    )),
              ),
            ],
          ),
        ],
      )),
    );
  }

  Widget bigBlankSpace = SizedBox(
    height: 80,
  );

  Widget smallwidth = SizedBox(
    width: 30,
  );
}
