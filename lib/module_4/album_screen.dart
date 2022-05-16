import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/main.dart';
import 'package:music/module_4/refactor/album_widget.dart';
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
            padding:  EdgeInsets.all(15.0).r,
            child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.r,
                    childAspectRatio: 3 / 2.1,
                    crossAxisSpacing: 10.r,
                    mainAxisSpacing: 10.r),
                itemCount: albumList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
          //              Navigator.of(context)
          // .push(MaterialPageRoute(builder: ((context) => PlayListSongs(playListName: ))));
    
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
