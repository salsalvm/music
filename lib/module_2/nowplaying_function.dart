import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:music/main.dart';

class PlayListItem extends StatelessWidget {
  final onTap;
  final playListName;
  final countSong;
  const PlayListItem(
      {Key? key,
      required this.onTap,
      required this.countSong,
      required this.playListName})
      : super(key: key);

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
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

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
        ),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}

createPlaylistShowAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel", style: TextStyle(color: textWhite, fontSize: 16)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Create", style: TextStyle(color: textWhite, fontSize: 16)),
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: boxtColor,
          margin: EdgeInsets.all(10),
          content: Text('Playlist Added ')));
      Navigator.pop(context);
    
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: darkBlue,
    alignment: Alignment.center,
    title: Center(
        child: Text(
      "Give Your Playlist Name",
      style: TextStyle(color: textWhite),
    )),
    content: TextFormField(
        style: TextStyle(color: textWhite),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textWhite, width: 5)),
          fillColor: textWhite,
          hintText: 'Playlist Name',
          hintStyle: TextStyle(color: textGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textGrey, width: 5.0),
          ),
        )),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ),
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

PlayListShowBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: black,
      context: context,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: boxtColor,
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
          height: 300,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return PlayListItem(
                        playListName: 'Ever green',
                        countSong: '5 song',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: boxtColor,
                              margin: EdgeInsets.all(10),
                              content: Text('Song Added ')));
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                        createPlaylistShowAlertDialog(context);
                      },
                      backgroundColor: darkBlue,
                      child: Icon(Icons.add),
                    ))
              ],
            ),
          ),
        );
      });
}
