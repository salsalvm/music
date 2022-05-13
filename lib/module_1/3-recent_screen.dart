
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/2-favourite_screen.dart';
import 'package:music/module_4/refactor/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentSongs extends StatefulWidget {
  const RecentSongs({Key? key}) : super(key: key);

  @override
  State<RecentSongs> createState() => _RecentSongsState();
}

List<Audio>recent=[];
class _RecentSongsState extends State<RecentSongs> {
  @override
  Widget build(BuildContext context) {
    final box = PlaylistBox.getInstance();

    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, value, child) {
        final recentPlayedSong = box.get("recentPlayed");
        return recentPlayedSong!.isEmpty
            ? Container(
                child: const Center(
                  child: Text(
                    'no recent played  songs',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemCount: recentPlayedSong.length,
                itemBuilder: ((context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () {
                        for (var item in recentPlayedSong) {
                          recent.add(Audio.file(item.songurl,
                              metas: Metas(
                                  id: item.id.toString(),
                                  artist: item.artist,
                                  title: item.songname)));
                        }
                        OpenPlayer(fullSongs: favSong, index: index)
                            .openAssetPlayer(index: index, songs: favSong);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => NowPlaying(
                                    allSongs: recent,
                                    index: index,
                                    songId: recent[index].metas.id!))));
                      },
                      leading: QueryArtworkWidget(
                          id: recentPlayedSong[index].id,
                          type: ArtworkType.AUDIO),
                      title: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 5, bottom: 3),
                        child: Text(
                          recentPlayedSong[index].songname,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textWhite, fontSize: 18),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          recentPlayedSong[index].artist,
                          style: TextStyle(color: textGrey),
                        ),
                      ),
                      trailing: Wrap(
                        children: [
                          FavouriteIcon(
                              songId: recentPlayedSong[index].id.toString()),
                          MenuHoriz(
                              songId: recentPlayedSong[index].id.toString())
                        ],
                      ),
                    ),
                  );
                }),
              );
      },
    );
  }
}
