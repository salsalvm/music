import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:music/presentation/playlist_screen/widget/read_add_playlist.dart';
import 'package:music/presentation/playlist_screen/widget/form_playlist_create.dart';

class MenuHoriz extends StatelessWidget {
  final String songId;
  MenuHoriz({Key? key, required this.songId}) : super(key: key);

  List playlist = [];
  @override
  Widget build(BuildContext context) {
    final playlistName = databaseSongs(dbSongs, songId);

    return PopupMenuButton(
      color: darkBlue,
      icon: Icon(
        Icons.more_vert_outlined,
        color: textWhite,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {},
          value: 0,
          child: Text(
            "Add to Playlist",
            style: TextStyle(color: textWhite),
          ),
        ),
      ],
      onSelected: (item) => {
        if (item == 0)
          {
            playlistShowBottomSheet(context, playlistName),
          }
      },
    );
  }

  Songs databaseSongs(List<Songs> songs, String id) {
    return songs.firstWhere(
      (element) => element.songurl.toString().contains(id),
    );
  }
}

playlistShowBottomSheet(BuildContext context, playlistName) {
  return showModalBottomSheet(
      backgroundColor: black,
      context: context,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.only(
              topLeft:const Radius.circular(25.0).r,
              topRight:const Radius.circular(25).r,
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
          height: 300.h,
          width: double.infinity,
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 5).r,
            child: Stack(
              children: [
                ListView(shrinkWrap: true, children: [
                  PlayListItem(
                    song: playlistName,
                    countSong: "song",
                  )
                ]),

                //  floatting
                Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CreatePlaylistForm();
                          },
                        );
                      },
                      backgroundColor: darkBlue,
                      child:const Icon(Icons.add),
                    ))
              ],
            ),
          ),
        );
      });
}
