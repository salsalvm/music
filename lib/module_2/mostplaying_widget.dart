import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_1/home_widget.dart';


class MostPlayed extends StatelessWidget {
  final leadImage;
  final songName;
  final singerName;
  final favour;
  const MostPlayed({required this.leadImage,required this.favour,required this.singerName,required this.songName});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: boxtColor,borderRadius: BorderRadius.circular(15)),
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
            padding: const EdgeInsets.only(left: 5.0, bottom: 3, top: 3),
            child: Text(
              songName,
              style: TextStyle(color: textWhite, fontSize: 18),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 5.0),
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
                    EvaIcons.heart,
                    size: 22,
                    color: favour,
                  )),
             popupMenuHoriz(context)
            ],
          )),
    );
  }
}


Widget mostPlayed(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
    child: ListView.separated(
        physics:  BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return MostPlayed(
            leadImage: mostPlayedSong[index]['leadImage'],
            songName: mostPlayedSong[index]['songName'],
            singerName: mostPlayedSong[index]['singerName'],
            favour: index%5==0?Colors.white:Colors.red,
          );
        }),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: mostPlayedSong.length),
  );
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
