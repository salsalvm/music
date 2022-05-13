import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_4/playlist_songs_screen.dart';
import 'package:music/module_4/refactor/create_playlist.dart';
import 'package:music/module_4/refactor/update_playlist.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final box = PlaylistBox.getInstance();
  List playlists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 20),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreatePlaylistForm();
                      });
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
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
                var playlists = box.keys.toList();
                return ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    var playlistSongs = box.get(playlists[index]);
                    return Container(
                        child: playlists[index] != "music" &&
                                playlists[index] != "favourites"
                            ? ListTile(
                                onTap: () {setState(() {
                                  
                                });
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => PlayListSongs(
                                          playListName: playlists[index]))));
                                },
                                leading: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6.0, top: 5),
                                  child: Icon(
                                    Icons.queue_music_rounded,
                                    color: textWhite,
                                    size: 30,
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, bottom: 3, top: 5),
                                  child: Text(
                                    playlists[index].toString(),
                                    style: TextStyle(
                                        color: textWhite, fontSize: 18),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
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
                                                  top: 8.0),
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
                                                        horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      child: Text("Cancel",
                                                          style: TextStyle(
                                                              color: textWhite,
                                                              fontSize: 18)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("Yes",
                                                          style: TextStyle(
                                                              color: textWhite,
                                                              fontSize: 18)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        box.delete(
                                                            playlists[index]);
                                                        setState(() {
                                                          playlists =
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
                                              playlistName: playlists[index],
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
