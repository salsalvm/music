import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:music/main.dart';

import 'package:music/module_2/most_played_screen.dart';
import 'package:music/module_3/setting_screen.dart';
import 'package:music/module_4/album_screen.dart';
import 'package:music/module_4/playlist_screen.dart';

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
          radius: 35,
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(backgroundColor: darkBlue,
                      title: Center(child: Text('Do you want to Exit',style: TextStyle(color: Colors.red[200]),)),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: () {Navigator.pop(context);}, child: Text('No',style: TextStyle(color: textWhite,fontSize: 18),)),
                            
                     
                          TextButton(onPressed: () {exit(0);}, child: Text('Yes',style: TextStyle(color: textWhite,fontSize: 18),))
      ],),
                        )],
                    );
                  });
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
              size: 35,
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

// Widget stackItems(BuildContext context ) {
//   return
// }

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
        height: 5,
        width: MediaQuery.of(context).size.width,
      ),
    ],
  );
}

// delete a song

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: textWhite),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes", style: TextStyle(color: textWhite)),
    onPressed: () {
      // signOut(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: darkBlue,
    title: Text("Delete this Song", style: TextStyle(color: textWhite)),
    content: Text("Are You Confirm ", style: TextStyle(color: textGrey)),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


// horiz

