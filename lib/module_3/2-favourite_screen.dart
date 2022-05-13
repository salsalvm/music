import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_1/home.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/refactor/add_favourites_song.dart';
import 'package:music/module_4/refactor/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteIcon extends StatefulWidget {
  final String songId;

  FavouriteIcon({Key? key, required this.songId}) : super(key: key);

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  final box = PlaylistBox.getInstance();

  List favouritesSong = [];

  @override
  Widget build(BuildContext context) {
    final favouritesSong = box.get("favourites");
    final fav = databaseSongs(dbSongs, widget.songId);

    return
        // songId==0
        favouritesSong!
                .where((element) => element.id.toString() == fav.id.toString())
                .isEmpty
            ? IconButton(
                onPressed: () async {
                  favouritesSong.add(fav);

                  await box.put("favourites", favouritesSong);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ))
            : IconButton(
                onPressed: () async {
                  favouritesSong.removeWhere(
                      (element) => element.id.toString() == fav.id.toString());
                  await box.put("favourites", favouritesSong);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ));
  }
}

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

List<Audio> favSong = [];

class _FavouriteScreenState extends State<FavouriteScreen> {
  final box = PlaylistBox.getInstance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, value, child) {
        final favouritesSongs = box.get("favourites");
        return Stack(
          children: [
            favouritesSongs!.isEmpty
                ? Container(
                    child: const Center(
                      child: Text(
                        'no favourites songs',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: favouritesSongs.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          onTap: () {
                            for (var item in favouritesSongs) {
                              favSong.add(Audio.file(item.songurl,
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
                                        allSongs: favSong,
                                        index: index,
                                        songId: favSong[index].metas.id!))));
                          },
                          leading: QueryArtworkWidget(
                              id: favouritesSongs[index].id,
                              type: ArtworkType.AUDIO),
                          title: Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 5, bottom: 3),
                            child: Text(
                              favouritesSongs[index].songname,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: textWhite, fontSize: 18),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              favouritesSongs[index].artist,
                              style: TextStyle(color: textGrey),
                            ),
                          ),
                          trailing: Wrap(
                            children: [
                              FavouriteIcon(
                                  songId: favouritesSongs[index].id.toString()),
                              MenuHoriz(
                                  songId: favouritesSongs[index].id.toString())
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                top: 480.0,
              ),
              child: Container(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: darkBlue,
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25))),
                        backgroundColor: boxColor,
                        context: context,
                        builder: (ctx) {
                          return Container(
                              height: 350, child: AddSongFavourites());
                        });
                  },
                  child: Icon(Icons.add, color: textWhite),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

SongsModel databaseSongs(List<SongsModel> songs, String id) {
  return songs.firstWhere((element) => element.id.toString().contains(id));
}
