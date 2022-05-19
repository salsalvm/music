import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:music/main.dart';
import 'package:music/module_1/home.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(
              builder: (BuildContext context, Playing? playing) {
            final myAudio = find(fullSongs, playing!.audio.assetAudioPath);
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NowPlaying(
                                songId: int.parse(myAudio.metas.id!).toString(),
                                allSongs: fullSongs,
                                index: 0,
                              )));
                },
                tileColor: boxColor,
                leading: QueryArtworkWidget(
                  artworkHeight: 60.h,
                  artworkWidth: 60.w,
                  id: int.parse(myAudio.metas.id!),
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(8).r,
                ),
                title: SizedBox(
                    height: 18.h,
                    child: Marquee(
                      text: myAudio.metas.title!,
                      style: TextStyle(color: textWhite),
                      velocity: 20,
                      startAfter: Duration.zero,
                      blankSpace: 100.w.h,
                    )),
                subtitle: Text(
                  myAudio.metas.artist!.toLowerCase(),
                  style: TextStyle(color: textGrey),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    //  previous
                    IconButton(
                      onPressed: playing.index == 0
                          ? () {
                              player.id;
                            }
                          : () {},
                      icon: playing.index == 0
                          ? Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.black45,
                              size: 43.sp,
                            )
                          : Icon(
                              Icons.skip_previous_rounded,
                              color: textWhite,
                              size: 43.sp,
                            ),
                    ),
                    // play pause
                    PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) {
                          return IconButton(
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: 43.sp,
                            ),
                            onPressed: () {
                              player.playOrPause();
                            },
                            color: textWhite,
                          );
                        }),

                    // next
                    IconButton(
                      iconSize: 45.sp,
                      onPressed: playing.index == fullSongs.length - 1
                          ? () {}
                          : () {
                              player.next();
                            },
                      icon: playing.index == fullSongs.length - 1
                          ? Icon(
                              Icons.skip_next_rounded,
                              color: black,
                              size: 43.sp,
                            )
                          : Icon(
                              Icons.skip_next_rounded,
                              color: textWhite,
                              size: 43.sp,
                            ),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       assetsAudioPlayer.next();
                    //     },
                    //     icon: playing.index == fullSongs.length - 1
                    //         ? const Icon(
                    //             Icons.skip_next,
                    //             color: Colors.black38,
                    //             size: 43,
                    //           )
                    //         : Icon(
                    //             Icons.skip_next,
                    //             color: textWhite,
                    //             size: 43,
                    //           )),
                  ],
                ),
              ),
            );
          });
  }
}