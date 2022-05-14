import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/main.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/2-favourite_screen.dart';
import 'package:music/module_4/refactor/read_add_playlist.dart';
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
  final box = PlaylistBox.getInstance();

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
            padding:  EdgeInsets.only(right: 10.0.w, top: 8.h),
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape:  RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25.w.h))),
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
          padding:  EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.h),
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                var playlistSongs = box.get(widget.playListName);
                // songCount
                return playlistSongs!.isEmpty
                    ? Center(
                        child: Container(
                          child:const Text(
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
                                borderRadius: BorderRadius.circular(15.w.h)),
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                  artworkHeight: 60.h,
                                  artworkWidth: 60.w,
                                  id: playlistSongs[index].id,
                                  type: ArtworkType.AUDIO),
                              title: Padding(
                                padding:  EdgeInsets.only(
                                    left: 5.0.w, bottom: 3.h, top: 3.h),
                                child: Text(
                                  playlistSongs[index].songname,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(color: textWhite, fontSize: 18.w.h),
                                ),
                              ),
                              subtitle: Padding(
                                padding:  EdgeInsets.only(left: 7.0.w),
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
                                      padding:  EdgeInsets.only(
                                          top: 11.0.h, left: 5.w),
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
                                                  margin: EdgeInsets.all(10.w.h),
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
                                        fullSongs: playPlaylist, index: index)
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
                          return  SizedBox(
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
