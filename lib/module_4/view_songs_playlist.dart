import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/favourite_screen.dart';
import 'package:music/module_4/refactor/bottomsheet_dbsong.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListSongs extends StatefulWidget {
  String playlistName;
  PlayListSongs({
    Key? key,
    required this.playlistName,
  }) : super(key: key);

  @override
  State<PlayListSongs> createState() => _PlayListSongsState();
}

class _PlayListSongsState extends State<PlayListSongs> {
  List<Songs> playlistSongs = [];
  List<Audio> playPlaylist = [];
  @override
  void initState() {
    playlistSongs = box.get(widget.playlistName)!.cast<Songs>();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: Text(widget.playlistName),
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
                            playListName: widget.playlistName,
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
                playlistSongs = box.get(widget.playlistName)!.cast<Songs>();
                // songCount
                return playlistSongs.isEmpty
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
                                  id: playlistSongs[index].id!,
                                  type: ArtworkType.AUDIO),
                              title: Padding(
                                padding: EdgeInsets.only(
                                        left: 5.0, bottom: 3, top: 3)
                                    .r,
                                child: Text(
                                  playlistSongs[index].songname!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: textWhite, fontSize: 18.sp),
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 7.0).r,
                                child: Text(
                                  playlistSongs[index].artist!.toLowerCase(),
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
                                          box.put(widget.playlistName,
                                              playlistSongs);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                for (var element in playlistSongs) {
                                  playPlaylist.add(Audio.file(element.songurl!,
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
