import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/main.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/favourite_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListSongs extends StatefulWidget {
  final String playListName;
  const PlayListSongs({
    Key? key,
    required this.playListName,
  }) : super(key: key);

  @override
  State<PlayListSongs> createState() => _PlayListSongsState();
}

class _PlayListSongsState extends State<PlayListSongs> {
  List<SongsModel> playlistSongs = [];
  List<Audio> playPlaylist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: Text(widget.playListName),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0, top: 8).r,
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25).r)),
                      backgroundColor: boxColor,
                      context: context,
                      builder: (ctx) {
                        return Container(
                          height: 350.h,
                          child: AddSongBox(
                            playListName: widget.playListName,
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.add_sharp)),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10).r,
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                var playlistSongs = box.get(widget.playListName);
                // songCount
                return playlistSongs!.isEmpty
                    ? Center(
                        child: Container(
                          child: const Text(
                            'add Songs',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: boxColor,
                                borderRadius: BorderRadius.circular(15).r),
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                  artworkHeight: 60.h,
                                  artworkWidth: 60.w,
                                  id: playlistSongs[index].id,
                                  type: ArtworkType.AUDIO),
                              title: Padding(
                                padding: EdgeInsets.only(
                                        left: 5.0, bottom: 3, top: 3)
                                    .r,
                                child: Text(
                                  playlistSongs[index].songname,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: textWhite, fontSize: 18.sp),
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 7.0).r,
                                child: Text(
                                  playlistSongs[index].artist.toLowerCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: textGrey),
                                ),
                              ),
                              trailing: Wrap(
                                children: [
                                  FavouriteIcon(
                                      songId:
                                          playlistSongs[index].id.toString()),
                                  PopupMenuButton(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 11.0, left: 5).r,
                                      child: Icon(
                                        Icons.more_vert,
                                        color: textWhite,
                                      ),
                                    ),
                                    color: darkBlue,
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor: boxColor,
                                                  margin: EdgeInsets.all(10).r,
                                                  content: Text(
                                                      '${playlistSongs[index].songname} Song Removed ')));
                                        },
                                        child: Text(
                                          'Remove song',
                                          style: TextStyle(color: textGrey),
                                        ),
                                        value: "1",
                                      ),
                                    ],
                                    onSelected: (value) {
                                      if (value == "1") {
                                        setState(() {
                                          playlistSongs.removeAt(index);
                                          box.put(widget.playListName,
                                              playlistSongs);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                for (var element in playlistSongs) {
                                  playPlaylist.add(Audio.file(element.songurl,
                                      metas: Metas(
                                          title: element.songname,
                                          id: element.id.toString(),
                                          artist: element.artist)));
                                }
                                OpenPlayer(
                                        fullSongs: playPlaylist,
                                        index: index,
                                        songId: playPlaylist[index]
                                            .metas
                                            .id
                                            .toString())
                                    .openAssetPlayer(
                                        index: index, songs: playPlaylist);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => NowPlaying(
                                            songId: playPlaylist[index]
                                                .metas
                                                .id
                                                .toString(),
                                            allSongs: playPlaylist,
                                            index: index))));
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: playlistSongs.length);
              }),
        ),
      ),
    );
  }
}

class AddSongBox extends StatefulWidget {
  String playListName;

  AddSongBox({Key? key, required this.playListName}) : super(key: key);

  @override
  State<AddSongBox> createState() => _AddSongBoxState();
}

class _AddSongBoxState extends State<AddSongBox> {
  List<SongsModel> playListsong = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    playListsong = box.get(widget.playListName)!.cast<SongsModel>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: ((context, value, child) {
          return ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
                child: ListTile(
                    tileColor: boxColor,
                    leading: QueryArtworkWidget(
                      id: dbSongs[index].id!,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 55.h,
                      artworkWidth: 55.w,
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
                      child: Text(
                        dbSongs[index].songname!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textWhite, fontSize: 18.sp),
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(left: 7.0).r,
                      child: Text(
                        dbSongs[index].artist!.toLowerCase(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textGrey),
                      ),
                    ),
                    trailing: playListsong
                            .where((element) =>
                                element.id.toString() ==
                                dbSongs[index].id.toString())
                            .isEmpty
                        ? IconButton(
                            onPressed: () {
                              playListsong.add(dbSongs[index]);
                              box.put(widget.playListName, playListsong);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.playlist_add,
                              size: 35.sp,
                              color: Colors.green,
                            ))
                        : IconButton(
                            onPressed: () {
                              setState(() {});
                              playListsong.removeWhere((element) =>
                                  element.id.toString() ==
                                  dbSongs[index].id.toString());
                              box.put(widget.playListName, playListsong);
                            },
                            icon: Icon(Icons.playlist_add_check,
                                size: 35.sp, color: Colors.red))),
              );
            }),
            itemCount: dbSongs.length,
          );
        }));
  }
}
