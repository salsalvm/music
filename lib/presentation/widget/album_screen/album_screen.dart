import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/widget/album_screen/widget/album_widget.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        title:const Text('Album'),
        centerTitle: true,
        backgroundColor: lightBlue,
      ),
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.all(15.0).r,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.r,
                  childAspectRatio: 3 / 2.1,
                  crossAxisSpacing: 10.r,
                  mainAxisSpacing: 10.r),
              itemCount: albumList.length,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: () {},
                  child: AlbumItems(
                      assetImage: albumList[index]["leadImage"],
                      albumName: albumList[index]["albumName"],
                      songCount: albumList[index]["songCoun"]),
                );
              }),
        ),
      ),
    );
  }
}
