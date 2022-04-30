import 'package:flutter/material.dart';

import 'package:music/main.dart';

import 'package:music/module_4/create_playlist_bottom.dart';
import 'package:music/module_4/playlist_songs_screen.dart';

import 'package:music/module_4/refactor/playlist_widget.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title: Text('Playlist'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
        backgroundColor: lightBlue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: ListView(
            children: [
              PlayList(
                playListName: 'Ever green',
                countSong: '5 song',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => PlayListSongs())));
                },
              ),
              PlayList(
                playListName: 'English Song',
                countSong: ' song',
              ),
              PlayList(playListName: 'Hindi Song', countSong: '2 song'),
              // PlayList(playListName: 'Sithara', countSong: '2 song'),
              // PlayList(playListName: 'Arjith sing', countSong: '2 song'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: boxtColor,
        elevation: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(elevation: 0, primary: boxtColor),
            onPressed: () {
              createPlaylistShowAlertDialog(context);
            },
            icon: Icon(Icons.add),
            label: Text(
              'Add a New Playlist',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
