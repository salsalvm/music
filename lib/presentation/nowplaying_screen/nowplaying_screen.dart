import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:music/application/favorite/favorites_bloc.dart';
import 'package:music/application/repeat/repeat_bloc.dart';
import 'package:music/application/shuffle/shuffle_bloc.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/favourites_screen/widget/favourite_icon_add.dart';
import 'package:music/presentation/home/home.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music/presentation/widget/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatelessWidget {
  List<Audio> allSongs = [];
  int index;
  final String songId;
  NowPlaying(
      {Key? key,
      required this.allSongs,
      required this.index,
      required this.songId})
      : super(key: key);

  List playlist = [];
  List<dynamic> playlistSongs = [];

  bool isShuffle = false;
  bool isRepeate = false;
  bool pressed = true;
  @override
  Widget build(BuildContext context) {
    final playlistName = databaseSongs(dbSongs, songId);

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
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            size: 35.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: player.builderCurrent(builder: (context, Playing? playing) {
        final myAudio = find(allSongs, playing!.audio.assetAudioPath);

        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70).r,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal.shade200),
                    borderRadius: BorderRadius.circular(25).r,
                  ),
                  height: 280.h,
                  width: 350.w,
                  child: QueryArtworkWidget(
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        color: textWhite,
                        size: 50,
                      ),
                      artworkQuality: FilterQuality.high,
                      size: 2000,
                      quality: 100,
                      artworkHeight: 280.h,
                      artworkWidth: 350.w,
                      artworkBorder: BorderRadius.circular(25).r,
                      id: int.parse(myAudio.metas.id!),
                      type: ArtworkType.AUDIO),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0).r,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // shuffle
                      BlocBuilder<ShuffleBloc, ShuffleState>(
                        builder: (context, state) {
                          return !isShuffle
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(50).r),
                                  child: IconButton(
                                    onPressed: () {
                                      context.read<FavoritesBloc>().add(
                                          FavIconPress(icon: Icons.shuffle));
                                      isShuffle = true;
                                      player.toggleShuffle();
                                    },
                                    icon: Icon(
                                      EvaIcons.shuffle2,
                                      color: textWhite,
                                      size: 30.sp,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(50).r),
                                  child: IconButton(
                                    onPressed: () {
                                      context.read<FavoritesBloc>().add(
                                          FavIconPress(icon: Icons.favorite));
                                      isShuffle = false;
                                      player.setLoopMode(LoopMode.playlist);
                                    },
                                    icon: Icon(
                                      Icons.cached,
                                      color: textWhite,
                                      size: 30.sp,
                                    ),
                                  ),
                                );
                        },
                      ),

                      Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                            width: 180.w,
                            child: Marquee(
                              blankSpace: 50.w.h,
                              startAfter: Duration.zero,
                              velocity: 60,
                              text: myAudio.metas.title!,
                              style:
                                  TextStyle(fontSize: 22.sp, color: textWhite),
                            ),
                          ),
                          Text(
                            myAudio.metas.artist!.toLowerCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textGrey, fontSize: 14.sp),
                          )
                        ],
                      ),
                      // StatefulBuilder(
                      //   builder: (BuildContext context,
                      //       void Function(void Function()) setState) {
                      //     return FavouriteIcon(songId: myAudio.metas.id!);
                      //   },
                      // ),
                      FavouriteIcon(songId: myAudio.metas.id!)
                    ],
                  ),
                ),
              ),

// slider
              player.builderRealtimePlayingInfos(
                  builder: (context, RealtimePlayingInfos infos) {
                return Padding(
                  padding: const EdgeInsets.all(20.0).r,
                  child: ProgressBar(
                      onSeek: (slide) {
                        player.seek(slide);
                      },
                      timeLabelPadding: 15.r,
                      progressBarColor: textWhite,
                      baseBarColor: textGrey,
                      barHeight: 7.h,
                      thumbColor: textWhite,
                      timeLabelTextStyle: const TextStyle(color: textWhite),
                      progress: infos.currentPosition,
                      total: infos.duration),
                );
              }),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<RepeatBloc, RepeatState>(
                      builder: (context, state) {
                        return !isRepeate
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50).r),
                                child: IconButton(
                                    onPressed: () {
                                      context.read<RepeatBloc>().add(
                                          RepeatIconPress(icon: Icons.repeat));
                                      isRepeate = true;
                                      player.setLoopMode(LoopMode.single);
                                    },
                                    icon: Icon(
                                      Icons.repeat,
                                      color: textWhite,
                                      size: 30.sp,
                                    )),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50).r),
                                child: IconButton(
                                    onPressed: () {
                                      context.read<RepeatBloc>().add(
                                          RepeatIconPress(icon: Icons.repeat));
                                      isRepeate = false;
                                      player.setLoopMode(LoopMode.playlist);
                                    },
                                    icon: Icon(
                                      Icons.repeat_one,
                                      color: textWhite,
                                      size: 30.sp,
                                    )),
                              );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50).r),
                      child: IconButton(
                          onPressed: () {
                            playlistShowBottomSheet(context, playlistName);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 30.sp,
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
                    iconSize: 45.sp,
                    onPressed: playing.index == 0
                        ? () {}
                        : () {
                            player.previous();
                          },
                    icon: playing.index == 0
                        ? const SizedBox()
                        : const Icon(
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
                          iconSize: 55.sp,
                          icon:
                              Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () {
                            player.playOrPause();
                          },
                        );
                      }),
                  smallwidth,

                  //  next
                  playing.index == fullSongs.length - 1
                      ? const Icon(Icons.abc)
                      : IconButton(
                          iconSize: 45.sp,
                          onPressed: () {
                            player.next();
                          },
                          icon: const Icon(
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

  Songs databaseSongs(List<Songs> songs, String id) {
    return songs.firstWhere(
      (element) => element.songurl.toString().contains(id.toString()),
    );
  }
}
