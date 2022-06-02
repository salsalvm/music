import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:music/presentation/widget/open_palyer.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:music/presentation/favourites_screen/widget/add_favourites_song.dart';
import 'package:music/presentation/widget/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteIcon extends StatefulWidget {
  final String songId;

  const FavouriteIcon({Key? key, required this.songId}) : super(key: key);

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
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
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                    shrinkWrap: true,
                    itemCount: favouritesSongs.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(15).r),
                        child: ListTile(
                          onTap: () {
                            for (var item in favouritesSongs) {
                              favSong.add(Audio.file(item.songurl,
                                  metas: Metas(
                                      id: item.id.toString(),
                                      artist: item.artist,
                                      title: item.songname)));
                            }
                            OpenPlayer(
                                    fullSongs: favSong,
                                    index: index,
                                    songId: favSong[index].metas.id.toString())
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
                                    top: 3, left: 5, bottom: 3)
                                .r,
                            child: Text(
                              favouritesSongs[index].songname,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: textWhite, fontSize: 18.sp),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8.0).r,
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
              ).r,
              child: Container(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: darkBlue,
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: const Radius.circular(25).r)),
                        backgroundColor: boxColor,
                        context: context,
                        builder: (ctx) {
                          return SizedBox(
                              height: 350.h, child: const AddSongFavourites());
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

Songs databaseSongs(List<Songs> songs, String id) {
  return songs.firstWhere((element) => element.id.toString().contains(id));
}
