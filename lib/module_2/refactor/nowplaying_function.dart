import 'package:flutter/material.dart';
import 'package:music/main.dart';

Widget BlankSpace = const SizedBox(
  height: 75,
);

Widget smallwidth = const SizedBox(
  width: 30,
);

Widget bottomPlaylist({onTap, required playListName, required countSong}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          onTap: onTap,
          leading: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 5),
            child: Icon(
              Icons.queue_music_rounded,
              color: textWhite,
              size: 30,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 3.0, bottom: 3, top: 5),
            child: Text(
              playListName,
              style: TextStyle(color: textWhite, fontSize: 18),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text(
              countSong,
              style: TextStyle(
                color: textGrey,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
