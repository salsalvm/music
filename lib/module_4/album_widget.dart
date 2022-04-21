import 'package:flutter/material.dart';

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
            color: boxtColor, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child:
            //  Text(myProducts[index]["name"]),
            Column(
          children: [
            Container(
              width: 180,
              height: 90,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                child: Image(
                  image: AssetImage(assetImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: [
                  Text(
                    albumName,
                    style: TextStyle(fontSize: 18, color: textWhite),
                  ),
                  Text(songCount,
                      style: TextStyle(fontSize: 15, color: textGrey)),
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
