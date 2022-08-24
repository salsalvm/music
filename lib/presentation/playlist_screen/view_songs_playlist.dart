import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/favourites_screen/widget/favourite_icon_add.dart';
import 'package:music/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:music/presentation/widget/open_palyer.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:music/presentation/playlist_screen/widget/bottomsheet_dbsong.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListSongs extends StatelessWidget {
  String playlistName;
  PlayListSongs({
    Key? key,
    required this.playlistName,
  }) : super(key: key);

  List<Songs> playlistSongs = [];
  
  @override
  Widget build(BuildContext context) {
    playlistSongs = box.get(playlistName)!.cast<Songs>();
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: Text(playlistName),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 8).r,
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: const Radius.circular(25).r)),
                      backgroundColor: boxColor,
                      context: context,
                      builder: (ctx) {
                        return SizedBox(
                          height: 350.h,
                          child: AddSongBox(
                            playListName: playlistName,
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10).r,
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                playlistSongs = box.get(playlistName)!.cast<Songs>();
                List<Audio> playPlaylist = [];
                // songCount
                return playlistSongs.isEmpty
                    ? const Center(
                        child: SizedBox(
                          child: Text(
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
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note,
                                    color: textWhite,
                                    size: 30,
                                  ),
                                  artworkHeight: 60.h,
                                  artworkWidth: 60.w,
                                  id: playlistSongs[index].id!,
                                  type: ArtworkType.AUDIO),
                              title: Padding(
                                padding: const EdgeInsets.only(
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
                                padding: const EdgeInsets.only(left: 7.0).r,
                                child: Text(
                                  playlistSongs[index].artist!.toLowerCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: textGrey),
                                ),
                              ),
                              trailing: Wrap(
                                children: [
                                  FavouriteIcon(
                                      songId:
                                          playlistSongs[index].id.toString()),
                                  PopupMenuButton(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                              top: 11.0, left: 5)
                                          .r,
                                      child: const Icon(
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
                                                  margin:
                                                      const EdgeInsets.all(10)
                                                          .r,
                                                  content: Text(
                                                      '${playlistSongs[index].songname} Song Removed ')));
                                        },
                                        child: const Text(
                                          'Remove song',
                                          style: TextStyle(color: textGrey),
                                        ),
                                        value: "1",
                                      ),
                                    ],
                                    onSelected: (value) {
                                      if (value == "1") {
                                        playlistSongs.removeAt(index);
                                        box.put(playlistName, playlistSongs);
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
