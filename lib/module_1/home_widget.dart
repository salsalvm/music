import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/module_1/favourite_widget.dart';

import 'package:music/module_1/home_screen.dart';
import 'package:music/module_1/recent_widget.dart';
import 'package:music/module_2/most_played_screen.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/setting_screen.dart';

import 'package:music/MAIN/widget.dart';

import 'package:music/module_4/album_screen.dart';
import 'package:music/module_4/playlist_screen.dart';

class MusicList extends StatelessWidget {
  final leadImage;
  final String songName;
  final String singerName;
  final favour;
  MusicList(
      {required this.leadImage,
      required this.songName,
      required this.singerName,
      this.favour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
          color: boxtColor, borderRadius: BorderRadius.circular(15)),
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

// whole music

Widget collectionsListview() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
    child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return MusicList(
            leadImage: musicCollection[index]['leadImage'],
            songName: musicCollection[index]['songName'],
            singerName: musicCollection[index]['singerName'],
            favour: index % 4 == 0 ? Colors.white : Colors.red[800],
          );
        }),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: musicCollection.length),
  );
}

// favourites

Widget favouriteListview() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
    child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return MusicList(
            leadImage: favoritesSong[index]['leadImage'],
            songName: favoritesSong[index]['songName'],
            singerName: favoritesSong[index]['singerName'],
            favour: Colors.red[800],
          );
        }),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: favoritesSong.length),
  );
}

// recent

Widget recentListView(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
    child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return MusicList(
            leadImage: recentSong[index]['leadImage'],
            songName: recentSong[index]['songName'],
            singerName: recentSong[index]['singerName'],
            favour: Colors.red[800],
          );
        }),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: recentSong.length),
  );
}

// menu items

Widget stackItems(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      CircleAvatar(
        backgroundColor: Colors.black12,
        radius: 35,
        child: IconButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => HomeScreen()))),
          icon: Icon(
            Icons.dark_mode,color: Colors.black,
            size: 30,
          ),
          color: Colors.white,
        ),
      ),
      Column(
        children: [
          MyTile(
            context,
            Icons.library_add_check_rounded,
            'Album',
            () {
               Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AlbumPage()));
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
      SizedBox(),
    ],
  );
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
          backgroundColor: Colors.black12,
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
      divider(context)
    ],
  );
}

Widget divider(BuildContext context) {
  return Container(
    height: 5,
    width: MediaQuery.of(context).size.width,
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

Widget popupMenuHoriz(BuildContext context) {
  return PopupMenuButton(
    color: darkBlue,
    icon: Icon(
      Icons.more_vert_outlined,
      color: textWhite,
    ), //don't specify icon if you want 3 dot menu
    // color: Colors.blue,
    itemBuilder: (context) => [
      PopupMenuItem(
        onTap: () {},
        value: 0,
        child: Text(
          "Add to Playlist",
          style: TextStyle(color: textWhite),
        ),
      ),
      PopupMenuItem(
        onTap: () {},
        value: 1,
        child: Text(
          "View Details",
          style: TextStyle(color: textWhite),
        ),
      ),
      PopupMenuItem(
        onTap: () {
          showAlertDialog(context);
        },
        value: 2,
        child: Text(
          "Delete Song",
          style: TextStyle(color: textWhite),
        ),
      ),
    ],
    onSelected: (item) => {print(item)},
  );
}

Widget bottomNavigation(BuildContext context) {
  return ListTile(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => NowPlaying())));
    
    },
    leading: const CircleAvatar(
      radius: 30,
      // backgroundColor: Colors.transparent,
      backgroundImage: AssetImage('lib/assets/bheeshma.jpeg'),
    ),
    title: Text(
      'Parudheesa',
      style: TextStyle(color: textWhite),
    ),
    subtitle: Text('sree nadh bhasi', style: TextStyle(color: textGrey)),
    trailing: Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 20),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: IconButton(
                onPressed: () {},
                icon: 
                // Container(
                //   decoration: BoxDecoration(
                //       color: textWhite,
                //       borderRadius: BorderRadius.circular(50)),
                  // child:
                   Icon(
                    Icons.skip_previous_rounded,
                    color: textWhite,
                    size: 30,
                  // ),
                )),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                EvaIcons.playCircle,
                color: textWhite,
                size: 45,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 6.0,left: 12),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.skip_next_rounded,
                  color: textWhite,
                  size: 30,
                )),
          ),
        ],
      ),
    ),
  );
}
