import 'package:flutter/material.dart';
import 'package:music/main.dart';
import 'package:music/module_2/refactor/nowplaying_function.dart';
import 'package:music/module_4/create_playlist_bottom.dart';

class MenuHoriz extends StatelessWidget {
  const MenuHoriz({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
         
        },
        value: 2,
        child: Text(
          "Delete Song",
          style: TextStyle(color: textWhite),
        ),
      ),
    ],
    onSelected: (item) => {if (item==0) {
      PlayListShowBottomSheet(context),
    }},
  );
  }
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
                ListView.builder(
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
