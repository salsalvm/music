
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music/main.dart';
import 'package:music/module_2/nowplaying_function.dart';


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
 
  // dynamic position = "00:00";
  // dynamic duration = "00:00";
// String? audioState;
Duration position =Duration();

Duration duration =Duration();

  late AnimationController controller;
  int _value = 6;
  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
AudioPlayer audioPlayer =AudioPlayer();
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

     
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      // duration: Duration(microseconds: 100),
      // reverseDuration: Duration(microseconds: 100),
    );
    // player.open(Audio('lib/assets/audio/Parudeesa.mp3'),
    //     autoStart: false, showNotification: true);
  
    // player.onReadyToPlay.listen((p) {setState(() {
    //  position=p as Duration; 
    // }
    
    // ); });
  player.currentPosition.listen((updatedPosition) {setState(() {
     position = updatedPosition;
  });});

      // audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      // setState(() {
      //   position = updatedPosition;
      // });
    // });
 //Listen to the current playing song




player.current.listen((updatedPosition) {setState(() {
     duration = updatedPosition as Duration;
  });});

    // audioPlayer.onDurationChanged.listen((updatedDuration) {
    //   setState(() {
    //     duration = updatedDuration;
    //   });
    // });
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
              bigBlankSpace,
              Container(
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
              bigBlankSpace,
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
                          // Text(
                          //   myAudio.metas.title!,
                          //   style: TextStyle(fontSize: 22, color: textWhite),
                          //   overflow: TextOverflow.ellipsis,
                          // ),
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
        
              // StreamBuilder<Duration>(
              //     stream: player.currentPosition,
              //     builder:
              //         (BuildContext context, AsyncSnapshot<Duration> snapshot) {
              //       final Duration? _currentDuration = snapshot.data;
              //       final int _milliseconds = _currentDuration!.inMilliseconds;
              //       final int _songDurationInMilliseconds =
              //           snapshot.data!.inSeconds;
              //       return Slider(
              //           value: _songDurationInMilliseconds > _milliseconds
              //               ? _milliseconds.toDouble()
              //               : _songDurationInMilliseconds.toDouble(),
              //           onChanged: (double value) {
              //             player.seek(
              //                 Duration(milliseconds: (value / 1000.0).toInt()));
              //           });
              //     }),

              seekBarSlider(context),
              // Slider.adaptive(
              //     value: _position.inSeconds.toDouble(),
              //     min: 0.0,
              //     max: 20,

              //     divisions: 10,
              //     activeColor: textWhite,
              //     inactiveColor: textGrey,
              //     // label: '',
              //     onChanged: (double value) {
              //       setState(() {
              //        value=value;
              //       });

              //     },)
              // semanticFormatterCallback: (double newValue) {
              //   return '${newValue.round()} dollars';
              // }

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(position.toString().split(".").first,style: TextStyle(color: textWhite),),
                 Text(duration.toString().split(".").first,style: TextStyle(color: textWhite),),
                    // Text(
                    //   position.toString(),
                    //   // .split(".").first,
                    //   style: TextStyle(color: textWhite),
                    // ),
                    // Text(duration.toString(),
                    // // .split(".").first,
                    //     style: TextStyle(color: textWhite)),
                      
                    // Text(formateTime(position),style: TextStyle(color: textWhite),),
                    // Text(
                    //   formateTime(duration),style: TextStyle(color: textWhite),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),

   // add nad recent

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
                              onPressed: () {;
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

  Widget seekBarSlider(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(builder: (ctx, index) {
      Duration _position = index.currentPosition;
      Duration _duration = index.duration;
      return Slider.adaptive(
          value: _position.inSeconds.toDouble(),
          min: 0.0,
          max: _duration.inSeconds.toDouble(),
          activeColor: textWhite,
          inactiveColor: textGrey,
          // label: '',
          onChanged: (double value) async {
            //  ( final _position =Duration(seconds: value.toInt());
            // await  player.seek(position);)its not dragging
            setState(() {
              // value = value;
              player.seek(Duration(seconds: value.toInt()));
            });
          },
          );
    });
    
  }
}

String formateTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}
