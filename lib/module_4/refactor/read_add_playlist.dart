import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_1/splash_Screen.dart';

class PlayListItem extends StatelessWidget {
  SongsModel song;
  List playlists = [];
  List<dynamic>? playlistSongs = [];
  final countSong;
  PlayListItem({Key? key, required this.countSong, required this.song})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    playlists = box.keys.toList();
    return Column(
      children: [
        ...playlists
            .map(
              (playlistName) => playlistName != "music" &&
                      playlistName != "favourites" &&
                      playlistName != "recentPlayed"
                  ? Container(
                      decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(15).r),
                      child: ListTile(
                        onTap: () async {
                          playlistSongs = box.get(playlistName);
                          List existingSongs = [];
                          existingSongs = playlistSongs!
                              .where((element) =>
                                  element.id.toString() == song.id.toString())
                              .toList();
                          if (existingSongs.isEmpty) {
                            final temp = dbSongs.firstWhere((element) =>
                                element.id.toString() == song.id.toString());
                            playlistSongs?.add(temp);
                            await box.put(playlistName, playlistSongs!);

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: darkBlue,
                                content: Text(
                                  song.songname! + 'Added to Playlist',
                                  style: TextStyle(color: textWhite),
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              song.songname! + 'is Already in Playlist.',
                              style: TextStyle(color: textWhite),
                            )));
                          }
                        },
                        leading: Padding(
                          padding: EdgeInsets.only(left: 6.0, top: 5).r,
                          child: Icon(
                            Icons.queue_music_rounded,
                            color: textWhite,
                            size: 30.sp,
                          ),
                        ),

                        // playlist name
                        title: Padding(
                          padding:
                              EdgeInsets.only(left: 3.0, bottom: 3, top: 5).r,
                          child: Text(
                            playlistName.toString(),
                            style: TextStyle(color: textWhite, fontSize: 18.sp),
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(left: 3.0).r,
                          child: Text(
                            countSong,
                            style: TextStyle(
                              color: textGrey,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            )
            .toList()
      ],
    );
  }
}
