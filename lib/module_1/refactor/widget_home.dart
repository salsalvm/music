import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/main.dart';
import 'package:music/module_2/most_played_screen.dart';
import 'package:music/module_3/setting_screen.dart';
import 'package:music/module_4/album_screen.dart';
import 'package:music/module_4/view_playlist_screen.dart';

class StackItems extends StatefulWidget {
  const StackItems({Key? key}) : super(key: key);

  @override
  State<StackItems> createState() => _StackItemsState();
}

class _StackItemsState extends State<StackItems> {
  bool _mode = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: Colors.black12,
          radius: 35.r,
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: darkBlue,
                      title: Center(
                          child: Text(
                        'Do you want to Exit',
                        style: TextStyle(color: Colors.red[200]),
                      )),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10).r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        color: textWhite, fontSize: 18.sp),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    exit(0);
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: textWhite, fontSize: 18.sp),
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
              size: 35.sp,
            ),
            color: textWhite,
          ),
        ),
        Column(
          children: [
            MyTile(
              context,
              Icons.library_add_check_rounded,
              'Album',
              () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AlbumPage()));
                HapticFeedback.lightImpact();
              },
            ),
            MyTile(context, Icons.queue_music_sharp, 'Playlist', () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlayListScreen()));
              HapticFeedback.lightImpact();
            }),
            MyTile(context, Icons.loop_sharp, 'Most Played Song', () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => MostPlayedSong())));
            }),
            MyTile(
                context,
                Icons.settings_outlined,
                'Settings',
                () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsScreen()))),
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}

Widget MyTile(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback voidCallback,
) {
  return Column(
    children: [
      ListTile(
        tileColor: Colors.black.withOpacity(.08),
        leading: CircleAvatar(
          backgroundColor: Colors.black38,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        onTap: voidCallback,
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: Colors.white,
        ),
      ),
      Container(
        height: 5.h,
        width: MediaQuery.of(context).size.width,
      ),
    ],
  );
}