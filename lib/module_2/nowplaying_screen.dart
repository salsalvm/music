import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music/main.dart';
import 'package:music/module_2/refactor/nowplaying_function.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music/module_4/refactor/menu_popup_horiz.dart';

import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  List<Audio> allSongs = [];
  int index;
  NowPlaying({Key? key, required this.allSongs, required this.index})
      : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> with TickerProviderStateMixin {
  late AnimationController controller;
  int _value = 6;
  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  AudioPlayer audioPlayer = AudioPlayer();
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
    );
  }

  bool pressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Now Playing',
          style: TextStyle(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            size: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: player.builderCurrent(builder: (context, Playing? playing) {
        final myAudio = find(widget.allSongs, playing!.audio.assetAudioPath);
        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 75),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal.shade200),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 280,
                  width: 350,
                  child: QueryArtworkWidget(
                      artworkHeight: 280,
                      artworkWidth: 350,
                      artworkBorder: BorderRadius.circular(25),
                      id: int.parse(myAudio.metas.id!),
                      type: ArtworkType.AUDIO),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.shuffle2,
                            color: textWhite,
                            size: 30,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 30,
                            width: 180,
                            child: Marquee(
                              blankSpace: 50,
                              startAfter: Duration.zero,
                              velocity: 60,
                              text: myAudio.metas.title!,
                              style: TextStyle(fontSize: 22, color: textWhite),
                            ),
                          ),
                          Text(
                            myAudio.metas.artist!.toLowerCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textGrey, fontSize: 14),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              pressed = !pressed;
                            });
                          },
                          icon: pressed
                              ? Icon(
                                  Icons.favorite,
                                  color: textWhite,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              player.builderRealtimePlayingInfos(
                  builder: (context, RealtimePlayingInfos infos) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ProgressBar(
                      onSeek: (slide) {
                        player.seek(slide);
                      },
                      timeLabelPadding: 15,
                      progressBarColor: textWhite,
                      baseBarColor: textGrey,
                      barHeight: 7,
                      thumbColor: textWhite,
                      timeLabelTextStyle: TextStyle(color: textWhite),
                      progress: infos.currentPosition,
                      total: infos.duration),
                );
              }),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(
                            Icons.repeat,
                            color: textWhite,
                            size: 30,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                          onPressed: () {
                            PlayListShowBottomSheet(context);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 30,
                            color: textWhite,
                          )),
                    )
                  ],
                ),
              ),

              // previous
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 45,
                      onPressed: () {
                        player.previous();
                      },
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        color: textWhite,
                      )),
                  smallwidth,

                  // play and pause
                  PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return IconButton(
                          color: textWhite,
                          iconSize: 55,
                          icon:
                              Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () {
                            player.playOrPause();
                          },
                        );
                      }),
                  smallwidth,

                  //  next
                  IconButton(
                      iconSize: 45,
                      onPressed: () {
                        player.next();
                      },
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: textWhite,
                      )),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
