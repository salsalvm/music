import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/favourites_screen/widget/favourite_icon_add.dart';
import 'package:music/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:music/presentation/widget/open_palyer.dart';
import 'package:music/presentation/widget/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentSongs extends StatelessWidget {
  RecentSongs({Key? key}) : super(key: key);

  List<Audio> recent = [];
  @override
  Widget build(BuildContext context) {
    final box = StorageBox.getInstance();
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, value, child) {
        var recentPlayedSong = box.get("recentPlayed");

        return recentPlayedSong == null
            ? const Center(child: CircularProgressIndicator())
            : recentPlayedSong.isEmpty
                ? const SizedBox(
                    child: Center(
                      child: Text(
                        'no recent played  songs',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  )
                : ListView.separated(
                    reverse: true,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                    shrinkWrap: true,
                    itemCount: recentPlayedSong.length < 15
                        ? recentPlayedSong.length
                        : 15,
                    itemBuilder: ((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(15).r),
                        child: ListTile(
                          onTap: () {
                            for (var item in recentPlayedSong) {
                              recent.add(Audio.file(item.songurl,
                                  metas: Metas(
                                      id: item.id.toString(),
                                      artist: item.artist,
                                      title: item.songname)));
                            }
                            OpenPlayer(
                                    fullSongs: recent,
                                    index: index,
                                    songId: recent[index].metas.id!)
                                .openAssetPlayer(index: index, songs: recent);
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
                            padding: const EdgeInsets.only(
                                    top: 3, left: 5, bottom: 3)
                                .r,
                            child: Text(
                              recentPlayedSong[index].songname,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: textWhite, fontSize: 18.sp),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8.0).r,
                            child: Text(
                              recentPlayedSong[index].artist,
                              style: TextStyle(color: textGrey),
                            ),
                          ),
                          trailing: Wrap(
                            children: [
                              FavouriteIcon(
                                  songId:
                                      recentPlayedSong[index].id.toString()),
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
