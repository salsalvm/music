import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_4/refactor/get_and_create_playlist_bottom.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final box = PlaylistBox.getInstance();
  List playlists = [];
  String? playlistName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          actions: [
            IconButton(
                padding: EdgeInsets.only(right: 20),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreatePlaylistForm();
                      });
                },
                icon: Icon(
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
              builder: (context, boxes, _) {
                playlists = box.keys.toList();
                return ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: playlists[index] != "music"
                            ? ListTile(
                                onTap: (){},
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
                                    "Song",
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
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: boxtColor,
                                            margin: EdgeInsets.all(10),
                                            content: Text('Playlist Removed')));
                                      },
                                      value: "0",
                                      child: Text(
                                        "Remove Playlist",
                                        style: TextStyle(color: textWhite),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      // onTap: () {
                                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      //       behavior: SnackBarBehavior.floating,
                                      //       backgroundColor: boxtColor,
                                      //       margin: EdgeInsets.all(10),
                                      //       content: Text('Playlist Renamed')));
                                      // },
                                      value: "1",
                                      child: Text(
                                        "Rename Playlist",
                                        style: TextStyle(color: textWhite),
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == "0") {
                                      box.delete(playlists[index]);
                                      setState(() {
                                        playlists = box.keys.toList();
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
