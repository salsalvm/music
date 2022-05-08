import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/main.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_4/refactor/read_add_playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListSongs extends StatefulWidget {
  final playListName;

 const PlayListSongs({
    Key? key,
    required this.playListName,
  }) : super(key: key);

  @override
  State<PlayListSongs> createState() => _PlayListSongsState();
}
  List<SongsModel> playlistSongs = [];
  List<SongsModel> songs = [];

class _PlayListSongsState extends State<PlayListSongs> {
  final box = PlaylistBox.getInstance();
  List<SongsModel> dbSongs = [];
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
          icon:const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 8),
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape:const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                      backgroundColor: boxColor,
                      context: context,
                      builder: (ctx) {
                        return  Container(height: 350,
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                final playlistSongs = box.get(widget.playListName)!;
                // songCount
                return playlistSongs.isEmpty
                    ? Container(
                        height: 30,
                        width: 60,
                        child: Center(child: Text('add Songs')),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(0.0),
                            padding: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                                color: boxColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                  artworkHeight: 60,
                                  artworkWidth: 60,
                                  id: playlistSongs[index].id,
                                  type: ArtworkType.AUDIO),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, bottom: 3, top: 3),
                                child: Text(
                                  playlistSongs[index].songname,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(color: textWhite, fontSize: 18),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: Text(
                                  playlistSongs[index].artist.toLowerCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: textGrey),
                                ),
                              ),
                              trailing: PopupMenuButton(
                                child: Icon(
                                  Icons.more_horiz,
                                  color: textWhite,
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
                                              margin: EdgeInsets.all(10),
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
                                      box.put(
                                          widget.playListName, playlistSongs);
                                    });
                                  }
                                },
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
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: playlistSongs.length);
              }),
        ),
      ),
    );
  }
}
