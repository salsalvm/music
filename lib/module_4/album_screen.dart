import 'package:flutter/material.dart';

import 'package:music/main.dart';
import 'package:music/module_1/home_widget.dart';
import 'package:music/module_4/album_widget.dart';
import 'package:music/module_4/playlist_songs_screen.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        appBar: AppBar(
          title: Text('Album'),
          centerTitle: true,
          backgroundColor: lightBlue,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2.1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: albumList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                       Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => PlayListSongs())));
    
                    },
                    child: AlbumItems(
                        assetImage: albumList[index]["leadImage"],
                        albumName: albumList[index]["albumName"],
                        songCount: albumList[index]["songCoun"]),
                  );
                }),
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //     shape: CircularNotchedRectangle(),
        //     color: lightBlue,
        //     elevation: 50,
        //     child: Container(
        //       child: bottomNavigation(
        //         context,
        //       ),
            // )
            );
  }
}
