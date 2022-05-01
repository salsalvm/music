import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';

import 'package:music/main.dart';

import 'package:music/module_4/refactor/get_and_create_playlist_bottom.dart';
import 'package:music/module_4/refactor/playlist_widget.dart';

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
            IconButton(padding: EdgeInsets.only(right: 20),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreatePlaylistForm();
                      });
                },
                icon: Icon(Icons.add,size: 30,))
          ],
          title: const Text('Playlist'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: lightBlue,
        ),
        body: Stack(
          children: [
            SafeArea(
              child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, boxes, _) {
                    playlists = box.keys.toList();
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                            child: playlists[index] != "music"
                                ? PlayList(
                                    playListName: playlists[index].toString(),
                                    countSong: "songs",
                                    onSelected: (value) {
                                      if (value == "0") {
                                        box.delete(playlists[index]);
                                        setState(() {
                                          playlists = box.keys.toList();
                                        });
                                      }
                                    },
                                  )
                                : Container());
                      },
                      itemCount: playlists.length,
                    );
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right:15.0,bottom: 10),
            //   child: Container(alignment: Alignment.bottomRight,
            //     child: FloatingActionButton(child: Icon(Icons.add),backgroundColor: darkBlue,
            //       onPressed: () {
            //         showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return CreatePlaylistForm();
            //           },
            //         );
            //       },
            //       elevation: 50,
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
