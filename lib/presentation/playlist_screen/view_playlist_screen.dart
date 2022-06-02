import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:music/presentation/playlist_screen/view_songs_playlist.dart';
import 'package:music/presentation/playlist_screen/widget/form_playlist_create.dart';
import 'package:music/presentation/playlist_screen/update_playlist/update_playlist.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  List playlistsName = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 20).r,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CreatePlaylistForm();
                      });
                },
                icon: Icon(
                  Icons.add,
                  size: 30.sp,
                ))
          ],
          title: const Text('Playlist'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: lightBlue,
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, boxes, child) {
                var playlistsName = box.keys.toList();
                return ListView.builder(
                  itemCount: playlistsName.length,
                  itemBuilder: (context, index) {
                    var playlistSongs = box.get(playlistsName[index]);
                    return Container(
                        child: playlistsName[index] != "music" &&
                                playlistsName[index] != "favourites" &&
                                playlistsName[index] != "recentPlayed"
                            ? ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => PlayListSongs(
                                          playlistName:
                                              playlistsName[index]))));
                                  setState(() {});
                                },
                                leading: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6.0, top: 5)
                                          .r,
                                  child: Icon(
                                    Icons.queue_music_rounded,
                                    color: textWhite,
                                    size: 30.sp,
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                          left: 3.0, bottom: 3, top: 5)
                                      .r,
                                  child: Text(
                                    playlistsName[index].toString(),
                                    style: TextStyle(
                                        color: textWhite, fontSize: 18.sp),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 3.0).r,
                                  child: Text(
                                    "${playlistSongs!.length} Song",
                                    style: TextStyle(
                                      color: textGrey,
                                    ),
                                  ),
                                ),
                                trailing: PopupMenuButton(
                                  color: darkBlue,
                                  icon: Icon(
                                    Icons.more_vert_outlined,
                                    color: textWhite,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {},
                                      value: "0",
                                      child: Text(
                                        "Rename Playlist",
                                        style: TextStyle(color: textWhite),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {},
                                      value: "1",
                                      child: Text(
                                        "Remove Playlist",
                                        style: TextStyle(color: textWhite),
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == "1") {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: darkBlue,
                                            title: Center(
                                              child: Text(
                                                "Remove this Playlist",
                                                style:
                                                    TextStyle(color: textWhite),
                                              ),
                                            ),
                                            content: Padding(
                                              padding: const EdgeInsets.only(
                                                      top: 8.0)
                                                  .r,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text("Are You Confirm ",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .yellowAccent)),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 20)
                                                        .r,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      child: Text("Cancel",
                                                          style: TextStyle(
                                                              color: textWhite,
                                                              fontSize: 18.sp)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("Yes",
                                                          style: TextStyle(
                                                              color: textWhite,
                                                              fontSize: 18.sp)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        box.delete(
                                                            playlistsName[
                                                                index]);
                                                        setState(() {
                                                          playlistsName =
                                                              box.keys.toList();
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    if (value == "0") {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return UpdatePlaylist(
                                              playlistName:
                                                  playlistsName[index],
                                            );
                                          });
                                    }
                                  },
                                ),
                              )
                            : Container());
                  },
                );
              }),
        ));
  }
}
