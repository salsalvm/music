import 'package:flutter/material.dart';

import 'package:music/main.dart';
import 'package:music/module_4/refactor/playlist_songs_widget.dart';

class PlayListSongs extends StatelessWidget {
  const PlayListSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: Text('Ever green'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),actions: [Padding(
          padding: const EdgeInsets.only(right:10.0,top: 8),
          child: IconButton(onPressed: (){}, icon: Icon(Icons.add_sharp)),
        )],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: 
 Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: ListView.separated(
        physics:  BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return PlayListSongsItems(
            leadImage: playListSong[index]['leadImage'],
            songName: playListSong[index]['songName'],
            singerName: playListSong[index]['singerName'],
            favour: index%5==0?Colors.white:Colors.red,
          );
        }),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: playListSong.length),
          )

),),
    );
  }
}
