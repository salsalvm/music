import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/main.dart';

// final List<Map> myProducts =
//     List.generate(100000, (index) => {"id": index, "name": "Product $index"})
//         .toList();

class AlbumItems extends StatelessWidget {
  final assetImage;
  final albumName;
  final songCount;
  const AlbumItems(
      {required this.assetImage,
      required this.albumName,
      required this.songCount});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(10.w.h)),
        alignment: Alignment.center,
        child:
            //  Text(myProducts[index]["name"]),
            Column(
          children: [
            Container(
              width: 180.w,
              height: 90.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.w.h)),
              child: ClipRRect(
                child: Image(
                  image: AssetImage(assetImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w.h),
                    topRight: Radius.circular(10.w.h)),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: [
                  Text(
                    albumName,
                    style: TextStyle(fontSize: 18.w.h, color: textWhite),
                  ),
                  Text(songCount,
                      style: TextStyle(fontSize: 15.w.h, color: textGrey)),
                ],
              ),
            ),
          ],
        ));
  }
}

List<Map<String, dynamic>> albumList = [
  {
    "leadImage": "lib/assets/bheeshma.jpeg",
    "albumName": "Malayalam",
    "songCoun": "5 song",
  },
  {
    "leadImage": "lib/assets/pal.webp",
    "albumName": "Arjith sing",
    "songCoun": "2 song",
  },
  {
    "leadImage": "lib/assets/saami.webp",
    "albumName": "Tamil",
    "songCoun": "1 song",
  },
  {
    "leadImage": "lib/assets/fakelove.webp",
    "albumName": "Bts",
    "songCoun": "1 song",
  },
  {
    "leadImage": "lib/assets/uyire.webp",
    "albumName": "Sithara",
    "songCoun": "2 song",
  },
  {
    "leadImage": "lib/assets/agarthum.webp",
    "albumName": "Hindi",
    "songCoun": "3 song",
  },
];
