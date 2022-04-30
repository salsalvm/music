import 'package:flutter/material.dart';

import 'package:music/main.dart';
import 'package:music/module_1/home_widget.dart';

class PlayList extends StatelessWidget {
  final playListName;
  final countSong;
  final onTap;
  const PlayList(
      {required this.playListName, required this.countSong, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: boxtColor, borderRadius: BorderRadius.circular(15)),
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
            trailing: popupMenuHoriz2(context),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget popupMenuHoriz2(BuildContext context) {
    return PopupMenuButton(
      color: darkBlue,
      icon: Icon(
        Icons.more_vert_outlined,
        color: textWhite,
      ), //don't specify icon if you want 3 dot menu
      // color: Colors.blue,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: boxtColor,
                margin: EdgeInsets.all(10),
                content: Text('Playlist Removed')));
          },
          value: 0,
          child: Text(
            "Remove Playlist",
            style: TextStyle(color: textWhite),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: boxtColor,
                margin: EdgeInsets.all(10),
                content: Text('Playlist Renamed')));
          },
          value: 1,
          child: Text(
            "Rename Playlist",
            style: TextStyle(color: textWhite),
          ),
        ),
      ],
      onSelected: (item) => {print(item)},
    );
  }

// horiz



}
