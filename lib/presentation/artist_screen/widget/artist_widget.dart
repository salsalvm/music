import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/artist_screen/artist_screen.dart';
import 'package:music/presentation/home/widget/miniplayer.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistyDetailed extends StatelessWidget {
  ArtistyDetailed({
    Key? key,
    // required this.imageId,
    required this.albumId,
    required this.albumName,
  }) : super(key: key);

  final int albumId;
  final String albumName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const MiniPlayer(),
      body: FutureBuilder<List<SongModel>>(
          future: audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID, albumId,
              sortType: SongSortType.TITLE),
          builder: (context, AsyncSnapshot<List<SongModel>> item) {
            return Column(
              children: [
                Container(
                  color: Colors.teal,
                  height: 400,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: QueryArtworkWidget(
                      id: albumId,
                      type: ArtworkType.ALBUM,
                      artworkFit: BoxFit.cover,
                      artworkBorder: BorderRadius.circular(0),
                      quality: 100,
                      size: 400,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        color: textWhite,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: Center(
                      child: Text(
                    albumName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                      SongModel songModel = item.data![index];
                      List<Audio> albumlistSongs = [];

                      for (var songs in item.data!) {
                        albumlistSongs.add(
                          Audio.file(
                            songs.uri.toString(),
                            metas: Metas(
                              title: songs.title,
                              artist: songs.artist,
                              id: songs.id.toString(),
                            ),
                          ),
                        );
                      }

                      return ListTile(
                        onTap: () async {
                          await player.open(
                              Playlist(
                                  audios: albumlistSongs, startIndex: index),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                              notificationSettings: const NotificationSettings(
                                  stopEnabled: false));
                        },
                        leading: SizedBox(
                            width: 45,
                            height: 45,
                            child: Center(child: Text('${index + 1}',style: const TextStyle(color: textWhite)))),
                        title: Text(songModel.title,style: const TextStyle(color: textWhite)),
                        subtitle: Text(songModel.artist ?? 'unknown',style: const TextStyle(color: textWhite)),
                      );
                    })
              ],
            );
          }),
    );
  }
}
