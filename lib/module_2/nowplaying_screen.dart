import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_2/refactor/nowplaying_function.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music/module_3/2-favourite_screen.dart';
import 'package:music/module_4/refactor/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  List<Audio> allSongs = [];
  int index;
  final String songId;
  NowPlaying(
      {Key? key,
      required this.allSongs,
      required this.index,
      required this.songId})
      : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> with TickerProviderStateMixin {
//  final String songId;

  final box = PlaylistBox.getInstance();

  List<SongsModel> dbSongs = [];
  List<Audio> fullsong = [];
  List playlist = [];
  List<dynamic> playlistSongs = [];
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  AudioPlayer audioPlayer = AudioPlayer();

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  bool isShuffle = false;
  bool isRepeate = false;
  bool pressed = true;
  @override
  Widget build(BuildContext context) {
    dbSongs = box.get("music") as List<SongsModel>;
    final playlistName = databaseSongs(dbSongs, widget.songId);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Now Playing',
          style: TextStyle(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_drop_down_outlined,
            size: 35.w.h,
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
                padding:  EdgeInsets.symmetric(vertical: 75.h),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal.shade200),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 280.h,
                  width: 350.w,
                  child: QueryArtworkWidget(
                      artworkHeight: 280.h,
                      artworkWidth: 350.w,
                      artworkBorder: BorderRadius.circular(25),
                      id: int.parse(myAudio.metas.id!),
                      type: ArtworkType.AUDIO),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 5.0.h),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // shuffle
                      StatefulBuilder(builder: ((BuildContext context,
                          void Function(void Function()) setState) {
                        return !isShuffle
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isShuffle = true;
                                      player.toggleShuffle();
                                    });
                                  },
                                  icon: Icon(
                                    EvaIcons.shuffle2,
                                    color: textWhite,
                                    size: 30.w.h,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50)),
                                child: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        isShuffle = false;
                                        player.setLoopMode(LoopMode.playlist);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.cached,
                                    color: textWhite,
                                    size: 30.w.h,
                                  ),
                                ),
                              );
                      })),
                      Column(
                        children: [
                          Container(
                            height: 30.h,
                            width: 180.w,
                            child: Marquee(
                              blankSpace: 50.w.h,
                              startAfter: Duration.zero,
                              velocity: 60,
                              text: myAudio.metas.title!,
                              style: TextStyle(fontSize: 22.w.h, color: textWhite),
                            ),
                          ),
                          Text(
                            myAudio.metas.artist!.toLowerCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textGrey, fontSize: 14.w.h),
                          )
                        ],
                      ),
                      StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return FavouriteIcon(songId: myAudio.metas.id!);
                        },
                      ),
                    ],
                  ),
                ),
              ),

// slider
              player.builderRealtimePlayingInfos(
                  builder: (context, RealtimePlayingInfos infos) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ProgressBar(
                      onSeek: (slide) {
                        player.seek(slide);
                      },
                      timeLabelPadding: 15.w.h,
                      progressBarColor: textWhite,
                      baseBarColor: textGrey,
                      barHeight: 7.h,
                      thumbColor: textWhite,
                      timeLabelTextStyle: TextStyle(color: textWhite),
                      progress: infos.currentPosition,
                      total: infos.duration),
                );
              }),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatefulBuilder(builder: ((context, setState) {
                      return !isRepeate
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        isRepeate = true;
                                        player.setLoopMode(LoopMode.single);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.repeat,
                                    color: textWhite,
                                    size: 30.w.h,
                                  )),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        isRepeate = false;
                                        player.setLoopMode(LoopMode.playlist);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.repeat_one,
                                    color: textWhite,
                                    size: 30.w.h,
                                  )),
                            );
                    })),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                          onPressed: () {
                            PlayListShowBottomSheet(context, playlistName);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 30.w.h,
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
                    iconSize: 45.w.h,
                    onPressed: playing.index == 0
                        ? () {}
                        : () {
                            player.previous();
                          },
                    icon: playing.index == 0
                        ? SizedBox()
                        : Icon(
                            Icons.skip_previous_rounded,
                            color: textWhite,
                          ),
                  ),

                  smallwidth,

                  // play and pause
                  PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return IconButton(
                          color: textWhite,
                          iconSize: 55.w.h,
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
                    iconSize: 45.w.h,
                    onPressed: () {
                     
                      player.next();
                    },
                    icon: Icon(
                      Icons.skip_next_rounded,
                      color: textWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  SongsModel databaseSongs(List<SongsModel> songs, String id) {
    return songs.firstWhere(
      (element) => element.songurl.toString().contains(id.toString()),
    );
  }
}