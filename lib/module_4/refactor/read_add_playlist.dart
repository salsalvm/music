import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:on_audio_query/on_audio_query.dart';

// create play list

// get playlist

class PlayListItem extends StatelessWidget {
  // final onTap;
  SongsModel song;
  List playlists = [];
  List<dynamic>? playlistSongs = [];

  // final playListName;
  final countSong;
  PlayListItem(
      {Key? key,
      // required this.onTap,
      required this.countSong,
      required this.song})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = PlaylistBox.getInstance();
    playlists = box.keys.toList();

    return Column(
      children: [
        ...playlists
            .map(
              (playlistName) => playlistName != "music" &&
                      playlistName != "favourites"
                  ? Container(
                      decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () async {
                          playlistSongs = box.get(playlistName);
                          List existingSongs = [];
                          existingSongs = playlistSongs!
                              .where((element) =>
                                  element.id.toString() == song.id.toString())
                              .toList();
                          if (existingSongs.isEmpty) {
                            final songs = box.get("music") as List<SongsModel>;
                            final temp = songs.firstWhere((element) =>
                                element.id.toString() == song.id.toString());
                            playlistSongs?.add(temp);
                            await box.put(playlistName, playlistSongs!);

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: darkBlue,
                                content: Text(
                                  song.songname! + 'Added to Playlist',
                                  style: TextStyle(color: textWhite),
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              song.songname! + 'is Already in Playlist.',
                              style: TextStyle(color: textWhite),
                            )));
                          }
                        },
                        leading: Padding(
                          padding:  EdgeInsets.only(left: 6.0.w, top: 5.h),
                          child: Icon(
                            Icons.queue_music_rounded,
                            color: textWhite,
                            size: 30.w.h,
                          ),
                        ),

                        // playlist name
                        title: Padding(
                          padding:  EdgeInsets.only(
                              left: 3.0.w, bottom: 3.h, top: 5.h),
                          child: Text(
                            playlistName.toString(),
                            style: TextStyle(color: textWhite, fontSize: 18.w.h),
                          ),
                        ),
                        subtitle: Padding(
                          padding:  EdgeInsets.only(left: 3.0.w),
                          child: Text(
                            countSong,
                            style: TextStyle(
                              color: textGrey,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            )
            .toList()
      ],
    );
  }
}

// add song to playlis box

class AddSongBox extends StatefulWidget {
  String playListName;

  AddSongBox({Key? key, required this.playListName}) : super(key: key);

  @override
  State<AddSongBox> createState() => _AddSongBoxState();
}

class _AddSongBoxState extends State<AddSongBox> {
  final box = PlaylistBox.getInstance();
  List<SongsModel> dbSong = [];
  List<SongsModel> playListsong = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbSong = box.get("music") as List<SongsModel>;
    playListsong = box.get(widget.playListName)!.cast<SongsModel>();
  }

  @override
  Widget build(BuildContext context) {
    // final dbSong=
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: ((context, value, child) {
             

          return ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding:
                     EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: ListTile(
                    tileColor: boxColor,
                    // onTap: (() async {
                    //   await OpenPlayer(
                    //           fullSongs: [], index: index)
                    //       .openAssetPlayer(
                    //     index: index,
                    //     songs: fullSongs,
                    //   );
                    // }),
                    leading: QueryArtworkWidget(
                      id: dbSong[index].id!,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 55.h,
                      artworkWidth: 55.w,
                    ),
                    title: Padding(
                      padding:
                           EdgeInsets.only(left: 5.0.w, bottom: 3.h, top: 3.h),
                      child: Text(
                        dbSong[index].songname!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textWhite, fontSize: 18.w.h),
                      ),
                    ),
                    subtitle: Padding(
                      padding:  EdgeInsets.only(left: 7.0.w),
                      child: Text(
                        dbSong[index].artist!.toLowerCase(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textGrey),
                      ),
                    ),
                    trailing: playListsong
                            .where((element) =>
                                element.id.toString() ==
                                dbSong[index].id.toString())
                            .isEmpty
                        ? IconButton(
                            onPressed: () { setState(() {});
                              playListsong.add(dbSong[index]);
                              box.put(widget.playListName, playListsong);
                              
                              // setState(() {});
                            },
                            icon:  Icon(
                              Icons.playlist_add,
                              size: 35.w.h,
                              color: Colors.green,
                            ))
                        : IconButton(
                            onPressed: () { setState(() {});
                              playListsong.removeWhere((element) =>
                                  element.id.toString() ==
                                  dbSong[index].id.toString());
                              box.put(widget.playListName, playListsong);
                             
                            },
                            icon:  Icon(Icons.playlist_add_check,
                                size: 35.w.h, color: Colors.red))),
              );
            }),
            itemCount: dbSong.length,
          );
        }));
  }
}
