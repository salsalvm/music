import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/main.dart';


class MostPlayed extends StatelessWidget {
  final leadImage;
  final songName;
  final singerName;
  final favour;
  const MostPlayed(
      {required this.leadImage,
      required this.favour,
      required this.singerName,
      required this.songName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
          onTap: () {},
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(
              leadImage,
            ),
          ),
          title: Padding(
            padding:  EdgeInsets.only(left: 5.0.w, bottom: 3.h, top: 3.h),
            child: Text(
              songName,
              style: TextStyle(color: textWhite, fontSize: 18.w.h),
            ),
          ),
          subtitle: Padding(
            padding:  EdgeInsets.only(left: 5.0.w),
            child: Text(
              singerName,
              style: TextStyle(color: textGrey),
            ),
          ),
          trailing: Wrap(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    size: 22.w.h,
                    color: favour,
                  )),
            // MenuHoriz(songId: songId)
            ],
          )),
    );
  }
}

List<Map<String, dynamic>> mostPlayedSong = [
  {
    "leadImage": "lib/assets/butter.webp",
    "songName": "Butter",
    "singerName": "bts",
  },
  {
    "leadImage": "lib/assets/nee mukhilo.webp",
    "songName": "Nee mukhilo",
    "singerName": "sithara",
  },
  {
    "leadImage": "lib/assets/bheeshma.jpeg",
    "songName": "Parudheesa",
    "singerName": "sree nadh bhasi",
  },
  {
    "leadImage": "lib/assets/agarthum.webp",
    "songName": "Agar thum saath",
    "singerName": "arjith sing",
  },
  {
    "leadImage": "lib/assets/pal.webp",
    "songName": "Pal",
    "singerName": "arjith sing",
  }
];
